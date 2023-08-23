//
//  ProductListDomain.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 01/07/2023.
//

import SwiftUI
import ComposableArchitecture


struct ProductListDomain : ReducerProtocol {
 
  struct State: Equatable {
    var dataLoadingStatus = DataLoadingStatus.notStarted
    var productList: IdentifiedArrayOf<ProductDomain.State> = []
    var cartState: CartListDomain.State?
    var shouldOpenCart = false
    
    var shouldShowError : Bool {
      dataLoadingStatus == .error
    }
    
    var isLoading : Bool {
      dataLoadingStatus == .loading
    }
    
  }
  
  enum Action: Equatable {
    case fetchProducts
    case fetchProductsResponse(TaskResult<[Product]>)
    case setCartView(isPresented: Bool)
    case cart(CartListDomain.Action)
    case product(id: ProductDomain.State.ID, action: ProductDomain.Action)
    case resetProduct(product: Product)
    case closeCart
  }
  
  var fetchProducts:  @Sendable () async throws -> [Product]
  var sendOrder:  @Sendable ([CartItem]) async throws -> String
  var uuid: @Sendable () -> UUID
  
  struct Environment {
    var fetchProducts: () async throws -> [Product]
    var sendOrder : ([CartItem]) async throws -> String
  }
  
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .fetchProducts:
        if state.dataLoadingStatus == .success || state.dataLoadingStatus == .loading {
          return .none
        }
        
        state.dataLoadingStatus = .loading
        return .task {
          await .fetchProductsResponse(
            TaskResult { try await fetchProducts() }
          )
        }
      case .fetchProductsResponse(.success(let products)):
        state.dataLoadingStatus = .success
        state.productList = IdentifiedArrayOf(
          uniqueElements: products.map {
            ProductDomain.State(
              id: uuid(),
              product: $0
            )
          }
        )
        return .none
      case .fetchProductsResponse(.failure(let error)):
        state.dataLoadingStatus = .error
        print(error)
        print("Error getting products, try again later.")
        return .none
      case .cart(let action):
        switch action {
        case .didPressCloseButton:
          return closeCart(state: &state)
        case .dismissSuccessAlert:
          resetProductsToZero(state: &state)
          
          return .task {
            .closeCart
          }
        case .cartItem(_, let action):
          switch action {
          case .deleteCartItem(let product):
            return .task {
              .resetProduct(product: product)
            }
          }
        default:
          return .none
        }
      case .closeCart:
        return closeCart(state: &state)
      case .resetProduct(let product):
        
        guard let index = state.productList.firstIndex(
          where: { $0.product.id == product.id }
        )
        else { return .none }
        let productStateId = state.productList[index].id
        
        state.productList[id: productStateId]?.addToCartState.count = 0
        return .none
      case .setCartView(let isPresented):
        state.shouldOpenCart = isPresented
        state.cartState = isPresented
        ? CartListDomain.State(
          cartItems: IdentifiedArrayOf(
            uniqueElements: state
              .productList
              .compactMap { state in
                state.count > 0
                ? CartItemDomain.State(
                  id: uuid(),
                  cartItem: CartItem(
                    product: state.product,
                    quantity: state.count
                  )
                )
                : nil
              }
          )
        )
        : nil
        return .none
      case .product:
        return .none
      }
    }
    .forEach(\.productList, action: /ProductListDomain.Action.product(id:action:)) {
      ProductDomain()
    }
    .ifLet(\.cartState, action: /ProductListDomain.Action.cart) {
      CartListDomain(sendOrder: sendOrder)
    }
  }
  
  private func closeCart(
    state: inout State
  ) -> EffectTask<Action> {
    state.shouldOpenCart = false
    state.cartState = nil
    
    return .none
  }
  
  private func resetProductsToZero(
    state: inout State
  ) {
    for id in state.productList.map(\.id) {
      state.productList[id: id]?.count = 0
    }
  }
//  static let reducer = Reducer<
//    State, Action, Environment
//  >.combine(
//    ProductDomain.reducer.forEach(
//      state: \.productList,
//      action: /Action.product(id:action:),
//      environment: { _ in ProductDomain.Environment() }
//    ),
//    CartListDomain.reducer
//      .optional()
//      .pullback(
//        state: \.cartState,
//        action: /ProductListDomain.Action.cart,
//        environment: { _ in
//          CartListDomain.Environment(sendOrder: APIClient.live.sendOrder)
//        }
//      ),
//    .init { state, action, environment in
//      switch action {
//      case .fetchProducts:
//        if state.dataLoadingStatus == .success || state.dataLoadingStatus == .loading {
//          return .none
//        }
//        
//        state.dataLoadingStatus = .loading
//        return .task {
//          await .fetchProductResponse(
//            TaskResult {
//              try await environment.fetchProducts()
//            }
//          )
//        }
//      case .fetchProductResponse(.success(let products)):
//        state.dataLoadingStatus = .success
//        state.productList = IdentifiedArray(
//          uniqueElements: products
//            .map {
//              ProductDomain.State(id: UUID(), product: $0)
//            }
//        )
//        return .none
//      case .fetchProductResponse(.failure(let error)):
//        state.dataLoadingStatus = .error
//        print(error)
//        print("Unable to fetch products")
//        return .none
//      case .product:
//        return .none
//      case .cart(let action):
//        switch action {
//        case .didPressCloseButton:
//          state.shouldOpenCart = false
//        case .cartItem(_, action: let action):
//          switch action {
//          case .deleteCartItem(let product):
//            guard let index = state.productList.firstIndex(
//              where: { $0.product.id == product.id }
//            )
//            else { return .none }
//            let productStateId = state.productList[index].id
//            
//            state.productList[id: productStateId]?.count = 0
//          }
//          return .none
//        case .dismissSuccessAlert:
//          resetProductsToZero(state: &state)
//          state.shouldOpenCart = false
//          return .none
//        default:
//          break
//        }
//        return .none
//      case .setCartView(let isPresented):
//        state.shouldOpenCart = isPresented
//        state.cartState = isPresented
//        ? CartListDomain.State(
//          cartItems: IdentifiedArray(
//            uniqueElements: state
//              .productList
//              .compactMap { state in
//                state.count > 0
//                ? CartItemDomain.State(
//                  id: UUID(),
//                  cartItem: CartItem(
//                    product: state.product,
//                    quantity: state.count
//                  )
//                )
//                : nil
//              }
//          )
//        )
//        : nil
//        return .none
//      }
//    }
//  ).debug()
  
//  private static func resetProductsToZero(
//    state: inout State
//  ) {
//    for id in state.productList.map(\.id) {
//      state.productList[id: id]?.count = 0
//    }
//  }
}
