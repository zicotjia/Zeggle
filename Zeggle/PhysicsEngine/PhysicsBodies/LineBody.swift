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

    var normal: PhysicsVector2D {
        end.substract(vector: start).perpendicular.normalize()
    }

    init(hSpeed: CGFloat, vSpeed: CGFloat,
         mass: Float, isFixed: Bool,
         elasticity: Float, collisionAction: @escaping () -> Void = {},
         start: CGPoint, end: CGPoint) {
        self.start = PhysicsVector2D(centre: start)
        self.end = PhysicsVector2D(centre: end)
        let centre = self.start.centre(with: self.end)
        super.init(centre: centre, hSpeed: hSpeed, vSpeed: vSpeed,
                   radius: 0, height: 0, width: 0, mass: mass, isFixed: isFixed,
                   elasticity: elasticity, collisionAction: collisionAction)
    }

    init(hSpeed: CGFloat, vSpeed: CGFloat,
         mass: Float, isFixed: Bool,
         elasticity: Float, collisionAction: @escaping () -> Void = {},
         start: PhysicsVector2D, end: PhysicsVector2D) {
        self.start = start
        self.end = end
        let centre = self.start.centre(with: self.end)
        super.init(centre: centre, hSpeed: hSpeed, vSpeed: vSpeed,
                   radius: 0, height: 0, width: 0, mass: mass, isFixed: isFixed,
                   elasticity: elasticity, collisionAction: collisionAction)
    }

    func getPointOfShortestDistance(to centre: PhysicsVector2D) -> PhysicsVector2D {
        let startToEnd = end.substract(vector: start)
        let startToCentre = centre.substract(vector: start)

        let projection = startToCentre.projection(on: startToEnd)

        let pointOfShortestDistance = start.add(vector: projection)

        return pointOfShortestDistance
    }
    func distance(to centre: PhysicsVector2D) -> CGFloat {
        let startToEnd = end.substract(vector: start)

        let pointOfShortestDistance = getPointOfShortestDistance(to: centre)

        let startToPoint = pointOfShortestDistance.substract(vector: start)

        let temp = abs(startToEnd.hVector.magnitude) > abs(startToEnd.vVector.magnitude)
            ? startToPoint.hVector.magnitude / startToEnd.hVector.magnitude
            : startToPoint.vVector.magnitude / startToEnd.vVector.magnitude

        if temp <= 0.0 {
            return centre.distance(with: start)
        } else if temp >= 1.0 {
            return centre.distance(with: end)
        }

        return centre.distance(with: pointOfShortestDistance)
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
        let shortestDistance = distance(to: body.centre)
        let radius = body.radius

        let isColliding = shortestDistance <= radius.magnitude
        return isColliding
    }

    override func isColliding(with body: LineBody) -> Bool {
        return false
    }

    override func isColliding(with body: RectangleBody) -> Bool {
        return false
    }

}
