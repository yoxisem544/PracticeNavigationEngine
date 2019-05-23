//
//  StateTransition.swift
//  StateMachine
//
//  Created by David on 2019/5/12.
//  Copyright © 2019 David. All rights reserved.
//

import Foundation

public enum StateTransitionResult {
  case success
  case failure
}

public typealias ExecutableBlock = (() -> Void)
public typealias TransitionResultBlock = ((StateTransitionResult) -> Void)

public struct StateTransition<State, Event> {
  
  public let event: Event
  public let source: State
  public let destination: State
  let preBlock: ExecutableBlock?
  let postBlock: ExecutableBlock?
  
  public init(on event: Event, 
              from: State,
              to: State, 
              preBlock: ExecutableBlock? = nil,
              postBlock: ExecutableBlock? = nil) {
    self.event = event
    self.source = from
    self.destination = to
    self.preBlock = preBlock
    self.postBlock = postBlock
  }
  
  func executePreBlock() {
    preBlock?()
  }
  
  func executePostBlock() {
    postBlock?()
  }
  
  static func on(event: Event, 
                 stateChangeFrom from: State,
                 to: State,
                 preBlock: ExecutableBlock? = nil,
                 postBlock: ExecutableBlock? = nil) -> StateTransition {
    return StateTransition(on: event, 
                           from: from, 
                           to: to, 
                           preBlock: preBlock, 
                           postBlock: postBlock)
  }
  
}
