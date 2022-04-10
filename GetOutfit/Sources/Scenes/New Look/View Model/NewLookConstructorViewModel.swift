//
//  NewLookConstructorViewModel.swift
//  GetOutfit
//

import Foundation

protocol NewLookConstructorViewModelDelegate: AnyObject {
  func newLookConstructorViewModel(_ viewModel: NewLookConstructorViewModel,
                                   didSelect products: [Product])
}

class NewLookConstructorViewModel: ObservableObject {
  typealias Dependencies = HasNetworkService
  
  weak var delegate: NewLookConstructorViewModelDelegate?
  
  var progress: String {
    "\(Int((Double(itemsLoaded) / Double(occasion.items.flatMap { $0 }.count)) * 100))%"
  }
  
  var totalPrice: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "₽"
    formatter.minimumFractionDigits = 0
    let sum = selectedIndices.enumerated().reduce(0) { $0 + products[$1.offset][$1.element].price }
    return formatter.string(from: NSNumber(value: sum)) ?? ""
  }
  
  @Published var selectedIndices: [Int]
  
  @Published private(set) var isLoading = false
  @Published private(set) var products: [[Product]] = []
  
  private let occasion: Occasion
  private let dependencies: Dependencies
  
  @Published private var itemsLoaded = 0
  
  init(occasion: Occasion, dependencies: Dependencies) {
    self.occasion = occasion
    self.dependencies = dependencies
    self.selectedIndices = Array(stride(from: 0, to: occasion.items.count, by: 1))
    loadData()
  }
  
  func loadData() {
    isLoading = true
    Task {
      let products = await occasion.items.enumerated().asyncMap { index, collection async -> [Product] in
        return await collection.asyncMap { productID async -> Product? in
          do {
            let product = try await dependencies.networkService.getProducts(id: productID).first
            await increaseItemsLoaded()
            return product
          } catch {
            await increaseItemsLoaded()
            return nil
          }
        }.filter { $0 != nil }.map { $0! }
      }
      await handle(products: products)
    }
  }
  
  func proceed() {
    let products = zip(selectedIndices, products).map { $1[$0] }
    delegate?.newLookConstructorViewModel(self, didSelect: products)
  }
  
  @MainActor
  private func increaseItemsLoaded() {
    itemsLoaded += 1
  }
  
  @MainActor
  private func handle(products: [[Product]]) {
    self.products = products
    isLoading = false
  }
}
