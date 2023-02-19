//
//  ZeggleItem.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//
import CoreGraphics

class ZeggleItem: Hashable {
    private(set) var physicsBody: PhysicsBody
    private(set) var removeFlag: Bool
    private(set) var undergoingDeletion: Bool
    private(set) var healthBar: Double

    var isDead: Bool {
        healthBar <= 0
    }

    init(centre: PhysicsVector2D, hSpeed: CGFloat,
         vSpeed: CGFloat, radius: CGFloat, mass: Float,
         isFixed: Bool, elasticity: Float, shape: PhysicsBodyType) {

        self.removeFlag = false
        self.undergoingDeletion = false
        self.healthBar = 1.0
        switch shape {
        case .round:
            self.physicsBody = RoundBody(centre: centre, hSpeed: hSpeed,
                                           vSpeed: vSpeed, radius: radius, mass: mass,
                                           isFixed: isFixed, elasticity: elasticity)
        }

    }

    func triggerRemovalFlag() {
        guard removeFlag == false else {
            return
        }
        removeFlag = true
    }

    func startDeletion() {
        guard undergoingDeletion == false && removeFlag else {
            return
        }
        undergoingDeletion = true
    }

    func updatePosition(timeElapsed: Float) {
        physicsBody.updatePosition(timeElapsed: timeElapsed)
        guard !isDead else {
            return
        }

        if undergoingDeletion {
            healthBar -= 0.05
        }
    }

    static func == (lhs: ZeggleItem, rhs: ZeggleItem) -> Bool {
        lhs.physicsBody == rhs.physicsBody
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(physicsBody)
    }

}