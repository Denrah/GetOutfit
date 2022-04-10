//
//  Occasion.swift
//  GetOutfit
//

import Foundation

struct Occasion: Codable {
  let name: String
  let label: String
  let gender: Gender
  let items: [[String]]
}
