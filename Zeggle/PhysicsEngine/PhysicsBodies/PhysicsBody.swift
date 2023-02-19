//
//  PhysicsBody.swift
//  Zeggle
//
//  Created by Zico on 5/2/23.
//
import CoreGraphics
import Foundation

class PhysicsBody: Hashable, Collidable {

    private(set) var uuid: String
    private(set) var centre: PhysicsVector2D
    private(set) var hSpeed: PhysicsVector1D
    private(set) var vSpeed: PhysicsVector1D
    private(set) var radius: PhysicsVector1D
    private(set) var height: PhysicsVector1D
    private(set) var width: PhysicsVector1D
    private(set) var mass: Float
    private(set) var isFixed: Bool
    private(set) var elasticity: Float
    private(set) var collisionAction: () -> Void

    var velocity: PhysicsVector2D {
        PhysicsVector2D(horizontalVector: hSpeed, verticalVector: vSpeed)
    }

    init(centre: PhysicsVector2D, hSpeed: CGFloat,
         vSpeed: CGFloat, radius: CGFloat, height: CGFloat,
         width: CGFloat, mass: Float, isFixed: Bool,
         elasticity: Float, collisionAction: @escaping () -> Void = {}) {
        self.uuid = UUID().uuidString
        self.centre = centre
        self.hSpeed = PhysicsVector1D(magnitude: hSpeed)
        self.vSpeed = PhysicsVector1D(magnitude: vSpeed)
        self.radius = PhysicsVector1D(magnitude: radius)
        self.height = PhysicsVector1D(magnitude: height)
        self.width = PhysicsVector1D(magnitude: width)
        self.mass = mass
        self.isFixed = isFixed
        self.elasticity = elasticity
        self.collisionAction = collisionAction
    }

    func moveTo(centre: PhysicsVector2D) {
        self.centre = centre
    }

    func moveBy(xDisplacement: PhysicsVector1D, yDisplacement: PhysicsVector1D) {
        let newX = centre.hVector.add(vector: xDisplacement)
        let newY = centre.vVector.add(vector: yDisplacement)
        let newCentre = PhysicsVector2D(horizontalVector: newX, verticalVector: newY)

        moveTo(centre: newCentre)
    }

    func addHorizontalSpeed(by vector: PhysicsVector1D) {
        hSpeed = hSpeed.add(vector: vector)
    }

    func removeHorizontalSpeed() {
        hSpeed = PhysicsVector1D.nullVector
    }

    func addVerticalSpeed(by vector: PhysicsVector1D) {
        vSpeed = vSpeed.add(vector: vector)
    }

    func removeVerticalSpeed() {
        vSpeed = PhysicsVector1D.nullVector
    }

    func addVelocity(with velocity: PhysicsVector2D) {
        addHorizontalSpeed(by: velocity.hVector)
        addVerticalSpeed(by: velocity.vVector)
    }

    func applyGravity(force: PhysicsVector1D, for duration: Float) {
        guard !isFixed else {
            return
        }
        let velocityChange = force.multiplyMagnitude(by: CGFloat(duration))
        addVerticalSpeed(by: velocityChange)
    }

    func updatePosition(timeElapsed: Float) {
        guard !isFixed else {
            return
        }
        let horizontalDisplacement = hSpeed.multiplyMagnitude(by: CGFloat(timeElapsed))
        let verticalDisplacement = vSpeed.multiplyMagnitude(by: CGFloat(timeElapsed))
        moveBy(xDisplacement: horizontalDisplacement, yDisplacement: verticalDisplacement)
    }

    func setCollisionAction(collisionAction: @escaping () -> Void) {
        self.collisionAction = collisionAction
    }

    func lockBodyInplace() {
        isFixed = true
    }

    func unlockBodyInPlace() {
        isFixed = false
    }

    static func == (lhs: PhysicsBody, rhs: PhysicsBody) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    func isColliding(with body: Collidable) -> Bool {
        body.isColliding(with: self)
    }

    func isColliding(with body: PhysicsBody) -> Bool {
        body.isColliding(with: self)
    }

    func isColliding(with body: RoundBody) -> Bool {
        body.isColliding(with: self)
    }

    func isColliding(with body: LineBody) -> Bool {
        body.isColliding(with: self)
    }

    func isColliding(with body: RectangleBody) -> Bool {
        body.isColliding(with: self)
    }

}
