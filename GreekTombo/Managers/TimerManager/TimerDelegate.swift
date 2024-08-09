//
//  TimerDelegate.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 9.8.24..
//

import Foundation

protocol TimerDelegate: AnyObject {
    func onActionTriggered() -> Void
}
