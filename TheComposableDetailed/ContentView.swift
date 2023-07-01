  //
  //  ContentView.swift
  //  TheComposableDetailed
  //
  //  Created by KamsQue on 30/06/2023.
  //

import SwiftUI
import ComposableArchitecture


struct State : Equatable {
  var counter = 0
}

enum Action : Equatable {
  case increaseCounter
  case decreaseCounter
}

struct Environment {
    //  Future Dependencies ......
}

let reducer = Reducer<State,Action,Environment
>{ state , action , environment in
  switch action {
  case .decreaseCounter:
    state.counter -= 1
    return Effect.none
  case .increaseCounter:
    state.counter += 1
    return Effect.none
  }
}

struct ContentView: View {
    // @ObservedObject private var viewStore : ViewStore<State,Action>
    //  init(viewStore: ViewStore<State, Action>) {
    //    self.viewStore = viewStore
    //  }
  
    //  init(store: Store<State, Action>) {
    //    self.viewStore = ViewStore(store)
    //  }
    //
  var store : Store<State,Action>
  
  var body: some View {
    WithViewStore(store){ viewStore in
      
      
      Button {
        viewStore.send(.increaseCounter)
      } label: {
        Text("+")
                    .padding(10)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
      }.buttonStyle(.plain)

      Text(viewStore.counter.description)
        .padding(5)

      Button {
        viewStore.send(.decreaseCounter)
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(store: Store(initialState: State(), reducer: reducer,
                             environment: Environment()))
  }
}
