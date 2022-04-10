//
//  Font+AppFonts.swift
//  GetOutfit
//

import SwiftUI
import UIKit

extension Font {
  static func appRegular(size: CGFloat = 16) -> Font {
    return Font.custom("Circe-Regular", size: size)
  }
  static func appBold(size: CGFloat = 16) -> Font {
    return Font.custom("Circe-Bold", size: size)
  }
}

extension UIFont {
  static func appRegular(size: CGFloat = 16) -> UIFont? {
    return UIFont(name: "Circe-Regular", size: size)
  }
  static func appBold(size: CGFloat = 16) -> UIFont? {
    return UIFont(name: "Circe-Bold", size: size)
  }
}
