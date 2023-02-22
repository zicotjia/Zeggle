//
//  RectangleBody.swift
//  Zeggle
//
//  Created by Zico on 20/2/23.
//

import CoreGraphics

class RectangleBody: PhysicsBody {

    private(set) var top: LineBody
    private(set) var bottom: LineBody
    private(set) var right: LineBody
    private(set) var left: LineBody

    init(centre: PhysicsVector2D, hSpeed: CGFloat,
         vSpeed: CGFloat, height: CGFloat, width: CGFloat, mass: Float, isFixed: Bool,
         elasticity: Float, collisionAction: @escaping () -> Void = {}) {

        let topRight = centre.substract(vector: PhysicsVector2D(horizontal: width / 2, vertical: height / 2))
        let topLeft = centre.substract(vector: PhysicsVector2D(horizontal: width / -2, vertical: height / 2))
        let bottomRight = centre.substract(vector: PhysicsVector2D(horizontal: width / 2, vertical: height / -2))
        let bottomLeft = centre.substract(vector: PhysicsVector2D(horizontal: width / -2, vertical: height / -2))

        top = LineBody(hSpeed: hSpeed.magnitude, vSpeed: vSpeed.magnitude, mass: mass,
                     isFixed: isFixed, elasticity: elasticity,
                     start: topLeft, end: topRight)

        right = LineBody(hSpeed: hSpeed.magnitude, vSpeed: vSpeed.magnitude, mass: mass,
                     isFixed: isFixed, elasticity: elasticity,
                     start: topRight, end: bottomRight)

        left = LineBody(hSpeed: hSpeed.magnitude, vSpeed: vSpeed.magnitude, mass: mass,
                     isFixed: isFixed, elasticity: elasticity,
                     start: topLeft, end: bottomLeft)

        bottom = LineBody(hSpeed: hSpeed.magnitude, vSpeed: vSpeed.magnitude, mass: mass,
                     isFixed: isFixed, elasticity: elasticity,
                     start: bottomLeft, end: bottomRight)

        super.init(centre: centre, hSpeed: hSpeed, vSpeed: vSpeed,
                   radius: 0, height: height, width: width,
                   mass: mass, isFixed: isFixed, elasticity: elasticity)
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
        return top.isColliding(with: body) || left.isColliding(with: body)
            || right.isColliding(with: body) || bottom.isColliding(with: body)
    }

    override func isColliding(with body: LineBody) -> Bool {
        return false
    }

    override func isColliding(with body: RectangleBody) -> Bool {
        return false
    }

    func getSideThatCollide(with body: Collidable) -> LineBody? {

        if body.isColliding(with: top) {
            return top
        }

        if body.isColliding(with: right) {
            return right
        }

        if body.isColliding(with: left) {
            return left
        }

        if body.isColliding(with: bottom) {
            return bottom
        }

        return nil
    }
}
