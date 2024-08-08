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
                _delegates.forEach({ $0.onPopToRoot() })
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
    private var _delegateProxies: [NavigationCoordinatorDelegateProxy] = []
    private var _delegates: [NavigationCoordinatorDelegate] {
        get {
            cleanDelegates()
            return _delegateProxies.compactMap { $0.delegate }
        }
    }
    
    func presentTabMenu(draw: Draw) {
        if draw.drawTime.passedIn(seconds: 15) { return }
        presentedDraw = draw
        if path.isEmpty {
            path.append(ViewType.tabMenu)
        }
        _delegates.forEach({ $0.drawSelected(draw: draw) })
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
    
    func addDelegate(_ delegate: NavigationCoordinatorDelegate) {
        cleanDelegates()
        if !_delegateProxies.contains(where: { $0.delegate === delegate }) {
            _delegateProxies.append(NavigationCoordinatorDelegateProxy(delegate: delegate))
        }
    }
    
    private func cleanDelegates() {
        _delegateProxies.removeAll(where: { $0.delegate == nil })
    }
}
