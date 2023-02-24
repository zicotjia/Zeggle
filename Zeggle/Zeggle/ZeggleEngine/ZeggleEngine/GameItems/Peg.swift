//
//  Peg.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//

import Foundation

class Peg: ZeggleItem {

    private(set) var color: PegColor
    private var periodOfImmobility = 0
    private var zombie: Bool = false

    init(centre: PhysicsVector2D, radius: CGFloat, color: PegColor, collisionAction: @escaping () -> Void = {}) {
        self.color = color
        super.init(centre: centre, hSpeed: PegConstants.initialHorizontalSpeed,
                   vSpeed: PegConstants.initialVerticalSpeed, radius: radius,
                   height: 0, width: 0, mass: PegConstants.defaultMass, isFixed: true,
                   elasticity: PegConstants.defaultElasticity, shape: .round)

        if color == .zombie {
            self.zombie = true
            physicsBody.setCollisionAction {
                self.physicsBody.unlockBodyInPlace()
            }
        } else {
            physicsBody.setCollisionAction {
                self.setHasCollided()
            }
        }
        changePoint(to: 2)
    }

    private func setHasCollided() {
        triggerRemovalFlag()
    }

    func stuckForTooLong() -> Bool {
        return periodOfImmobility > BallConstants.timeToBeConsideredStuck
    }

    func checkKill() {
        let body = physicsBody
        let isTouchingFloor = body.centre.vVector.magnitude + body.radius.magnitude >= DimensionsConstants.floor - 100

        if isTouchingFloor {
            physicsBody.lockBodyInplace()
            physicsBody.disableCollision()
            triggerRemovalFlag()
            startDeletion()
        }
    }

    override func updatePosition(timeElapsed: Float) {
        super.updatePosition(timeElapsed: timeElapsed)
        if zombie {
            checkIfStuck()
            checkKill()
        }
    }

    private func checkIfStuck() {
        if BallConstants.VelocityStuckRange.contains(Int(physicsBody.velocity.magnitude)) {
            periodOfImmobility += 1
            return
        }
        periodOfImmobility = 0
    }

}
