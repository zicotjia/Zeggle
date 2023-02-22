//
//  RoundBody.swift
//  Zeggle
//
//  Created by Zico on 12/2/23.
//
import CoreGraphics

class RoundBody: PhysicsBody {

    init(centre: PhysicsVector2D, hSpeed: CGFloat,
         vSpeed: CGFloat, radius: CGFloat, mass: Float, isFixed: Bool,
         elasticity: Float, collisionAction: @escaping () -> Void = {}) {

        super.init(centre: centre, hSpeed: hSpeed, vSpeed: vSpeed,
                   radius: radius, height: 0, width: 0, mass: mass,
                   isFixed: isFixed, elasticity: elasticity)
    }

    override func isColliding(with body: Collidable) -> Bool {
        guard collisionEnable else {
            return false
        }
        return body.isColliding(with: self)
    }

    override func isColliding(with body: RoundBody) -> Bool {
        guard collisionEnable else {
            return false
        }
        let entityOneCentre = self.centre
        let entityTwoCentre = body.centre

        let distance = entityOneCentre.distance(with: entityTwoCentre)
        let sumOfRadius = self.radius.add(vector: body.radius)

        let isOverlapping = distance.magnitude <= sumOfRadius.magnitude

        return isOverlapping
    }

    override func isColliding(with body: LineBody) -> Bool {
        guard collisionEnable else {
            return false
        }
        let shortestDistance = body.distance(to: centre)

        let isColliding = shortestDistance <= radius.magnitude
        return isColliding
    }

    override func isColliding(with body: RectangleBody) -> Bool {
        guard collisionEnable else {
            return false
        }
        return false
    }

}
