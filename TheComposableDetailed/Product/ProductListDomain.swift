//
//  ProductListDomain.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 01/07/2023.
//

import SwiftUI
import ComposableArchitecture


struct ProductListDomain {
  
  struct State : Equatable {
    var productList : IdentifiedArrayOf<ProductDomain.State> = []
    var shouldOpenCart = false
  }
  
  enum Action : Equatable{
    case fetchProducts
    case fetchProductResponse(TaskResult<[Product]>)
    case product(id:ProductDomain.State.ID,action: ProductDomain.Action)
    case setCart(isPresented:Bool)
  }
  
  struct Environment {
    var fetchProducts: () async throws -> [Product]
  }

  static let reducer = Reducer<
    State , Action, Environment
  >.combine(
    ProductDomain.reducer.forEach(
      state: \.productList,
      action: /Action.product(id:action:),
      environment: { _ in ProductDomain.Environment() }
    ),
    .init{ state, action , environment in
      switch action {
      case .fetchProducts:
        print("fetch Products")
        return .task {
          await .fetchProductResponse(TaskResult{
            try await environment.fetchProducts()
          })
        }
      case .fetchProductResponse(.success(let product)):
        state.productList = IdentifiedArray(uniqueElements: product
          .map{
            ProductDomain.State(id: UUID(), product: $0)
        })
        return .none
      case .fetchProductResponse(.failure(let error)):
        print(error)
        print("unable to fetch products")
        return .none
      case .product:
        return .none
      case .setCart(let isPresented):
        state.shouldOpenCart = isPresented
        return .none
      }
      return .none
    }
  ).debug()
}
