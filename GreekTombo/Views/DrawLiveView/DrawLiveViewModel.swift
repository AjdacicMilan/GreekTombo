//
//  DrawLiveViewModel.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 7.8.24..
//

import Foundation
import SwiftUI

class DrawLiveViewModel: ObservableObject {
    
    var coordinator: NavigationCoordinator
    @Published var liveDrawNumbers: [Int] = []
    var liveDraw: Draw?
    
    init(coordinator: NavigationCoordinator) {
        self.coordinator = coordinator
    }
}


extension DrawLiveViewModel: TimerDelegate {
    func onActionTriggered() {
        //Live is late a lil bit so we are moving a minute so user can follow his numbers on live
        let referentMoment = Date().addingTimeInterval(-60)
        //Finding the closest draw from session to referent moment
        let newLiveDraw = DataManager.shared.draws.closest(to: referentMoment)
        let newLiveDrawNumbers = UserDefaults.getCombination(for: newLiveDraw?.id ?? 0).sorted()
        if newLiveDraw?.id != liveDraw?.id || newLiveDrawNumbers != liveDrawNumbers {
            liveDraw = newLiveDraw
            liveDrawNumbers = newLiveDrawNumbers
        }
    }
}
