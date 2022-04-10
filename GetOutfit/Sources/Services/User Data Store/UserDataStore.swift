//
//  UserDataStore.swift
//  GetOutfit
//

import Foundation

class UserDataStore {
  private let userDefaults = UserDefaults.standard
}

extension UserDataStore: UserDataStoreProtocol {
  var categories: [Category] {
    get {
      let data = userDefaults.data(forKey: "categories")
      return (try? JSONDecoder().decode([Category].self, from: data ?? Data())) ?? []
    }
    set {
      let data = (try? JSONEncoder().encode(newValue)) ?? Data()
      userDefaults.set(data, forKey: "categories")
    }
  }
}
