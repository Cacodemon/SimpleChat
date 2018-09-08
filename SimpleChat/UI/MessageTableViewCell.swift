//
//  MessageTableViewCell.swift
//  SimpleChat
//
//  Created by Dmitry Rykun on 9/7/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
  
  static let reuseIdentifier = "MessageTableViewCell"
  
  var messageViewModel: MessageViewModel? {
    didSet {
      setupView()
      messageViewModel?.didChangeProperties = {
        self.setupView()
      }
    }
  }
  
  private func setupView() {
    if let _messageViewModel = messageViewModel {
      textLabel?.text = _messageViewModel.text
      textLabel?.textAlignment = _messageViewModel.textAlignment
      backgroundColor = _messageViewModel.backgroundColor
    }
  }
}
