//
//  AddToCartDomain.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 01/07/2023.
//

import Foundation
import ComposableArchitecture

struct AddToCartDomain : ReducerProtocol{

  struct State: Equatable {
    var count = 0
  }
  
  enum Action: Equatable {
    case didTapPlusButton
    case didTapMinusButton
  }

  func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
    switch action {
    case .didTapPlusButton:
      state.count += 1
      return Effect.none
    case .didTapMinusButton:
      state.count -= 1
      return Effect.none
    }
  }
}
