//
//  Product.swift
//  GetOutfit
//

import Foundation

struct Product: Codable {
  enum CodingKeys: String, CodingKey {
    case id, categoryID = "category_id", name, price, oldPrice = "old_price",
         images = "pictures", vendor, gender, size, color, categories
  }
  
  let id: String
  let categoryID: Int
  let name: String
  let price: Int
  let oldPrice: Int?
  let images: [String]
  let vendor: String
  let gender: Gender
  let size: String
  let color: String
  let categories: [Int]
  
  var imageURLs: [URL?] {
    images.map { URL(string: $0) }
  }
}
