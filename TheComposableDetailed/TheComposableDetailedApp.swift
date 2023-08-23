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
      RootView(
        store: Store(
          initialState: RootDomain.State(),
          reducer: RootDomain.live
        )
      )
    }
  }
}
