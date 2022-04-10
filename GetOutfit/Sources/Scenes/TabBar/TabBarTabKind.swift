//
//  TabBarTabKind.swift
//  GetOutfit
//

import UIKit

enum TabBarTabKind {
  case feed, catalogue, newLook, collection, profile
  
  var icon: UIImage? {
    switch self {
    case .feed:
      return .init(.ideas)
    case .catalogue:
      return .init(.catalogue)
    case .newLook:
      return .init(.newLook)
    case .collection:
      return .init(.collection)
    case .profile:
      return .init(.profile)
    }
  }
  
  var title: String? {
    switch self {
    case .feed:
      return "Идеи"
    case .catalogue:
      return "Каталог"
    case .newLook:
      return "Новый"
    case .collection:
      return "Гардероб"
    case .profile:
      return "Профиль"
    }
  }
}
