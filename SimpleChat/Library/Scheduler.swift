//
//  Scheduler.swift
//  SimpleChat
//
//  Created by Dmitry Rykun on 9/8/18.
//  Copyright © 2018 Dmitry Rykun. All rights reserved.
//

import Foundation

struct Scheduler {
  static func schedule(_ timeInterval: TimeInterval, _ call: @escaping () -> ()) {
    let _ = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false)
    { timer in
      call()
      timer.invalidate()
    }
  }
}
