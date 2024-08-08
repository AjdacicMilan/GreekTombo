//
//  ViewType.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 6.8.24..
//

import Foundation
import SwiftUI

enum ViewType {
    case drawsView
    case tabMenu
    
    func presentView(with coordinator: NavigationCoordinator) -> some View {
        switch self {
        case .drawsView:
            return AnyView(DrawsView(viewModel: DrawsViewModel(coordinator: coordinator)))
        case .tabMenu:
            return AnyView(TabMenuView(coordinator: coordinator))
        }
    }
}
