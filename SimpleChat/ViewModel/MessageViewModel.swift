//
//  MessageViewModel.swift
//  SimpleChat
//
//  Created by Dmitry Rykun on 9/7/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import UIKit

final class MessageViewModel {
  
  var message: Message {
    didSet {
      didChangeProperties()
    }
  }
  
  var text: String {
    return message.text
  }
  
  var textAlignment: NSTextAlignment {
    switch message.author {
    case .me:
      return .right
    case .notMe:
      return .left
    }
  }
  
  var backgroundColor: UIColor {
    switch message.state {
    case .new:
      return .red
    case .read:
      return .blue
    case .saved:
      return .green
    }
  }
  
  var didChangeProperties = { }
  
  init(_ message: Message) {
    self.message = message
  }
}
