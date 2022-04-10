//
//  CatalogueViewModel.swift
//  GetOutfit
//

import Foundation

protocol CatalogueViewModelDelegate: AnyObject {
  func catalogueViewModel(_ viewModel: CatalogueViewModel, didSelect category: Category)
}

class CatalogueViewModel {
  typealias Dependencies = HasUserDataStore
  
  weak var delegate: CatalogueViewModelDelegate?
  
  var categories: [Category] {
    dependencies.userDataStore.categories
  }
  
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
  func select(category: Category) {
    delegate?.catalogueViewModel(self, didSelect: category)
  }
}
