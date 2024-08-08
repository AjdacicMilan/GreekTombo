//
//  DrawDetailsHeaderViewModel.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 6.8.24..
//

import Foundation
import SwiftUI

class DrawDetailsHeaderViewModel: ObservableObject {
    
    var coordinator: NavigationCoordinator
    @Published var draw: Draw
    private var timer: Timer?
    
    init(coordinator: NavigationCoordinator, draw: Draw) {
        self.coordinator = coordinator
        self.draw = draw
    }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.timerFired()
            }
        }
    }
    
    func presentDrawsView() {
        coordinator.presentModal(.drawsView)
    }
    
    func appendToCoordinatorDelegatesList() {
        coordinator.addDelegate(self)
    }
    
    private func timerFired() {
        if draw.drawTime.passed {
            if let nextDraw = DataManager.shared.nextDraw {
                coordinator.presentTabMenu(draw: nextDraw)
            } else {
                coordinator.popToRoot()
            }
        } else {
            draw = draw
        }
    }
}


extension DrawDetailsHeaderViewModel: NavigationCoordinatorDelegate {
    func drawSelected(draw: Draw) {
        self.draw = draw
    }
    
    func onPopToRoot() {
        timer?.invalidate()
        timer = nil
    }
}
