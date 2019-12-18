//
//  DefaultFloatingPanelLayout.swift
//  UberHack2019
//
//  Created by Jean Paul Marinho on 02/06/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import Foundation
import FloatingPanel


class DefaultFloatingPanelLayout: FloatingPanelLayout {

    var supportedPositions: [FloatingPanelPosition] = [.tip, .half, .full]
    
    func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        return [
            surfaceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            surfaceView.widthAnchor.constraint(equalToConstant: 414),
        ]
    }
    
    public var initialPosition: FloatingPanelPosition {
        return .half
    }
    
    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 100 // A top inset from safe area
        case .half: return 400 // A bottom inset from the safe area
        case .tip: return 150 // A bottom inset from the safe area
        case .hidden: return 0
        }
    }
}
