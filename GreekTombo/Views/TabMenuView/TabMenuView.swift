//
//  TabMenuView.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation
import SwiftUI

struct TabMenuView: View {
    
    @StateObject var coordinator: NavigationCoordinator
    
    var body: some View {
        VStack {
            TabView {
                DrawDetailsView(viewModel: DrawDetailsViewModel(coordinator: coordinator, draw: coordinator.presentedDraw!))
                    .tabItem {
                        Image("tableIcon")
                        Text("Talon")
                    }
                    .tag(Tab.drawDetails)
                
                DrawLiveView(viewModel: DrawLiveViewModel(coordinator: coordinator))
                    .tabItem {
                        Image("playIcon")
                        Text("Uzivo")
                    }
                    .tag(Tab.drawLive)
                
                DrawsHistoryView(viewModel: DrawsHistoryViewModel(coordinator: coordinator))
                    .tabItem {
                        Image("historyIcon")
                        Text("Rezultati")
                    }
                    .tag(Tab.drawsHistory)
            }
            .accentColor(.blue)
        }
    }
}
