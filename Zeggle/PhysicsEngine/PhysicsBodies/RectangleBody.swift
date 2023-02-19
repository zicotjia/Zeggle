//
//  RectangleBody.swift
//  Zeggle
//
//  Created by Zico on 20/2/23.
//

import CoreGraphics

class RectangleBody: PhysicsBody {

    init(centre: PhysicsVector2D, hSpeed: CGFloat,
         vSpeed: CGFloat, height: CGFloat, width: CGFloat, mass: Float, isFixed: Bool,
         elasticity: Float, collisionAction: @escaping () -> Void = {}) {

        super.init(centre: centre, hSpeed: hSpeed, vSpeed: vSpeed,
                   radius: 0, height: height, width: width,
                   mass: mass, isFixed: isFixed, elasticity: elasticity)
    }

    override func isColliding(with body: Collidable) -> Bool {
        body.isColliding(with: self)
    }

    override func isColliding(with body: RoundBody) -> Bool {
        return false
    }

    override func isColliding(with body: LineBody) -> Bool {
        return false
    }

    override func isColliding(with body: RectangleBody) -> Bool {
        return false
    }
}
