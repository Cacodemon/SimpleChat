//
//  MessagePeer.swift
//  SimpleChat
//
//  Created by Dmitry Rykun on 9/8/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class MessagePeer {
  
  private var db: Firestore?
  private var reference: CollectionReference?
  private var messageListener: ListenerRegistration?

  var messageRecived: (Message) -> () = { _ in }
  
  func send(_ message: Message) {
    reference?.addDocument(data: message.representation) { error in
      if let e = error {
        print("Error sending message: \(e.localizedDescription)")
        return
      }
    }
  }
  
  private func handleDocumentChange(_ change: DocumentChange) {
    let message = Message(change.document.data())
    switch change.type {
    case .added:
      messageRecived(message)
    default:
      break
    }
  }
  
  func setup() {
    FirebaseApp.configure()
    Auth.auth().signInAnonymously { result, error in
      if let e = error {
        print("Error sending message: \(e.localizedDescription)")
        return
      }
    }
    
    db = Firestore.firestore()
    let settings = db!.settings
    settings.areTimestampsInSnapshotsEnabled = true
    db!.settings = settings
    reference = db!.collection("message")
    
//    reference!.getDocuments(completion: { (querySnapshot, error) in
//      guard let snapshot = querySnapshot else {
//        print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
//        return
//      }
//      snapshot.documentChanges.forEach { change in
//        print(change)
//      }
//    })
    
    messageListener = reference?.addSnapshotListener { querySnapshot, error in
      guard let snapshot = querySnapshot else {
        print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
        return
      }
      snapshot.documentChanges.forEach { change in
        self.handleDocumentChange(change)
      }
    }
  }
  
  deinit {
    messageListener?.remove()
  }
}
