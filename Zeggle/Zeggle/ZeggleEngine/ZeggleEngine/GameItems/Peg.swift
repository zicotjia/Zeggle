//
//  Peg.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//

import Foundation

class Peg: ZeggleItem {

    private(set) var color: PegColor

    init(centre: PhysicsVector2D, radius: CGFloat, color: PegColor, collisionAction: @escaping () -> Void = {}) {
        self.color = color
        super.init(centre: centre, hSpeed: PegConstants.initialHorizontalSpeed,
                   vSpeed: PegConstants.initialVerticalSpeed, radius: radius,
                   height: 0, width: 0, mass: PegConstants.defaultMass, isFixed: true,
                   elasticity: PegConstants.defaultElasticity, shape: .round)

        physicsBody.setCollisionAction {
            self.setHasCollided()
        }
    }

    private func setHasCollided() {
        triggerRemovalFlag()
    }
}
