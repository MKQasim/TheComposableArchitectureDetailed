//
//  CartListView.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 02/07/2023.
//

import SwiftUI
import ComposableArchitecture

struct CartListView: View {
  let store : Store<CartListDomain.State,CartListDomain.Action>
  
    var body: some View {
      WithViewStore(self.store){ viewStore in
        NavigationStack{
          List {
            ForEachStore(
              self.store.scope(
                state: \.cartItems,
                action:CartListDomain.Action.cartItem(id:action:)
             )
            ) {
              CartCell(store: $0)
            }
          }
          .navigationTitle("Cart")
          .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
              Button {
                viewStore.send(.didPressCloseButton)
              } label: {
                Text("Close")
              }
            }
          }
        }

      }
        
    }
}

struct CartListView_Previews: PreviewProvider {
  static var previews: some View {
    CartListView(
      store: Store(
        initialState: CartListDomain.State(
          cartItems: IdentifiedArrayOf(
            uniqueElements: CartItem.sample
              .map {
                CartItemDomain.State(
                  id: UUID(),
                  cartItem: $0
                )
              }
          )
        ),
        reducer: CartListDomain.reducer,
        environment: CartListDomain.Environment()
      )
    )
  }
}
