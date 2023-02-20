//
//  RectangleBody.swift
//  Zeggle
//
//  Created by Zico on 20/2/23.
//

import CoreGraphics

class RectangleBody: PhysicsBody {

    private(set) var topRight: PhysicsVector2D
    private(set) var topLeft: PhysicsVector2D
    private(set) var bottomRight: PhysicsVector2D
    private(set) var bottomLeft: PhysicsVector2D

    var top: LineBody {
        LineBody(hSpeed: hSpeed.magnitude, vSpeed: vSpeed.magnitude, mass: mass,
                 isFixed: isFixed, elasticity: elasticity,
                 start: topLeft, end: topRight)
    }

    var right: LineBody {
        LineBody(hSpeed: hSpeed.magnitude, vSpeed: vSpeed.magnitude, mass: mass,
                 isFixed: isFixed, elasticity: elasticity,
                 start: topRight, end: bottomRight)
    }

    var left: LineBody {
        LineBody(hSpeed: hSpeed.magnitude, vSpeed: vSpeed.magnitude, mass: mass,
                 isFixed: isFixed, elasticity: elasticity,
                 start: topLeft, end: bottomLeft)
    }

    var bottom: LineBody {
        LineBody(hSpeed: hSpeed.magnitude, vSpeed: vSpeed.magnitude, mass: mass,
                 isFixed: isFixed, elasticity: elasticity,
                 start: bottomLeft, end: bottomRight)
    }

    init(centre: PhysicsVector2D, hSpeed: CGFloat,
         vSpeed: CGFloat, height: CGFloat, width: CGFloat, mass: Float, isFixed: Bool,
         elasticity: Float, collisionAction: @escaping () -> Void = {}) {

        topRight = centre.substract(vector: PhysicsVector2D(horizontal: width / 2, vertical: height / 2))
        topLeft = centre.substract(vector: PhysicsVector2D(horizontal: width / -2, vertical: height / 2))
        bottomRight = centre.substract(vector: PhysicsVector2D(horizontal: width / 2, vertical: height / -2))
        bottomLeft = centre.substract(vector: PhysicsVector2D(horizontal: width / -2, vertical: height / -2))

        super.init(centre: centre, hSpeed: hSpeed, vSpeed: vSpeed,
                   radius: 0, height: height, width: width,
                   mass: mass, isFixed: isFixed, elasticity: elasticity)
    }

    override func isColliding(with body: Collidable) -> Bool {
        body.isColliding(with: self)
    }

    override func isColliding(with body: RoundBody) -> Bool {
         left.isColliding(with: body)
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
