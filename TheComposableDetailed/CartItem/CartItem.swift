//
//  CartItem.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 02/07/2023.
//

import SwiftUI
import ComposableArchitecture

struct CartItem : Equatable{
  let product : Product
  let quantity : Int
}

extension CartItem{
  static var sample : [CartItem] {
    [
      .init(
        product: Product.sample[0], quantity: 3
      ),
      .init(
        product: Product.sample[1], quantity: 1
      ),
      .init(product: Product.sample[2], quantity: 1
      ),
    ]
  }
}
