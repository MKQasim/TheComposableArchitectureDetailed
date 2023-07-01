  //
  //  ContentView.swift
  //  TheComposableDetailed
  //
  //  Created by KamsQue on 30/06/2023.
  //

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
  let store : Store<ProductDomain.State, ProductDomain.Action>
  
  var body: some View {
    WithViewStore(store){ viewStore in
      ProductCell(store: self.store)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(store:Store(
      initialState: ProductDomain.State(
        product: Product.sample[0]
      ),
      reducer: ProductDomain.reducer,
      environment: ProductDomain.Environment()
    ))
  }
}
