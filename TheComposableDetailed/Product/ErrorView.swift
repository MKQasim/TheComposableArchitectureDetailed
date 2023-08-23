//
//  ErrorView.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 23/08/2023.
//

import SwiftUI

struct ErrorView: View {
  let message : String
  let reTry : () -> Void
  
    var body: some View {
      VStack{
        Text(":(")
          .font(.custom("AmericanTypewriter", size: 50))
        Text("")
        Text(message)
          .font(.custom("AmericanTypewriter", size: 20))
        Button {
          reTry()
        } label: {
          Text("Retry")
            .font(.custom("AmericanTypewriter", size: 20))
            .foregroundColor(.white)
         
        }
        .frame(width: 100,height: 60)
        .background(.blue)
        .cornerRadius(10)
        .padding()

      }
    }
}

#Preview {
  ErrorView(message: "Opps we couldent fetch product list", reTry: {})
}
