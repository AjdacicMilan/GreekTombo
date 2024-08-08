//
//  DrawsHistoryViewModel.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 7.8.24..
//

import Foundation
import SwiftUI

class DrawsHistoryViewModel: ObservableObject {
    
    var coordinator: NavigationCoordinator
    var page: Int = 0
    var bottomReached: Bool = false
    var loadingInProgress: Bool = false
    @Published var sections: [ScoreSectionData] = []
    
    //Better performance if DateFormatter is initiated just once(demanding operation)
    private lazy var dateFormatter: DateFormatter = {
        DateFormatter.customDateAndTimeFormater
    }()
    
    init(coordinator: NavigationCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchScores(reload: Bool = false) {
        if reload {
            page = 0
            bottomReached = false
            sections = []
        }
        if bottomReached { return }
        loadingInProgress = true
        ApiManager.fetchScores(daysBefore: page) { [weak self] draws in
            guard let self else { return }
            loadingInProgress = false
            
            if page == 0 && draws.isEmpty {
                //Day has just started and there is now records yet
                page += 1
                fetchScores()
                return
            }
            
            if draws.isEmpty {
                bottomReached = true
            } else {
                page += 1
                let newSections = draws.map({ ScoreSectionData(draw: $0, dateFormatter: self.dateFormatter) })
                self.sections.append(contentsOf: newSections)
            }
        }
    }
    
    func loadNewPageIfNeeded(section: ScoreSectionData) {
        if bottomReached || loadingInProgress { return }
        if shoudLoadNewPageOnAppear(of: section) {
            fetchScores()
        }
    }
    
    func onScrollRefresh() {
        if loadingInProgress { return }
        loadingInProgress = true
        ApiManager.fetchScores(daysBefore: 0) { [weak self] draws in
            guard let self else { return }
            loadingInProgress = false
            if !draws.isEmpty , draws.first!.id != self.sections.first?.drawId {
                //There is new scores
                page = 1
                bottomReached = false
                sections = draws.map({ ScoreSectionData(draw: $0, dateFormatter: self.dateFormatter) })
            }
        }
    }
    
    private func shoudLoadNewPageOnAppear(of section: ScoreSectionData) -> Bool {
        guard let index = sections.firstIndex(of: section) else {
            return false
        }
        //When the 5th section from the bottom appeared, we are fetching new page
        return index >= (sections.count - 6)
    }
}
