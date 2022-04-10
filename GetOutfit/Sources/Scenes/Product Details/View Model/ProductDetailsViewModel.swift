//
//  ProductDetailsViewModel.swift
//  GetOutfit
//

import Foundation

class ProductDetailsViewModel: ObservableObject {
  typealias Dependencies = HasNetworkService & HasUserDataStore
  
  var imageURLs: [URL?] {
    product?.imageURLs ?? []
  }
  
  var name: String {
    product?.name ?? ""
  }
  
  var gender: String {
    product?.gender.title ?? ""
  }
  
  var size: String {
    product?.size ?? ""
  }
  
  var color: String {
    product?.color ?? ""
  }
  
  var vendor: String {
    product?.vendor ?? ""
  }
  
  var categories: [String] {
    let categories = dependencies.userDataStore.categories
    return product?.categories.compactMap { id in
      return categories.first { $0.id == id }?.name
    } ?? []
  }
  
  var price: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "₽"
    formatter.minimumFractionDigits = 0
    return formatter.string(from: NSNumber(value: product?.price ?? 0)) ?? ""
  }
  
  private let productID: String
  private let dependencies: Dependencies
  
  @Published private var product: Product?
  
  init(productID: String, dependencies: Dependencies) {
    self.productID = productID
    self.dependencies = dependencies
    
    loadData()
  }
  
  private func loadData() {
    Task {
      do {
        let product = try await dependencies.networkService.getProducts(id: productID).first
        await handle(product: product)
      } catch {
        print(error)
      }
    }
  }
  
  @MainActor
  private func handle(product: Product?) {
    self.product = product
  }
}
