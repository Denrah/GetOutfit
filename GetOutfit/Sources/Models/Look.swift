//
//  Look.swift
//  GetOutfit
//

import Foundation
import FirebaseFirestore

struct User {
  let avatar: String
  let name: String
  
  var avatarURL: URL? {
    URL(string: avatar)
  }
  
  init(data: [String: Any]) {
    avatar = (data["avatarURL"] as? String) ?? ""
    name = (data["name"] as? String) ?? ""
  }
}

struct LookItem {
  let image: String
  let name: String
  let price: Int
  let id: String
  
  var imageURL: URL? {
    URL(string: image)
  }
  
  init(data: [String: Any]) {
    image = (data["imageURL"] as? String) ?? ""
    name = (data["name"] as? String) ?? ""
    price = (data["price"] as? Int) ?? 0
    id = (data["id"] as? String) ?? ""
  }
}

struct Look {
  var isLiked: Bool
  let items: [LookItem]
  let photos: [String]
  let user: User?
  let likes: Int
  let documentID: String
  
  var photoURLs: [URL?] {
    photos.map { URL(string: $0) }
  }
  
  var totalPrice: Int {
    items.reduce(0) { $0 + $1.price }
  }
  
  init(data: [String: Any], documentID: String) {
    isLiked = (data["isLiked"] as? Bool) ?? false
    items = ((data["items"] as? [[String: Any]]) ?? []).map { LookItem(data: $0) }
    photos = (data["photos"] as? [String]) ?? []
    user = (data["user"] as? [String: Any]).map { User(data: $0) }
    likes = (data["likes"] as? Int) ?? 0
    self.documentID = documentID
  }
}
