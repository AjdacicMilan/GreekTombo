//
//  TimerDelegateWrapper.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 9.8.24..
//

import Foundation

//We are using this struct for assuring a weak referencing to array of delegates
struct TimerDelegateWrapper {
    weak var delegate: TimerDelegate?
    
    init(delegate: TimerDelegate) {
        self.delegate = delegate
    }
}
