//
//  DrawDetailsView.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation
import SwiftUI

struct DrawDetailsView: View {
    
    @StateObject var viewModel: DrawDetailsViewModel
    
    let numbers = Array(1...80)
    let numbersGridLayout = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 10)
    
    
    var body: some View {
        VStack(spacing: 0) {
            DrawDetailsHeaderView(viewModel: DrawDetailsHeaderViewModel(coordinator: viewModel.coordinator, draw: viewModel.draw))
            
            ScrollView {
                VStack(spacing: 0) {
                    toolsView()
                    horizontalQuotesView()
                    numbersTableView()
                    CombinationView(numbers: viewModel.selectedNumbers, preventToggling: true, onPress: viewModel.numberPressed)
                }
            }
        }
        .background(Color.dirtyWhite)
        .onFirstAppear {
            viewModel.appendToCoordinatorDelegatesList()
        }
    }
    
    
    @ViewBuilder
    func toolsView() -> some View {
        HStack {
            Text("\(viewModel.gameType.gameName ?? "Izaberite broj"):").bold()
            
            Spacer()
            
            HStack(spacing: 8) {
                Text("Slucajni odabir brojeva:")
                    .font(.system(size: 14))
                    .italic()
                Picker("", selection: $viewModel.customSelected) {
                    let numbers: [Int] = [2, 3, 4, 5]
                    ForEach(numbers, id: \.self) {
                        Text("\(String($0))")
                    }
                }
                .pickerStyle(.menu)
                .shadow()
            }
            
        }
        .padding(.horizontal)
        .padding(.top, 32)
    }
    
    
    @ViewBuilder
    func horizontalQuotesView() -> some View {
        let quoteCells = viewModel.quoteCells
        HStack(spacing: 2) {
            quoteCellView(QuoteCell(firstRow: "R.B.", secondRow: "Kvota"))
                .cornerRadius(8)
                .shadow()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(quoteCells, id: \.self) { cell in
                        quoteCellView(cell).foregroundColor(.gray)
                    }
                }
                .cornerRadius(8)
                .shadow()
            }
        }
        .background(quoteCells.isEmpty ? Color.shadowBlack : .clear)
        .cornerRadius(8)
        .padding()
    }
    
    
    @ViewBuilder
    func quoteCellView(_ cell: QuoteCell) -> some View {
        VStack(spacing: 4) {
            Text(cell.firstRow)
            Divider()
            Text(cell.secondRow)
        }
        .padding(.vertical, 4)
        .frame(width: 80)
        .border(Color.shadowFill, width: 0.5)
    }
    
    
    @ViewBuilder
    func numbersTableView() -> some View {
        LazyVGrid(columns: numbersGridLayout, spacing: 0) {
            ForEach(numbers, id: \.self) { number in
                numberCellView(number)
            }
        }.border(.black, width: 1)
            .padding()
    }
    
    
    @ViewBuilder
    func numberCellView(_ number: Int) -> some View {
        Button(action: {
            viewModel.numberPressed(number)
        }) {
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("\(number)")
                        Spacer()
                    }
                    Spacer()
                }.border(.black, width: 0.5)
                
                if viewModel.selectedNumbers.contains(number) {
                    HandDrawnCircle()
                        .stroke(.blue, lineWidth: 2)
                        .background(HandDrawnCircle()
                            .fill(.clear))
                }
            }
            
        }.foregroundColor(.black)
    }
}
