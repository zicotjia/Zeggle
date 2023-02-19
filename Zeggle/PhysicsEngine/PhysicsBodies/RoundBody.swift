//
//  RoundBody.swift
//  Zeggle
//
//  Created by Zico on 12/2/23.
//

class RoundBody: PhysicsBody {

    override func isColliding(with body: Collidable) -> Bool {
        body.isColliding(with: self)
    }

    override func isColliding(with body: RoundBody) -> Bool {
        let entityOneCentre = self.centre
        let entityTwoCentre = body.centre

        let distance = entityOneCentre.distance(with: entityTwoCentre)
        let sumOfRadius = self.radius.add(vector: body.radius)

        let isOverlapping = distance.magnitude <= sumOfRadius.magnitude

        return isOverlapping
    }

    override func isColliding(with body: LineBody) -> Bool {
        let shortestDistance = body.distance(to: centre)

        let isColliding = shortestDistance <= radius.magnitude
        return isColliding
    }

}
