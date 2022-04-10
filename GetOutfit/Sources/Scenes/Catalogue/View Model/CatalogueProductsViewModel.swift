//
//  CatalogueProductsViewModel.swift
//  GetOutfit
//

import Foundation

protocol CatalogueProductsViewModelDelegate: AnyObject {
  func catalogueProductsViewModel(_ viewModel: CatalogueProductsViewModel,
                                  didSelect product: Product)
}

class CatalogueProductsViewModel: ObservableObject {
  typealias Dependencies = HasNetworkService
  
  weak var delegate: CatalogueProductsViewModelDelegate?
  
  var title: String {
    category.name
  }
  
  @Published private(set) var isLoading = false
  @Published private(set) var products: [Product] = []
  
  private let category: Category
  private let dependencies: Dependencies
  
  init(category: Category, dependencies: Dependencies) {
    self.category = category
    self.dependencies = dependencies
    loadData()
  }
  
  func select(product: Product) {
    delegate?.catalogueProductsViewModel(self, didSelect: product)
  }
  
  private func loadData() {
    isLoading = true
    Task {
      do {
        let products = try await dependencies.networkService.getProducts(categoryID: category.id)
        await handle(products: products)
      } catch {
        await setLoadingState(isLoading: false)
      }
    }
  }
  
  @MainActor
  private func setLoadingState(isLoading: Bool) {
    self.isLoading = isLoading
  }
  
  @MainActor
  private func handle(products: [Product]) {
    self.isLoading = false
    self.products = products
  }
}
