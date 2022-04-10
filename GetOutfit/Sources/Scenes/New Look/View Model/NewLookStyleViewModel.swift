//
//  NewLookStyleViewModel.swift
//  GetOutfit
//

import Foundation

protocol NewLookStyleViewModelDelegate: AnyObject {
  func newLookStyleViewModel(_ viewModel: NewLookStyleViewModel,
                             didSelect occasion: Occasion)
}

class NewLookStyleViewModel: ObservableObject {
  typealias Dependencies = HasNetworkService & HasDataStorageService
  
  weak var delegate: NewLookStyleViewModelDelegate?
  
  @Published private(set) var isLoading = false
  @Published private(set) var occasions: [String: [Occasion]] = [:]
  @Published private(set) var styleImageURLs: [URL?] = []
  
  var keys: [String] {
    Array(occasions.keys).sorted()
  }
  
  private let gender: Gender
  private let dependencies: Dependencies
  
  init(gender: Gender, dependencies: Dependencies) {
    self.gender = gender
    self.dependencies = dependencies
    loadStyleImages()
    loadOccasions()
  }
  
  func selectStyle() {
    if let occasion = occasions.flatMap({ $0.value }).randomElement() {
      select(occasion: occasion)
    }
  }
  
  func select(occasion: Occasion) {
    delegate?.newLookStyleViewModel(self, didSelect: occasion)
  }
  
  private func loadStyleImages() {
    Task {
      do {
        let images = try await dependencies.dataStorageService.getMaleStyleImages()
        await handle(images: images)
      } catch {
        
      }
    }
  }
  
  private func loadOccasions() {
    isLoading = true
    Task {
      do {
        let occasions = try await dependencies.networkService.getOccasions()
        await handle(occasions: occasions)
        await setLoadingState(isLoading: false)
      } catch {
        print(error)
        await setLoadingState(isLoading: false)
      }
    }
  }
  
  @MainActor
  private func setLoadingState(isLoading: Bool) {
    self.isLoading = isLoading
  }
  
  @MainActor
  private func handle(images: [String]) {
    styleImageURLs = images.map { URL(string: $0) }
  }
  
  @MainActor
  private func handle(occasions: [Occasion]) {
    occasions.filter { $0.gender == gender }.forEach { occasion in
      if self.occasions[occasion.name] == nil {
        self.occasions[occasion.name] = [occasion]
      } else {
        self.occasions[occasion.name]?.append(occasion)
      }
    }
  }
}
