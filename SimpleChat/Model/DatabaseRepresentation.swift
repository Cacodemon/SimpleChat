//
//  Protocols.swift
//  SimpleChat
//
//  Created by Dmitry Rykun on 9/8/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import Foundation

protocol DatabaseRepresentation {
  var representation: [String: Any] { get }
  init(_ representation: [String: Any])
}
