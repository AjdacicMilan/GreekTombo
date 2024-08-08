//
//  NavigationCoordinatorDelegate.swift
//  GreekTombo
//
//  Created by Milan Ajdacic on 6.8.24..
//

import Foundation

//We are using this struct for assuring a weak referencing to array of delegates
struct NavigationCoordinatorDelegateProxy {
    weak var delegate: NavigationCoordinatorDelegate?
    
    init(delegate: NavigationCoordinatorDelegate) {
        self.delegate = delegate
    }
}

protocol NavigationCoordinatorDelegate: AnyObject {
    func drawSelected(draw: Draw) -> Void
    func onPopToRoot() -> Void
}

extension NavigationCoordinatorDelegate {
    //optional functions
    func drawSelected(draw: Draw) -> Void {}
    func onPopToRoot() -> Void {}
}
