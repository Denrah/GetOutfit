//
//  NetworkService.swift
//  GetOutfit
//

import Alamofire
import Foundation

enum Endpoint: String {
  case items = "/items"
  case categories = "/categories"
  case occasions = "/occasions"
  
  var url: URL {
    URL(string: Self.baseURL + self.rawValue)!
  }
  
  static private let baseURL = "http://spb.getoutfit.co:3000"
}

enum RequestOperator {
  case like(value: String), equal(value: String)
  
  var parameterValue: String {
    switch self {
    case .like(let value):
      return "like.*\(value)*"
    case .equal(let value):
      return "eq.\(value)"
    }
  }
}

class NetworkService {
  private enum Keys {
    static let id = "id"
    static let name = "name"
    static let categoryID = "category_id"
  }
  
  private func request<T: Decodable>(endpoint: Endpoint,
                                     method: HTTPMethod,
                                     parameters: Parameters) async throws -> T {
    return try await withCheckedThrowingContinuation { continuation in
      AF.request(endpoint.url, method: method, parameters: parameters,
                 encoding: method == .get ? URLEncoding.queryString : JSONEncoding.default)
        .responseData { response in
          switch response.result {
          case .success(let data):
            do {
              let object = try JSONDecoder().decode(T.self, from: data)
              continuation.resume(returning: object)
            } catch {
              continuation.resume(throwing: error)
            }
          case .failure(let error):
            continuation.resume(throwing: error)
          }
        }
    }
  }
}

extension NetworkService: NetworkServiceProtocol {
  func getProducts(id: String) async throws -> [Product] {
    let parameters: Parameters = [
      Keys.id: RequestOperator.equal(value: id).parameterValue
    ]
    return try await request(endpoint: .items, method: .get, parameters: parameters)
  }
  
  func getProducts(categoryID: Int) async throws -> [Product] {
    let parameters: Parameters = [
      Keys.categoryID: RequestOperator.equal(value: "\(categoryID)").parameterValue
    ]
    return try await request(endpoint: .items, method: .get, parameters: parameters)
  }
  
  func searchProducts(text: String) async throws -> [Product] {
    let parameters: Parameters = [
      Keys.name: RequestOperator.like(value: text).parameterValue
    ]
    return try await request(endpoint: .items, method: .get, parameters: parameters)
  }
  
  func getCategories() async throws -> [Category] {
    return try await request(endpoint: .categories, method: .get, parameters: [:])
  }
  
  func getOccasions() async throws -> [Occasion] {
    return try await request(endpoint: .occasions, method: .get, parameters: [:])
  }
}
