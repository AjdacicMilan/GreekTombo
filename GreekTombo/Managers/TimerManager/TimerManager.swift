//
//  TimerManager.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 9.8.24..
//

import Foundation

class TimerManager {
    
    enum Constants {
        static var timerInterval: TimeInterval = 1
    }
    
    static var shared = TimerManager()
    
    private var timer: Timer?
    
    private var delegateWrappers: [TimerDelegateWrapper] = [] {
        didSet {
            if oldValue.isEmpty && !delegateWrappers.isEmpty {
                runTimer()
            } else if delegateWrappers.isEmpty {
                stopTimer()
            }
        }
    }
    
    private var delegates: [TimerDelegate] {
        get {
            cleanDelegates()
            return delegateWrappers.compactMap { $0.delegate }
        }
    }
    
    func appendDelegate(_ delegate: TimerDelegate) {
        delegate.onActionTriggered()
        cleanDelegates()
        if !delegateWrappers.contains(where: { $0.delegate === delegate }) {
            delegateWrappers.append(TimerDelegateWrapper(delegate: delegate))
        }
    }
    
    func removeDelegate(_ delegate: TimerDelegate) {
        cleanDelegates()
        delegateWrappers.removeAll(where: { $0.delegate === delegate })
    }
    
    private func runTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: Constants.timerInterval, repeats: true) { [weak self] _ in
                self?.timerFired()
            }
        }
    }
    
    private func timerFired() {
        delegates.forEach({ $0.onActionTriggered() })
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func cleanDelegates() {
        delegateWrappers.removeAll(where: { $0.delegate == nil })
    }
}
