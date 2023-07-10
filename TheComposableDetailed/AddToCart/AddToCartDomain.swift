//
//  AddToCartDomain.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 01/07/2023.
//

import Foundation
import ComposableArchitecture

struct AddToCartDomain {
  struct State: Equatable {
    var count = 0
  }
  
  enum Action: Equatable {
    case didTapPlusButton
    case didTapMinusButton
  }
  
  struct Environment {
      // Future Dependencies...
  }
  
  static let reducer = Reducer<
    State, Action, Environment
  > { state, action, environment in
    switch action {
    case .didTapPlusButton:
      state.count += 1
      return Effect.none
    case .didTapMinusButton:
      state.count -= 1
      return Effect.none
    }
  }.debug()
}
