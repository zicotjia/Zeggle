//
//  ZeggleItem.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//
import CoreGraphics

class ZeggleItem: Hashable {
    var physicsBody: PhysicsBody
    private(set) var removeFlag: Bool
    private(set) var undergoingDeletion: Bool
    private(set) var healthBar: Double

    var isDead: Bool {
        healthBar <= 0
    }

    init(centre: PhysicsVector2D, hSpeed: CGFloat,
         vSpeed: CGFloat, radius: CGFloat, height: CGFloat,
         width: CGFloat, mass: Float, isFixed: Bool, elasticity: Float,
         shape: PhysicsBodyType) {

        self.removeFlag = false
        self.undergoingDeletion = false
        self.healthBar = 1.0

        switch shape {
        case .round:
            self.physicsBody = RoundBody(centre: centre, hSpeed: hSpeed,
                                           vSpeed: vSpeed, radius: radius, mass: mass,
                                           isFixed: isFixed, elasticity: elasticity)
        case .rectangle:
            self.physicsBody = RectangleBody(centre: centre, hSpeed: hSpeed,
                                             vSpeed: vSpeed, height: height, width: width,
                                             mass: mass, isFixed: isFixed, elasticity: elasticity)
        case .line:
            self.physicsBody = LineBody(hSpeed: 0, vSpeed: 0, mass: PegConstants.defaultMass,
                                        isFixed: isFixed, elasticity: 1.0, start: CGPoint(x: 500, y: 800),
                                        end: CGPoint(x: 300, y: 800))

        case .empty:
            self.physicsBody = EmptyBody(centre: centre, hSpeed: hSpeed, vSpeed: vSpeed,
                                         mass: mass, height: height, width: width,
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
