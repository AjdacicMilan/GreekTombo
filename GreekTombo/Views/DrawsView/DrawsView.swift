//
//  DrawsView.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation
import SwiftUI

struct DrawsView: View {
    
    @StateObject var viewModel: DrawsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text("GRCKI KINO (20/80)").bold().padding()
            Divider()
            HStack {
                Text("Vreme izvlacenja").bold()
                Spacer()
                Text("Preostalo za uplatu").bold()
            }.padding()
            Divider()
            ScrollView {
                Spacer().frame(height: 8)
                VStack(spacing: 8) {
                    ForEach(viewModel.draws) { draw in
                        drawItemRow(draw)
                    }
                }
            }
        }
        .background(Color.dirtyWhite)
        .onAppear(perform: viewModel.fetchDraws)
        .onFirstAppear {
            //On app init, we are loading few past draws in data session so we can handle live screen
            ApiManager.fetchScores(saveDataInSession: true)
        }
        .onDisappear(perform: viewModel.stopTimer)
    }
    
    @ViewBuilder
    func drawItemRow(_ draw: Draw) -> some View {
        Button(action: {
            viewModel.presentTabMenu(draw)
        }) {
            ZStack {
                HStack {
                    Text(draw.drawTime.displayTime(viewModel.dateFormatter))
                    Spacer()
                    Text(draw.drawTime.remainingTimeDisplay)
                }
                Image(systemName: "arrow.right").foregroundColor(.blue)
            }.padding()
        }.foregroundColor(.black)
            .shadow()
            .padding(.horizontal)
    }
}
