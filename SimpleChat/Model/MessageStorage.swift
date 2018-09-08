//
//  MessageStorage.swift
//  graph_memome
//
//  Created by Dmitry Rykun on 8/15/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import Foundation

final class MessageStorage {
  
  enum StorageKey {
    static let messages = "Messages"
  }
  
  private var storage = JSONBasedStorage.self
  
  var messages = ItemsArray<Message>()
  
  var allMessages: [Message] {
    return messages.items
  }
  
  func message(at index: Int) -> Message {
    return allMessages[index]
  }
  
  func appendMessage(_ message: Message) {
    messages.append(message)
  }
  
  func insert(_ message: Message, at index: Int) {
    messages.insert(message, at: index)
  }
  
  func replaceItem(_ message: Message, at index: Int) {
    messages.replaceItem(message, at: index)
  }
  
  func loadMessages() {
    if let _messages: ItemsArray<Message> = storage.read(StorageKey.messages) {
      messages = _messages
    }
  }
  
  func saveMessages() {
    storage.write(messages, StorageKey.messages)
  }
  
  func isStored(_ message: Message) -> Bool {
    let storedMessages = allMessages
      .filter { $0.id == message.id }
    return storedMessages.count > 0
  }

}
