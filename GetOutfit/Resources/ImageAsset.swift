//
//  ImageAsset.swift
//  GetOutfit
//

import SwiftUI
import UIKit

enum ImageAsset: String {
  case like
  case likeFilled = "like-filled"
  case search
  case collection
  case catalogue
  case ideas
  case profile
  case newLook = "new-look"
  case close
  case arrowLeft = "arrow-left"
  case arrowRight = "arrow-right"
  
  case maleBackground = "male-background"
  case femaleBackground = "female-background"
  case nonbinaryBackground = "nonbinary-background"
}

extension Image {
  init(_ asset: ImageAsset) {
    self.init(asset.rawValue)
  }
}

extension UIImage {
  convenience init?(_ asset: ImageAsset) {
    self.init(named: asset.rawValue)
  }
}
