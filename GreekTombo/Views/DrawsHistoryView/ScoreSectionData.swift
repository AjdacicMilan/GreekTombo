//
//  ScoreSectionData.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 7.8.24..
//

import Foundation

struct ScoreSectionData: Hashable {
    var drawId: Int
    var headerTitle: String
    var winningNumbers: [WinningNumberData]
    var winningQuote: Int?
    
    init(draw: Draw, dateFormatter: DateFormatter) {
        drawId = draw.id
        let userCombinations = UserDefaults.getCombination(for: draw.id)
        let userCombinationsCount = userCombinations.count
        let headerTitleSufix = (userCombinationsCount.gameName != nil) ?  " | \(userCombinationsCount.gameName!)" : ""
        headerTitle = "\(draw.drawTime.displayTime(dateFormatter)) | Kolo: \(String(draw.id))" + headerTitleSufix
        winningNumbers = []
        let winningNumbersList = draw.winningNumbers?.list ?? []
        for index in 0..<winningNumbersList.count {
            let number = winningNumbersList[index]
            if userCombinationsCount < 2 {
                //Ticket is not valid because user has to pick at least 2 numbers
                winningNumbers.append(WinningNumberData(number: number, selected: false, order: (index + 1)))
            } else {
                winningNumbers.append(WinningNumberData(number: number, selected: userCombinations.contains(number), order: (index + 1)))
                if winningNumbers.filter({ $0.selected }).count == userCombinationsCount && winningQuote == nil {
                    //Win in the (index + 1) round
                    //Game type == userCombinationsCount (G2, G3, G4, G5)
                    winningQuote = DataManager.shared.gameOddsDict[userCombinationsCount]?.roundQuotesDict[index+1]
                }
            }
        }
    }
}

struct WinningNumberData: Hashable {
    var number: Int
    var selected: Bool
    var order: String
    
    init(number: Int, selected: Bool, order: Int) {
        self.number = number
        self.selected = selected
        self.order = "\(String(order))."
    }
}
