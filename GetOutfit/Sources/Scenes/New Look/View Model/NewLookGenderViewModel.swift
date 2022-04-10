//
//  NewLookGenderViewModel.swift
//  GetOutfit
//

import Foundation

protocol NewLookGenderViewModelDelegate: AnyObject {
  func newLookGenderViewModel(_ viewModel: NewLookGenderViewModel, didSelect gender: Gender)
}

class NewLookGenderViewModel {
  weak var delegate: NewLookGenderViewModelDelegate?
  
  func didSelectGender(_ gender: Gender) {
    delegate?.newLookGenderViewModel(self, didSelect: gender)
  }
}
