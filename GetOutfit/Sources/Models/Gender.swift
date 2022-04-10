//
//  Gender.swift
//  GetOutfit
//

import Foundation

enum Gender: String, Codable {
  case male, female, nonbinary = "unisex"
  
  var title: String {
    switch self {
    case .male:
      return "Мужской"
    case .female:
      return "Женский"
    case .nonbinary:
      return "Небинарный"
    }
  }
}
