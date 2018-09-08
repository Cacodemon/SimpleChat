//
//  PersistentStorage.swift
//  graph_memome
//
//  Created by Dmitry Rykun on 8/15/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import Foundation

protocol PersistentStorage {
  static func write<T: Codable>(_ value: T, _ key: String)
  static func read<T: Codable>(_ key: String) -> T?
  static func delete(_ key: String)
}

enum DirectoryPath {
  
  static let documents = getPath(.documentDirectory)
  static let caches = getPath(.cachesDirectory)
  
  static private func getPath(_ searchPath: FileManager.SearchPathDirectory) -> String {
    return NSSearchPathForDirectoriesInDomains(searchPath, .userDomainMask, true).first!
  }
}
