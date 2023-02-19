//
//  PhysicsVector1D.swift
//  Zeggle
//
//  Created by Zico on 5/2/23.
//
import CoreGraphics

struct PhysicsVector1D {

    static let nullVector = PhysicsVector1D(magnitude: 0)

    private(set) var magnitude: CGFloat

    init(magnitude: CGFloat) {
        self.magnitude = magnitude
    }

    func reverse() -> PhysicsVector1D {
        return PhysicsVector1D(magnitude: -1 * magnitude)
    }

    func add(vector: PhysicsVector1D) -> PhysicsVector1D {
        let newVectorValue = magnitude + vector.magnitude
        return PhysicsVector1D(magnitude: newVectorValue)
    }

    func addMagnitude(by value: CGFloat) -> PhysicsVector1D {
        let newMagnitude = magnitude + value
        return PhysicsVector1D(magnitude: newMagnitude)
    }

    func substract(vector: PhysicsVector1D) -> PhysicsVector1D {
        let newVectorValue = magnitude - vector.magnitude
        return PhysicsVector1D(magnitude: newVectorValue)
    }

    func multiply(vector: PhysicsVector1D) -> PhysicsVector1D {
        let newVectorValue = magnitude * vector.magnitude
        return PhysicsVector1D(magnitude: newVectorValue)
    }

    func divideMagnitude(by divisor: CGFloat) -> PhysicsVector1D {
        let newVectorValue = self.magnitude / divisor
        return PhysicsVector1D(magnitude: newVectorValue)
    }

    func multiplyMagnitude(by multiple: CGFloat) -> PhysicsVector1D {
        let newVectorValue = self.magnitude * multiple
        return PhysicsVector1D(magnitude: newVectorValue)
    }
}
