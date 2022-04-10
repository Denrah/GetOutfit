//
//  SearchViewModel.swift
//  GetOutfit
//

import Foundation
import UIKit

protocol SearchViewModelDelegate: AnyObject {
  func searchViewModel(_ viewModel: SearchViewModel, didSelect product: Product)
}

class SearchViewModel: NSObject, ObservableObject {
  typealias Dependencies = HasNetworkService
  
  weak var delegate: SearchViewModelDelegate?
  
  @Published private(set) var products: [Product] = []
  
  private let dependencies: Dependencies
  
  private var searchWorkItem: DispatchWorkItem?
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
  func search(text: String?) {
    guard let text = text, !text.isEmpty else {
      products = []
      return
    }
    Task {
      do {
        let products = try await dependencies.networkService.searchProducts(text: text)
        await self.handle(products: products)
      } catch {
        
      }
    }
  }
  
  func select(product: Product) {
    delegate?.searchViewModel(self, didSelect: product)
  }
  
  @MainActor
  private func handle(products: [Product]) {
    self.products = products
  }
}

// MARK: - UISearchResultsUpdating

extension SearchViewModel: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    self.searchWorkItem?.cancel()
    
    let searchWorkItem = DispatchWorkItem { [weak self] in
      self?.search(text: searchController.searchBar.text)
    }
    
    self.searchWorkItem = searchWorkItem
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: searchWorkItem)
  }
}
