//
//  LineBody.swift
//  Zeggle
//
//  Created by Zico on 19/2/23.
//

import CoreGraphics

class LineBody: PhysicsBody {
    private(set) var start: PhysicsVector2D
    private(set) var end: PhysicsVector2D

    var length: CGFloat {
        abs(start.distance(with: end))
    }

    init(hSpeed: CGFloat, vSpeed: CGFloat,
         radius: CGFloat, mass: Float, isFixed: Bool,
         elasticity: Float, collisionAction: @escaping () -> Void = {},
         start: CGPoint, end: CGPoint) {
        self.start = PhysicsVector2D(centre: start)
        self.end = PhysicsVector2D(centre: end)
        let centre = self.start.centre(with: self.end)
        super.init(centre: centre, hSpeed: hSpeed, vSpeed: vSpeed,
                   radius: radius, mass: mass, isFixed: isFixed,
                   elasticity: elasticity, collisionAction: collisionAction)
    }

    func distance(to centre: PhysicsVector2D) -> CGFloat {
        let startToEnd = end.substract(vector: start)
        let startToCentre = centre.substract(vector: start)

        let projection = startToCentre.projection(on: startToEnd)
        let pointOfShortestDistance = start.add(vector: projection)

        let startToPoint = pointOfShortestDistance.substract(vector: start)

        let temp = abs(startToEnd.hVector.magnitude) > abs(startToEnd.vVector.magnitude)
            ? startToPoint.hVector.magnitude / startToEnd.hVector.magnitude
            : startToPoint.vVector.magnitude / startToEnd.vVector.magnitude

        if temp <= 0.0 {
            return sqrt(centre.distance(with: start))
        } else if temp >= 1.0 {
            return sqrt(centre.distance(with: end))
        }

        return sqrt(centre.distance(with: pointOfShortestDistance))
    }

    override func isColliding(with body: Collidable) -> Bool {
        body.isColliding(with: self)
    }

    override func isColliding(with body: RoundBody) -> Bool {
        let shortestDistance = distance(to: body.centre)
        let radius = body.radius

        let isColliding = shortestDistance <= radius.magnitude
        return isColliding
    }

}