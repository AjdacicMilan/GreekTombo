//
//  ContentView.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = NavigationCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ViewType.drawsView.presentView(with: coordinator)
                .navigationDestination(for: ViewType.self) { viewType in
                    viewType.presentView(with: coordinator)
                }
        }.sheet(isPresented: $coordinator.isPresentedModal, content: modalSheet)
    }
    
    @ViewBuilder
    func modalSheet() -> some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button {
                    coordinator.dismissModal()
                } label: {
                    Text("Zatvori")
                        .padding(6)
                        .cornerRadius(8)
                    
                }
                .foregroundColor(.blue)
                .shadow()
            }.padding()
            Divider()
            coordinator.presentedModal!.presentView(with: coordinator)
        }.background(Color.dirtyWhite)
    }
}

#Preview {
    ContentView()
}
