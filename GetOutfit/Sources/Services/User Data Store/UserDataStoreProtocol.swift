//
//  UserDataStoreProtocol.swift
//  GetOutfit
//

import Foundation

protocol UserDataStoreProtocol: AnyObject {
  var categories: [Category] { get set }
}
