//
//  FeedViewModel.swift
//  GetOutfit
//

import Foundation

protocol FeedViewModelDelegate: AnyObject {
  func feedViewModel(_ viewModel: FeedViewModel, didSelect look: Look)
  func feedViewModelDidRequestToSearch(_ viewModel: FeedViewModel)
}

class FeedViewModel: ObservableObject {
  typealias Dependencies = HasDataStorageService
  
  weak var delegate: FeedViewModelDelegate?
  
  @Published private(set) var cellViewModels: [LookCellViewModel] = []
  
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
    loadData()
  }
  
  func didTapSearch() {
    delegate?.feedViewModelDidRequestToSearch(self)
  }
  
  private func loadData() {
    Task {
      do {
        let looks = try await dependencies.dataStorageService.getFeed()
        await update(looks: looks)
      } catch {
        
      }
    }
  }
  
  @MainActor
  private func update(looks: [Look]) {
    cellViewModels = looks.map { look in
      let viewModel = LookCellViewModel(look: look)
      viewModel.delegate = self
      return viewModel
    }
  }
}

// MARK: - LookCellViewModelDelegate

extension FeedViewModel: LookCellViewModelDelegate {
  func lookCellViewModel(_ viewModel: LookCellViewModel, didSelect look: Look) {
    delegate?.feedViewModel(self, didSelect: look)
  }
  
  func lookCellViewModel(_ viewModel: LookCellViewModel,
                         documentID: String, didSetLikeTo isLiked: Bool) {
    Task {
      do {
        try await dependencies.dataStorageService.setFeedLike(documentID: documentID,
                                                              isLiked: isLiked)
      } catch {
        
      }
    }
  }
}
