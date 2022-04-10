//
//  AppColors.swift
//  GetOutfit
//

import SwiftUI
import UIKit

extension UIColor {
  static let accent = UIColor(named: "Accent") ?? .clear
  static let accentDark = UIColor(named: "AccentDark") ?? .clear
  static let accentFaded = UIColor(named: "AccentFaded") ?? .clear
  static let shade0 = UIColor(named: "Shade0") ?? .clear
  static let shade1 = UIColor(named: "Shade1") ?? .clear
}

extension Color {
  static let accent = Color(uiColor: .accent)
  static let accentDark = Color(uiColor: .accentDark)
  static let accentFaded = Color(uiColor: .accentFaded)
  static let shade0 = Color(uiColor: .shade0)
  static let shade1 = Color(uiColor: .shade1)
}
