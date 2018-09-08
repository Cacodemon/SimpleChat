//
//  Message.swift
//  graph_memome
//
//  Created by Dmitry Rykun on 8/15/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import Foundation

struct Message: Codable {
  
  enum Author: Int, Codable {
    case me
    case notMe
  }
  
  enum State: Int, Codable {
    case new
    case read
    case saved
  }
  
  let text: String
  let author: Author
  let state: State
  let id: String
  
  init(_ text: String, _ author: Author, _ state: State, _ id: String = UUID().uuidString) {
    self.text = text
    self.author = author
    self.state = state
    self.id = id
  }
}

extension Message: DatabaseRepresentation {
  
  var representation: [String : Any] {
    return ["text": text,
            "id": id
    ]
  }
  
  init(_ representation: [String: Any]) {
    self.text = representation["text"] as? String ?? ""
    self.author = .notMe
    self.state = .new
    self.id = representation["id"] as? String ?? UUID().uuidString
  }
}
