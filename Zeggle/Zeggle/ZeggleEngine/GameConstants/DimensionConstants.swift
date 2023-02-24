//
//  DimensionConstants.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//

import UIKit

struct DimensionsConstants {
    static let ceiling: CGFloat = 0
    static let floor: CGFloat = UIScreen.main.bounds.size.height
    static let leftWall: CGFloat = 0
    static let rightWall: CGFloat = UIScreen.main.bounds.size.width
    static let toolBarHeight: CGFloat = floor * 0.20
    static let horizontalCentrePosition: CGFloat = rightWall / 2
    static let tappableMinY = UIScreen.main.bounds.size.height - (DimensionsConstants.toolBarHeight + 50)
}
