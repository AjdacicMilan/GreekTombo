//
//  DrawsViewModel.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation
import SwiftUI

class DrawsViewModel: ObservableObject {
    
    var coordinator: NavigationCoordinator
    @Published var draws: [Draw] = []
    
    //Better performance if DateFormatter is initiated just once(demanding operation)
    lazy var dateFormatter: DateFormatter = {
        DateFormatter.timeFormater
    }()
    
    private var timer: Timer?
    
    init(coordinator: NavigationCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchDraws() {
        stopTimer()
        if !draws.isEmpty {
            draws = []
        }
        ApiManager.fetchNextDraws { [weak self] nextDraws in
            self?.draws = nextDraws
            self?.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.timerFired()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func presentTabMenu(_ draw: Draw) {
        coordinator.dismissModal()
        coordinator.presentTabMenu(draw: draw)
    }
    
    private func timerFired() {
        if draws.first?.drawTime.passed ?? true {
            fetchDraws()
        } else {
            draws = draws
        }
    }
}
