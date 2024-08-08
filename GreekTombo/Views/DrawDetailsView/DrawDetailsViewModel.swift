//
//  DrawDetailsViewModel.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation
import SwiftUI

class DrawDetailsViewModel: ObservableObject {
    
    enum Constants {
        static var maxSelectedNumbers: Int = 5
    }
    
    var coordinator: NavigationCoordinator
    var draw: Draw
    
    @Published var customSelected: Int = 5 {
        didSet {
            selectedNumbers = prepareRandomNumbers()
        }
    }
    
    @Published var selectedNumbers: [Int] {
        didSet {
            UserDefaults.setCombination(for: draw.id, numbers: selectedNumbers)
        }
    }
    
    var gameType: Int {
        selectedNumbers.count
    }
    
    var quoteCells: [QuoteCell] {
        let gameType = gameType
        let array = DataManager.shared.gameOddsDict[gameType]?.roundQuotesArray ?? []
        if array.isEmpty {
            return []
        }
        var result: [QuoteCell] = [QuoteCell(firstRow: gameType.gameTypePrefix, secondRow: "-")]
        array.forEach({
            result.append(QuoteCell(firstRow: "\(String($0.round)).", secondRow: "\(String($0.quote))"))
        })
        return result
    }
    
    init(coordinator: NavigationCoordinator, draw: Draw) {
        self.coordinator = coordinator
        self.draw = draw
        self.selectedNumbers = UserDefaults.getCombination(for: draw.id)
    }
    
    func numberPressed(_ pressedNumber: Int) {
        if selectedNumbers.contains(pressedNumber) {
            selectedNumbers.removeAll(where: { $0 == pressedNumber })
        } else if selectedNumbers.count < Constants.maxSelectedNumbers {
            selectedNumbers.append(pressedNumber)
        }
    }
    
    func appendToCoordinatorDelegatesList() {
        coordinator.addDelegate(self)
    }
    
    private func prepareRandomNumbers() -> [Int] {
        let range: ClosedRange<Int> = 1...80
        let allNumbers = Array(range)
        let randomNumbers = allNumbers.shuffled().prefix(customSelected)
        return Array(randomNumbers)
    }
}


extension DrawDetailsViewModel: NavigationCoordinatorDelegate {
    func drawSelected(draw: Draw) -> Void {
        self.draw = draw
        self.selectedNumbers = UserDefaults.getCombination(for: draw.id)
    }
}
