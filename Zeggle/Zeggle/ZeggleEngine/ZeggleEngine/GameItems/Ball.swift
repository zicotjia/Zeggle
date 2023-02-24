//
//  Ball.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//

import CoreGraphics

class Ball: ZeggleItem {

    private var periodOfImmobility = 0
    private(set) var isSpooky = false

    init(centre: PhysicsVector2D,
         hSpeed: CGFloat,
         vSpeed: CGFloat,
         type: BallType,
         collisionAction: @escaping () -> Void = {}) {

        super.init(centre: centre, hSpeed: hSpeed,
                   vSpeed: vSpeed, radius: BallConstants.radius,
                   height: 0, width: 0, mass: BallConstants.defaultMass,
                   isFixed: false, elasticity: BallConstants.elasticity, shape: .round)

        switch type {
        case .standard:
            self.isSpooky = false
        case .spooky:
            self.isSpooky = true
        }

        setDeletionAction {
            if self.isSpooky {
                let xPos = self.physicsBody.centre.hVector.magnitude
                let yPos = CannonConstants.height
                self.physicsBody.moveTo(centre: PhysicsVector2D(horizontal: xPos, vertical: yPos))
                self.physicsBody.unlockBodyInPlace()
                self.isSpooky = false
                self.restoreHealth()
            }
        }
    }

    func stuckForTooLong() -> Bool {
        return periodOfImmobility > BallConstants.timeToBeConsideredStuck
    }

    func readyForRemoval() -> Bool {
        let body = physicsBody
        let isTouchingFloor = body.centre.vVector.magnitude + body.radius.magnitude >= DimensionsConstants.floor - 50

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
