  //
  //  TheComposableDetailedApp.swift
  //  TheComposableDetailed
  //
  //  Created by KamsQue on 30/06/2023.
  //

import SwiftUI
import ComposableArchitecture

@main
struct TheComposableDetailedApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(store:Store(
        initialState: ProductDomain.State(
          product: Product.sample[0]
        ),
        reducer: ProductDomain.reducer,
        environment: ProductDomain.Environment()
      ))
    }
  }
}
