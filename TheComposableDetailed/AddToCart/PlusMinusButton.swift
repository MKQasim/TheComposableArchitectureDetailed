  //
  //  PlusMinusButton.swift
  //  TheComposableDetailed
  //
  //  Created by KamsQue on 01/07/2023.
  //

import SwiftUI
import ComposableArchitecture

struct PlusMinusButton: View {
  var store : Store<AddToCartDomain.State,AddToCartDomain.Action>
  var body: some View {
    WithViewStore(store){ viewStore in
      Button {
        viewStore.send(.didTapPlusButton)
      } label: {
        Text("+")
          .padding(10)
          .background(.blue)
          .foregroundColor(.white)
          .cornerRadius(10)
      }.buttonStyle(.plain)
      
      Text(viewStore.count.description)
        .padding(5)
      
      Button {
        viewStore.send(.didTapMinusButton)
      } label: {
        Text("-")
          .padding(10)
          .background(.blue)
          .foregroundColor(.white)
          .cornerRadius(10)
      }
      .buttonStyle(.plain)
    }
  }
}

struct PlusMinusButton_Previews: PreviewProvider {
  static var previews: some View {
    PlusMinusButton(
      store: Store(
        initialState: AddToCartDomain.State(),
        reducer: AddToCartDomain()
      )
    )
  }
}
