//
//  APIClient.swift
//  TheComposableDetailed
//
//  Created by KamsQue on 23/08/2023.
//

import Foundation


struct APIClient {
  var fetchProducts:  @Sendable () async throws -> [Product]
  var sendOrder:  @Sendable ([CartItem]) async throws -> String
  var fetchUserProfile:  @Sendable () async throws -> UserProfile
  
  struct Failure: Error, Equatable {}
  
 
}

extension APIClient{
  static let live = Self {
    let (data,_) = try await URLSession.shared.data(from: URL(string: "https://fakestoreapi.com/products")!)
    let products = try JSONDecoder().decode([Product].self, from: data)
    
    return products
  } sendOrder: { cartItems in
    print(cartItems)
    let payload = try JSONEncoder().encode(cartItems)
    var urlRequest = try URLRequest(url: URL(string: "https://fakestoreapi.com/carts")!)
    urlRequest.addValue("application/json", forHTTPHeaderField: "Contant_Type")
    urlRequest.httpMethod = "POST"
    let (data, response) = try await URLSession.shared.upload(for: urlRequest, from: payload)
    guard let httpResponse = (response as? HTTPURLResponse) else {  throw Failure() }
    
    return "Status: \(httpResponse.statusCode)"
    
  }fetchUserProfile: {
    let (data, _) = try await URLSession.shared
      .data(from: URL(string: "https://fakestoreapi.com/users/1")!)
    let profile = try JSONDecoder().decode(UserProfile.self, from: data)
    return profile
  }

}
