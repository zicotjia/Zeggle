//
//  Rectangle.swift
//  Zeggle
//
//  Created by Zico on 20/2/23.
//
import CoreGraphics

class Block: ZeggleItem {

    init(centre: PhysicsVector2D, height: CGFloat, collisionAction: @escaping () -> Void = {}) {

        super.init(centre: centre, hSpeed: PegConstants.initialHorizontalSpeed,
                   vSpeed: PegConstants.initialVerticalSpeed, radius: PegConstants.radius,
                   height: height, width: height * BlockConstants.heightToWidthRatio,
                   mass: PegConstants.defaultMass, isFixed: true,
                   elasticity: PegConstants.defaultElasticity, shape: PhysicsBodyType.rectangle)

        physicsBody.setCollisionAction {
            self.setHasCollided()
        }
    }

    override func updatePosition(timeElapsed: Float) {
        super.updatePosition(timeElapsed: timeElapsed)
    }

    private func setHasCollided() {
        triggerRemovalFlag()
    }
}
