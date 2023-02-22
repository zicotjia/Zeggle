//
//  BlockConstants.swift
//  Zeggle
//
//  Created by Zico on 21/2/23.
//
import CoreGraphics
import UIKit

struct BlockConstants {
    static let defaultHeight = 50
    static let defaultWidth = 50
    static let defaultElasticity = Float(0.6)
    static let defaultMass = Float(1000)
    static let defaultIsFixed = true
    static let minimumX = CGFloat.zero
    static let maximumX: CGFloat = UIScreen.main.bounds.size.width
    static let minimumY = CGFloat.zero
    static let maximumY: CGFloat = UIScreen.main.bounds.size.height - (DimensionsConstants.toolBarHeight + 50)

}
