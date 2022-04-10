//
//  LookCellViewModel.swift
//  GetOutfit
//

import Foundation

protocol LookCellViewModelDelegate: AnyObject {
  func lookCellViewModel(_ viewModel: LookCellViewModel, didSelect look: Look)
  func lookCellViewModel(_ viewModel: LookCellViewModel, documentID: String,
                         didSetLikeTo isLiked: Bool)
}

class LookCellViewModel: ObservableObject {
  weak var delegate: LookCellViewModelDelegate?
  
  @Published private(set) var isLiked: Bool
  
  var items: [LookItem] {
    look.items
  }
  
  var photoURLs: [URL?] {
    look.photoURLs
  }
  
  var totalPrice: Int {
    look.items.reduce(0) { $0 + $1.price }
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
  
  init(look: Look) {
    self.isLiked = look.isLiked
    self.look = look
  }
  
  func didTapView() {
    delegate?.lookCellViewModel(self, didSelect: look)
  }
  
  func toggleLike() {
    isLiked.toggle()
    look.isLiked = isLiked
    delegate?.lookCellViewModel(self, documentID: look.documentID,
                                didSetLikeTo: isLiked)
  }
}
