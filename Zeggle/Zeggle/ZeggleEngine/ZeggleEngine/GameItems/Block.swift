//
//  Rectangle.swift
//  Zeggle
//
//  Created by Zico on 20/2/23.
//
class Block: ZeggleItem {

    init(centre: PhysicsVector2D, collisionAction: @escaping () -> Void = {}) {

        super.init(centre: centre, hSpeed: PegConstants.initialHorizontalSpeed,
                   vSpeed: PegConstants.initialVerticalSpeed, radius: PegConstants.radius,
                   height: 100, width: 300, mass: PegConstants.defaultMass, isFixed: true,
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
