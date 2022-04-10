//
//  AppDependency.swift
//  GetOutfit
//

import Foundation

protocol HasDataStorageService {
  var dataStorageService: DataStorageServiceProtocol { get }
}

protocol HasNetworkService {
  var networkService: NetworkServiceProtocol { get }
}

protocol HasUserDataStore {
  var userDataStore: UserDataStoreProtocol { get }
}

class AppDependency: HasDataStorageService, HasNetworkService, HasUserDataStore {
  let dataStorageService: DataStorageServiceProtocol
  let networkService: NetworkServiceProtocol
  let userDataStore: UserDataStoreProtocol
  
  init() {
    self.dataStorageService = DataStorageService()
    self.networkService = NetworkService()
    self.userDataStore = UserDataStore()
  }
}
