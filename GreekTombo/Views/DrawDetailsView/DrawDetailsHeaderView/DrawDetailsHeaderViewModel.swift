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
    
    init(coordinator: NavigationCoordinator, draw: Draw) {
        self.coordinator = coordinator
        self.draw = draw
    }
    
    func presentDrawsView() {
        coordinator.presentModal(.drawsView)
    }
    
    func appendToCoordinatorDelegatesList() {
        coordinator.appendDelegate(self)
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
}


extension DrawDetailsHeaderViewModel: TimerDelegate {
    func onActionTriggered() {
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
