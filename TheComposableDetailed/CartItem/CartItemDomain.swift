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
    
  }
  
  struct Environment  {
    
  }
  
  static let reducer = Reducer<
  State, Action,Environment
  >{ state , action , enviroment in
    
    return .none
  }
}
