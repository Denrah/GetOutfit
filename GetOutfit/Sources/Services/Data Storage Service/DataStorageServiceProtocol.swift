//
//  DataStorageServiceProtocol.swift
//  GetOutfit
//

import Foundation

protocol DataStorageServiceProtocol {
  func getFeed() async throws -> [Look]
  func setFeedLike(documentID: String, isLiked: Bool) async throws
  func getMaleStyleImages() async throws -> [String]
}
