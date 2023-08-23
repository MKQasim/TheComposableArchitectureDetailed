//
//  ProductListView.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 02/07/2023.
//

import SwiftUI
import ComposableArchitecture

struct ProductListView : View{
  let store : Store<ProductListDomain.State,ProductListDomain.Action>
  @State var shouldOpenCart = false
  
  var body: some View{
    WithViewStore(self.store){ viewStore in
      NavigationStack{
        Group{
          if viewStore.isLoading {
            ProgressView()
              .frame(width: 100, height: 100, alignment:.center)
          }else if viewStore.shouldShowError  {
            ErrorView(message: "Opps we couldent fetch product list") {
              viewStore.send(.fetchProducts)
            }
          }else{
            List {
              ForEachStore(
                self.store.scope(
                  state: \.productList,
                  action: ProductListDomain.Action.product(id:action:)
                )
              ){
                ProductCell(store: $0)
              }
            }
          }
        }
        .task {
          viewStore.send(.fetchProducts)
        }
        .navigationTitle("Products")
        .toolbar{
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              viewStore.send(.setCartView(isPresented: true))
            } label: {
              Text("Go to Cart")
            }
          }
        }
        .sheet(
          isPresented: viewStore.binding(
            get: \.shouldOpenCart,
            send:ProductListDomain.Action.setCartView(isPresented:)
          )
        ) {
          
          IfLetStore(self.store.scope(
            state: \.cartState,
            action: ProductListDomain.Action.cart )) {
              CartListView(store: $0)
            }
        }
      }
    }
  }
}

struct ProductListView_Previews: PreviewProvider {
  static var previews: some View {
    ProductListView(
      store: Store(
        initialState: ProductListDomain.State()
      ) {
        ProductListDomain(
          fetchProducts: { Product.sample },
          sendOrder: { _ in "OK" },
          uuid: { UUID() }
        )
      }
    )
  }
}
