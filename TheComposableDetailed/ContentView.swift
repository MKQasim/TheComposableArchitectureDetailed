  //
  //  ContentView.swift
  //  TheComposableDetailed
  //
  //  Created by KamsQue on 30/06/2023.
  //

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
  let store : Store<ProductListDomain.State, ProductListDomain.Action>
  
  var body: some View {
    WithViewStore(store){ viewStore in
      ProductListView(store: self.store)
    }
  }
}



//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    ContentView(store:Store(
//      initialState: ProductListDomain.State(),
//      reducer: ProductListDomain(fetchProducts: {
//        
//      }, sendOrder: { cartItem in
//        
//      }, uuid: {
//        print("")
//      }),
//      environment: ProductListDomain.Environment(
//        fetchProducts: APIClient.live.fetchProducts ,
//        sendOrder: APIClient.live.sendOrder)
//    ))
//  }
//}
