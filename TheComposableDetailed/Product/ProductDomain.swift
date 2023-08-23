//
//  ProductDomain.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 01/07/2023.
//

import Foundation
import ComposableArchitecture

struct ProductDomain  : ReducerProtocol {
  struct State: Equatable, Identifiable {
    let id: UUID
    let product: Product
    var addToCartState = AddToCartDomain.State()
    
    var count: Int {
      get { addToCartState.count }
      set { addToCartState.count = newValue }
    }
  }
  
  enum Action: Equatable {
    case addToCart(AddToCartDomain.Action)
  }
  
  struct Environment {}
  
  var body: some ReducerProtocol<State, Action> {
    Scope(state: \.addToCartState, action: /ProductDomain.Action.addToCart) {
      AddToCartDomain()
    }
    Reduce { state, action in
      switch action {
      case .addToCart(.didTapPlusButton):
        return .none
      case .addToCart(.didTapMinusButton):
        state.addToCartState.count = max(0, state.addToCartState.count)
        return .none
      }
    }
  }
}
