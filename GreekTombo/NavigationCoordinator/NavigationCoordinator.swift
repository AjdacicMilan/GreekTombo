//
//  NavigationCoordinator.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 5.8.24..
//

import Foundation
import SwiftUI

class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath() {
        didSet {
            if path.isEmpty {
                delegates.forEach({ $0.onPopToRoot() })
            }
        }
    }
    @Published var isPresentedModal: Bool = false {
        didSet {
            if !isPresentedModal {
                presentedModal = nil
            }
        }
    }
    var presentedModal: ViewType?
    var presentedDraw: Draw?
    private var delegateWrappers: [NavigationCoordinatorDelegateWrapper] = []
    private var delegates: [NavigationCoordinatorDelegate] {
        get {
            cleanDelegates()
            return delegateWrappers.compactMap { $0.delegate }
        }
    }
    
    func presentTabMenu(draw: Draw) {
        if draw.drawTime.passedIn(seconds: 15) { return }
        presentedDraw = draw
        if path.isEmpty {
            path.append(ViewType.tabMenu)
        }
        delegates.forEach({ $0.drawSelected(draw: draw) })
    }
    
    func popToRoot() {
        dismissModal()
        path.removeLast(path.count)
    }
    
    func presentModal(_ viewType: ViewType) {
        presentedModal = viewType
        isPresentedModal = true
    }
    
    func dismissModal() {
        if isPresentedModal {
            isPresentedModal = false
        }
    }
    
    func appendDelegate(_ delegate: NavigationCoordinatorDelegate) {
        cleanDelegates()
        if !delegateWrappers.contains(where: { $0.delegate === delegate }) {
            delegateWrappers.append(NavigationCoordinatorDelegateWrapper(delegate: delegate))
        }
    }
    
    private func cleanDelegates() {
        delegateWrappers.removeAll(where: { $0.delegate == nil })
    }
}
