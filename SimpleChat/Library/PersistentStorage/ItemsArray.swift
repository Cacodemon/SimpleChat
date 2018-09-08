//
//  ItemsArray.swift
//  SimpleChat
//
//  Created by Dmitry Rykun on 9/7/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import Foundation

struct ItemsArray<Item: Codable>: Codable {
  private var array = Array<Item>()
  
  mutating func append(_ item: Item) {
    array.append(item)
  }
  
  mutating func insert(_ item: Item, at index: Int) {
    array.insert(item, at: index)
  }
  
  mutating func replaceItem(_ item: Item, at index: Int) {
    array.replaceSubrange((index..<index+1), with: [item])
  }
  
  var items: [Item] {
    return array
  }
  
}
