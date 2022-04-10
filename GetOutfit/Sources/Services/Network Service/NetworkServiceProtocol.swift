//
//  NetworkServiceProtocol.swift
//  GetOutfit
//

import Foundation

protocol NetworkServiceProtocol {
  func getProducts(id: String) async throws -> [Product]
  func getProducts(categoryID: Int) async throws -> [Product]
  func searchProducts(text: String) async throws -> [Product]
  func getCategories() async throws -> [Category]
  func getOccasions() async throws -> [Occasion]
}
