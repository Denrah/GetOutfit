//
//  LookDetailsViewModel.swift
//  GetOutfit
//

import Foundation

protocol LookDetailsViewModelDelegate: AnyObject {
  func lookDetailsViewModel(_ viewModel: LookDetailsViewModel, didSelect lookItem: LookItem)
}

class LookDetailsViewModel: ObservableObject {
  typealias Dependencies = HasDataStorageService
  
  weak var delegate: LookDetailsViewModelDelegate?
  
  @Published private(set) var isLiked: Bool
  
  var photoURLs: [URL?] {
    look.photoURLs
  }
  
  var items: [LookItem] {
    look.items
  }
  
  var totalPrice: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "₽"
    formatter.minimumFractionDigits = 0
    return formatter.string(from: NSNumber(value: look.totalPrice)) ?? ""
  }
  
  var avatarURL: URL? {
    look.user?.avatarURL
  }
  
  var userName: String {
    look.user?.name ?? ""
  }
  
  var likes: String {
    if look.likes < 1000 {
      return "\(look.likes)k"
    } else {
      return "\(Double((look.likes / 100) * 100) / 1000)k"
    }
  }
  
  private var look: Look
  private let dependencies: Dependencies
  
  init(look: Look, dependencies: Dependencies) {
    self.isLiked = look.isLiked
    self.look = look
    self.dependencies = dependencies
  }
  
  func didSelectItem(lookItem: LookItem) {
    delegate?.lookDetailsViewModel(self, didSelect: lookItem)
  }
  
  func toggleLike() {
    isLiked.toggle()
    look.isLiked = isLiked
    Task {
      try await dependencies.dataStorageService.setFeedLike(documentID: look.documentID, isLiked: isLiked)
    }
  }
}
