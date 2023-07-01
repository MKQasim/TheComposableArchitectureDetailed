//
//  AddToCartDomain.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 01/07/2023.
//

import Foundation
import ComposableArchitecture

struct AddToCartDomain {
  struct State : Equatable {
    var count = 0
  }
  
  enum Action : Equatable {
    case didTapPlusAction
    case didTapMinusAction
  }
  
  struct Environment : Equatable {
    
  }
  
  static let reducer = Reducer<State,Action,Environment>{
    state , action , environment in
    switch action {
    case .didTapPlusAction :
    
      state.count += 1
      return .none
    case .didTapMinusAction :
     
      state.count -= 1
      return .none  
    default: break
    }
  }
}
