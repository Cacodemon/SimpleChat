//
//  JSONBasedStorage.swift
//  graph_memome
//
//  Created by Dmitry Rykun on 8/15/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import Foundation

struct JSONBasedStorage {
  
  static let encoder = JSONEncoder()
  static let decoder = JSONDecoder()
  static let fileManager = FileManager.default
  
  private static func filePath(for key: String) -> String {
    return "\(DirectoryPath.documents)/\(key)"
  }
  
  static func write<T: Codable>(_ value: T, _ key: String) {
    let encoded = try? encoder.encode(value)
    fileManager.createFile(atPath: filePath(for: key), contents: encoded, attributes: nil)
  }
  
  static func read<T: Codable>(_ key: String) -> T? {
    guard let decoded = try? Data(contentsOf: URL(fileURLWithPath: filePath(for: key))) else { return nil }
    return try? decoder.decode(T.self, from: decoded)
  }
  
  static func delete(_ key: String) {
    
  }
}
