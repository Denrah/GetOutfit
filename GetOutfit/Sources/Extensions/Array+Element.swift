//
//  Array+Element.swift
//  GetOutfit
//

import Foundation

extension Array {
  func element(at index: Int) -> Element? {
    guard index >= 0, index < count else { return nil }
    return self[index]
  }
}
