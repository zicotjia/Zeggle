//
//  PegConstants.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//

import UIKit

struct PegConstants {
    static let initialHorizontalSpeed = CGFloat.zero
    static let initialVerticalSpeed = CGFloat.zero
    static let defaultMass = Float(1000)
    static let defaultIsFixed = true
    static let radius: CGFloat = 27 * DimensionsConstants.resolutionRatio
    static let minimumX = CGFloat.zero
    static let maximumX: CGFloat = UIScreen.main.bounds.size.width
    static let minimumY = CGFloat.zero
    static let maximumY: CGFloat = UIScreen.main.bounds.size.height - (DimensionsConstants.toolBarHeight + 50)
    static let fullOpacity: Double = 1
    static let onDragOpacity: Double = 0.3
    static let defaultElasticity = Float(0.8)
}
