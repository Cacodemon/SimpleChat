//
//  App.swift
//  SimpleChat
//
//  Created by Dmitry Rykun on 9/7/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import UIKit

struct App {
  static func run() -> UIViewController {
    return MessageTableViewController(
      MessageListViewModel(
        MessageStorage(),
        MessagePeer()
      )
    )
  }
}
