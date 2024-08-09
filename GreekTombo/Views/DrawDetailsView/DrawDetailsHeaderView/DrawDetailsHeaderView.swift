//
//  DrawDetailsHeaderView.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 6.8.24..
//

import Foundation
import SwiftUI

struct DrawDetailsHeaderView: View {
    
    @StateObject var viewModel: DrawDetailsHeaderViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Vreme izvlacenja: \(viewModel.draw.drawTime.displayTime()) | Kolo: \(String(viewModel.draw.id))")
                    .italic()
                    .font(.system(size: 14))
                Spacer()
            }.padding()
            Divider()
            HStack(spacing: 0) {
                Text("Preostalo vreme: ")
                    .italic()
                    .font(.system(size: 14))
                Text(viewModel.draw.drawTime.remainingTimeDisplay)
                    .font(.system(size: 14))
                
                Spacer()
                
                Button {
                    viewModel.presentDrawsView()
                } label: {
                    Text("Promeni kolo")
                        .padding(6)
                        .cornerRadius(8)
                    
                }
                .foregroundColor(.blue)
                .shadow()
            }.padding()
            Divider()
        }
        .onFirstAppear {
            viewModel.appendToCoordinatorDelegatesList()
        }
        .onAppear() {
            TimerManager.shared.appendDelegate(viewModel)
        }
        .onDisappear {
            TimerManager.shared.removeDelegate(viewModel)
        }
    }
}
