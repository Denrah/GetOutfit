//
//  DataStorageService.swift
//  GetOutfit
//

import Foundation
import FirebaseFirestore

class DataStorageService: DataStorageServiceProtocol {
  private enum Collections {
    static let feed = "feed"
    static let maleStyles = "maleStyles"
  }
  
  private enum Keys {
    static let isLiked = "isLiked"
  }
  
  private let db = Firestore.firestore()
  
  func getFeed() async throws -> [Look] {
    return try await withUnsafeThrowingContinuation { continuation in
      db.collection(Collections.feed).getDocuments { snapshot, error in
        if let error = error {
          continuation.resume(throwing: error)
        } else {
          let result = snapshot?.documents.map { Look(data: $0.data(),
                                                      documentID: $0.documentID) } ?? []
          continuation.resume(returning: result)
        }
      }
    }
  }
  
  func setFeedLike(documentID: String, isLiked: Bool) async throws {
    return try await withUnsafeThrowingContinuation { continuation in
      let document = db.collection(Collections.feed).document(documentID)
      document.updateData([
        Keys.isLiked: isLiked
      ]) { error in
        if let error = error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume(returning: ())
        }
      }
    }
  }
  
  func getMaleStyleImages() async throws -> [String] {
    return try await withUnsafeThrowingContinuation { continuation in
      db.collection(Collections.maleStyles).getDocuments { snapshot, error in
        if let error = error {
          continuation.resume(throwing: error)
        } else {
          let result = snapshot?.documents.compactMap { $0.data()["image"] as? String } ?? []
          continuation.resume(returning: result)
        }
      }
    }
  }
}
