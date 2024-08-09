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
    
    init(coordinator: NavigationCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchDraws() {
        if !draws.isEmpty {
            draws = []
        }
        ApiManager.fetchNextDraws { [weak self] nextDraws in
            guard let self else { return }
            self.draws = nextDraws
            TimerManager.shared.appendDelegate(self)
        }
    }
    
    func presentTabMenu(_ draw: Draw) {
        coordinator.dismissModal()
        coordinator.presentTabMenu(draw: draw)
    }
}


extension DrawsViewModel: TimerDelegate {
    func onActionTriggered() {
        if draws.first?.drawTime.passed ?? true {
            fetchDraws()
        } else {
            draws = draws
        }
    }
}
