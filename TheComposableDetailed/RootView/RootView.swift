//
//  RootView.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 23/08/2023.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
  let store: Store<RootDomain.State, RootDomain.Action>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      TabView(
        selection: viewStore.binding(
          get: \.selectedTab,
          send: RootDomain.Action.tabSelected
        )
      ) {
        ProductListView(
          store: self.store.scope(
            state: \.productListState,
            action: RootDomain.Action
              .productList
          )
        )
        .tabItem {
          Image(systemName: "list.bullet")
          Text("Products")
        }
        .tag(RootDomain.Tab.products)
        ProfileView(
          store: self.store.scope(
            state: \.profileState,
            action: RootDomain.Action.profile
          )
        )
        .tabItem {
          Image(systemName: "person.fill")
          Text("Profile")
        }
        .tag(RootDomain.Tab.profile)
      }
    }
  }
}

#Preview {
  RootView(
    store: Store(
      initialState: RootDomain.State()
    ) {
      RootDomain(
        fetchProducts: { Product.sample },
        sendOrder: { _ in "OK" },
        fetchUserProfile: { UserProfile.sample },
        uuid: { UUID() }
      )
    }
  )
}
