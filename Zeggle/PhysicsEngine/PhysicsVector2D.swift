//
//  PhysicsVector.swift
//  Zeggle
//
//  Created by Zico on 5/2/23.
//
import CoreGraphics

struct PhysicsVector2D {

    static let horizontalVector = PhysicsVector2D(horizontal: 1, vertical: 0)
    static let verticalVector = PhysicsVector2D(horizontal: 0, vertical: 1)

    private(set) var hVector: PhysicsVector1D
    private(set) var vVector: PhysicsVector1D

    var magnitude: CGFloat {
        return hypot(hVector.magnitude, vVector.magnitude)
    }

    init(horizontal: CGFloat, vertical: CGFloat) {
        hVector = PhysicsVector1D(magnitude: horizontal)
        vVector = PhysicsVector1D(magnitude: vertical)
    }

    init(horizontalVector: PhysicsVector1D, verticalVector: PhysicsVector1D) {
        self.hVector = horizontalVector
        self.vVector = verticalVector
    }

    init(horizontalVector: PhysicsVector1D) {
        self.hVector = horizontalVector
        self.vVector = PhysicsVector1D.nullVector
    }

    init(verticalVector: PhysicsVector1D) {
        self.vVector = verticalVector
        self.hVector = PhysicsVector1D.nullVector
    }

    init(centre: CGPoint) {
        self.hVector = PhysicsVector1D(magnitude: centre.x)
        self.vVector = PhysicsVector1D(magnitude: centre.y)
    }

    func add(vector: PhysicsVector2D) -> PhysicsVector2D {
        let newHorizontal = hVector.add(vector: vector.hVector)
        let newVertical = vVector.add(vector: vector.vVector)

        return PhysicsVector2D(horizontalVector: newHorizontal, verticalVector: newVertical)
    }

    func substract(vector: PhysicsVector2D) -> PhysicsVector2D {
        let newHorizontal = hVector.substract(vector: vector.hVector)
        let newVertical = vVector.substract(vector: vector.vVector)

        return PhysicsVector2D(horizontalVector: newHorizontal, verticalVector: newVertical)
    }

    func multiply(by multiple: CGFloat) -> PhysicsVector2D {
        let newHorizontal = hVector.multiplyMagnitude(by: multiple)
        let newVertical = vVector.multiplyMagnitude(by: multiple)

        return PhysicsVector2D(horizontalVector: newHorizontal, verticalVector: newVertical)
    }

    func divide(by divisor: CGFloat) -> PhysicsVector2D {
        let newHorizontal = hVector.divideMagnitude(by: divisor)
        let newVertical = vVector.divideMagnitude(by: divisor)

        return PhysicsVector2D(horizontalVector: newHorizontal, verticalVector: newVertical)
    }

    func distance(with vector: PhysicsVector2D) -> CGFloat {
        let horizontalMagnitudeDifference = hVector.magnitude - vector.hVector.magnitude
        let verticalMagnitudeDifference = vVector.magnitude - vector.vVector.magnitude

        let hypotenuse = hypot(horizontalMagnitudeDifference, verticalMagnitudeDifference)

        return hypotenuse

    }

    func normalize() -> PhysicsVector2D {
        return divide(by: magnitude)
    }

    func dotProduct(vector: PhysicsVector2D) -> Float {
        let horizontal = hVector.multiply(vector: vector.hVector)
        let vertical = vVector.multiply(vector: vector.vVector)
        return Float(horizontal.magnitude + vertical.magnitude)
    }

    func determinant(vector: PhysicsVector2D) -> Float {
        let hTimesV = hVector.multiply(vector: vector.vVector)
        let vTimesH = vVector.multiply(vector: vector.hVector)
        return Float(hTimesV.magnitude - vTimesH.magnitude)
    }

    func projection(on vector: PhysicsVector2D) -> PhysicsVector2D {
        let dotProduct = dotProduct(vector: vector)
        let magnitude = vector.magnitude
        let scalarProjection = CGFloat(dotProduct) / pow(magnitude, 2)
        let projectionH = vector.hVector.multiplyMagnitude(by: scalarProjection)
        let projectionV = vector.vVector.multiplyMagnitude(by: scalarProjection)
        return PhysicsVector2D(horizontalVector: projectionH, verticalVector: projectionV)
    }

    func angle(with vector: PhysicsVector2D) -> Float {
        let dotProduct = dotProduct(vector: vector)
        let determinant = determinant(vector: vector)
        let angleInRad = atan2(determinant, dotProduct)
        let angleInDeg = MathHelper.convertRadToDeg(rad: angleInRad)
        return angleInDeg
    }

    func reverse() -> PhysicsVector2D {
        let horizontalVector = hVector.reverse()
        let verticaVector = vVector.reverse()
        return PhysicsVector2D(horizontalVector: horizontalVector, verticalVector: verticaVector)
    }

    func centre(with vector: PhysicsVector2D) -> PhysicsVector2D {
        let horizontalCentre = hVector.add(vector: vector.hVector).divideMagnitude(by: 2)
        let verticalCentre = vVector.add(vector: vector.vVector).divideMagnitude(by: 2)
        return PhysicsVector2D(horizontalVector: horizontalCentre, verticalVector: verticalCentre)
    }

}
