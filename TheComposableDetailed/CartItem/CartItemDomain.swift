  //
  //  CartItemDomain.swift
  //  TheComposableDetailed
  //
  //  Created by KamsQue on 02/07/2023.
  //

import Foundation
import ComposableArchitecture

struct CartItemDomain {
  struct State: Equatable , Identifiable{
    let id : UUID
    let cartItem: CartItem
  }
  
  enum Action : Equatable {
    case deleteCartItem(product : Product)
  }
  
  struct Environment  {
    
  }
  
  static let reducer = Reducer<
    State, Action,Environment
  >{ state , action , enviroment in
    switch action {
    case .deleteCartItem :
      return .none
    }
  }.debug()
}
