//
//  StateMachineBase.swift
//  StateMachineBase
//
//  Created by David on 2019/5/12.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation
import PromiseKit

open class StateMachineBase<State: Hashable, Event: Hashable> {
  
  private let workingQueue = DispatchQueue(label: "io.david.state_machine.working_queue")
  private let lockQueue = DispatchQueue(label: "io.david.state_machine.lock_queue")
  private let callbackQueue: DispatchQueue
  
  public var enableLogging: Bool = true
  public var currentState: State {
    return workingQueue.sync {
      return internalCurrentState
    }
  }
  
  public typealias StateTransitionBox = StateTransition<State, Event>
  private var internalCurrentState: State
  private var transitionsByEvent: [Event : [StateTransitionBox]] = [:]
  
  public init(initialState: State, callbackQueue: DispatchQueue? = nil) {
    self.internalCurrentState = initialState
    self.callbackQueue = callbackQueue ?? .main
  }
  
  public func add(stateTransitions transitions: StateTransitionBox...) {
    transitions.forEach(add)
  }
  
  public func add(stateTransition transition: StateTransitionBox) {
    lockQueue.sync {
      if let transitions = transitionsByEvent[transition.event] {
        if (transitions.filter({ $0.source == transition.source }).count > 0) {
          assertionFailure("Transition with event '\(transition.event)' and source '\(transition.source)' already exists.")
        }  
        transitionsByEvent[transition.event]?.append(transition)
      } else {
        transitionsByEvent[transition.event] = [transition]
      }
    }
  }
  
  public func process(event: Event, execution: ExecutableBlock? = nil) -> Guarantee<StateTransitionResult> {
    return Guarantee { seal in 
      process(event: event, execution: execution, callback: { result in 
        seal(result)
      })
    }
  }
  
  public func process(event: Event, execution: ExecutableBlock? = nil, callback: TransitionResultBlock? = nil) {
    var transitions: [StateTransitionBox]?
    lockQueue.sync {
      transitions = self.transitionsByEvent[event]
    }
    
    workingQueue.async(flags: .barrier) {
      let performableTransitions = transitions?.filter({ $0.source == self.internalCurrentState }) ?? []
      
      if performableTransitions.count == 0 {
        self.log(message: "Unable to process event '\(event)' from current state '\(self.internalCurrentState)'.")
        self.callbackQueue.async {
          callback?(.failure)
        }
        return
      }
      
      assert(performableTransitions.count == 1, "Found multiple transitions with event '\(event)' and source '\(self.internalCurrentState)'.")
      
      let transition = performableTransitions.first!
      
      self.log(message: "Processing event '\(event)' from \(self.internalCurrentState).")
      self.callbackQueue.async {
        transition.executePreBlock()
      }
      
      self.log(message: "Processed pre condition for event '\(event)' from '\(transition.source)' to '\(transition.destination)'.")
      
      self.callbackQueue.async {
        execution?()
      }
      
      let previousState = self.internalCurrentState
      self.internalCurrentState = transition.destination
      
      self.log(message: "Processed state change from '\(previousState)' to '\(self.internalCurrentState)'.")
      self.callbackQueue.async {
        transition.executePostBlock()
      }
      
      self.log(message: "Processed post condition for event '\(event)' from '\(transition.source)' to '\(transition.destination)'.")
      
      self.callbackQueue.async {
        callback?(.success)
      }
    }
  }
  
  private func log(message: String) {
    if enableLogging {
      print("[StateMachine 🤖] \(message)")
    }
  }
  
}
