//
//  MathHelper.swift
//  Zeggle
//
//  Created by Zico on 12/2/23.
//

class MathHelper {
    static func convertRadToDeg(rad: Float) -> Float {
        return rad * -180 / Float(Double.pi)
    }
}
