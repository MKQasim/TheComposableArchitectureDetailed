//
//  CartItem.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 02/07/2023.
//

import SwiftUI
import ComposableArchitecture

struct CartItem : Equatable{
  var product : Product
  var quantity : Int
}

extension CartItem : Encodable{
  
  private enum CartItemCodingKey : String , CodingKey {
      case productId
      case quantity
  }
 
  func encode(to encoder: Encoder) throws {
    var container = try encoder.container(keyedBy: CartItemCodingKey.self)
    try container.encode(product.id, forKey: CartItemCodingKey.productId)
    try container.encode(quantity, forKey: CartItemCodingKey.quantity)
  }
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
