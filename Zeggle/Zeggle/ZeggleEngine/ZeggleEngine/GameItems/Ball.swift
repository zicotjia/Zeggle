//
//  Ball.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//

import CoreGraphics

class Ball: ZeggleItem {

    private var periodOfImmobility = 0

    init(centre: PhysicsVector2D,
         hSpeed: CGFloat,
         vSpeed: CGFloat,
         collisionAction: @escaping () -> Void = {}) {

        super.init(centre: centre, hSpeed: hSpeed,
                   vSpeed: vSpeed, radius: BallConstants.radius,
                   height: 0, width: 0, mass: BallConstants.defaultMass,
                   isFixed: false, elasticity: BallConstants.elasticity, shape: .round)
    }

    func stuckForTooLong() -> Bool {
        return periodOfImmobility > BallConstants.timeToBeConsideredStuck
    }

    func readyForRemoval() -> Bool {
        let body = physicsBody
        let isTouchingFloor = body.centre.vVector.magnitude + body.radius.magnitude >= DimensionsConstants.floor

        if isTouchingFloor {
            physicsBody.lockBodyInplace()
            triggerRemovalFlag()
            return true
        }

        return false

    }

    override func updatePosition(timeElapsed: Float) {
        super.updatePosition(timeElapsed: timeElapsed)
        checkIfStuck()
    }

    private func checkIfStuck() {
        if BallConstants.VelocityStuckRange.contains(Int(physicsBody.velocity.magnitude)) {
            periodOfImmobility += 1
            return
        }
        periodOfImmobility = 0
    }
}
