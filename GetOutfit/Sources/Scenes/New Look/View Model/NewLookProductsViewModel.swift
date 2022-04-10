//
//  NewLookProductsViewModel.swift
//  GetOutfit
//

import Foundation

protocol NewLookProductsViewModelDelegate: AnyObject {
  func newLookProductsViewModelDidFinish(_ viewModel: NewLookProductsViewModel)
}

class NewLookProductsViewModel {
  weak var delegate: NewLookProductsViewModelDelegate?
  
  var totalPrice: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "₽"
    formatter.minimumFractionDigits = 0
    let sum = products.reduce(0) { $0 + $1.price }
    return formatter.string(from: NSNumber(value: sum)) ?? ""
  }
  
  let products: [Product]
  
  init(products: [Product]) {
    self.products = products
  }
  
  func finish() {
    delegate?.newLookProductsViewModelDidFinish(self)
  }
}
