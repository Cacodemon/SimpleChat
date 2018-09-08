//
//  MessageListViewModel.swift
//  SimpleChat
//
//  Created by Dmitry Rykun on 9/7/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import UIKit

final class MessageListViewModel {
  
  private let updateTimeInterval: TimeInterval = 3
  
  private var messageStorage: MessageStorage!
  private var messagePeer: MessagePeer!
  
  private var messageViewModels = [MessageViewModel]() {
    didSet {
      reloadTableView()
    }
  }
  
  var numberOfMessages: Int {
    return messageViewModels.count
  }
  
  func messageViewModel(at indexPath: IndexPath) -> MessageViewModel {
    return messageViewModels.reversed()[indexPath.row]
  }
  
  var reloadTableView = { }
  var beginLoading = { }
  var endLoading = { }
  
  func setup() {
    self.beginLoading()
    self.messagePeer.setup()
    self.messagePeer.messageRecived = self.messageReceived
    DispatchQueue(label: "messageListViewModel").async {
      self.messageStorage.loadMessages()
      self.endLoading()
      self.messageViewModels = self.messageStorage.allMessages
        .map { MessageViewModel($0) }
    }
  }
  
  private func messageReceived(_ newMessage: Message) {
    
    if !messageStorage.isStored(newMessage) {
      let messageViewModel = MessageViewModel(newMessage)
      messageViewModels = messageViewModels + [messageViewModel]
      
      Scheduler.schedule(self.updateTimeInterval) {
        let readMessage = Message(newMessage.text, newMessage.author, .read, newMessage.id)
        messageViewModel.message = readMessage
        
        Scheduler.schedule(self.updateTimeInterval) {
          let savedMessage = Message(readMessage.text, readMessage.author, .saved, readMessage.id)
          messageViewModel.message = savedMessage
          self.saveMessage(savedMessage)
        }
      }
    }
  }
  
  private func saveMessage(_ message: Message) {
    self.messageStorage.appendMessage(message)
    self.messageStorage.saveMessages()
  }
  
  func enterText(_ text: String) {
    let message = Message(text, .me, .saved)
    messagePeer.send(message)
    messageViewModels = messageViewModels + [MessageViewModel(message)]
    saveMessage(message)
  }
  
  init(_ messageStorage: MessageStorage, _ messagePeer: MessagePeer) {
    self.messageStorage = messageStorage
    self.messagePeer = messagePeer
  }

}
