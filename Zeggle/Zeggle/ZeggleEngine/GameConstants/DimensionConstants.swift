//
//  DimensionConstants.swift
//  Zeggle
//
//  Created by Zico on 9/2/23.
//

import UIKit

struct DimensionsConstants {
    static let defaultHeight: CGFloat = 2160
    static let defaultWidth: CGFloat = 1620
    static let deviceHeight: CGFloat = UIScreen.main.bounds.size.height
    static let deviceWidth: CGFloat = UIScreen.main.bounds.size.width
    static let resolutionRatio: CGFloat = deviceWidth / defaultWidth
    static let detailViewHeight: CGFloat = deviceHeight * 0.1
    static let toolBarHeight: CGFloat = deviceHeight * 0.2
    static let boxedHeight = deviceWidth
    static let tappableLevelHeight = levelHeight * 0.8
    static let tappableLevelWidth = deviceWidth
    static let tappableMinY = deviceHeight - tappableLevelHeight - toolBarHeight
    static let tappableMaxY = deviceHeight - toolBarHeight
    static let editorMaxHeight = deviceHeight
    static let levelHeight = deviceWidth * 1.2
    static let levelWidth = deviceWidth
    static let tappableMinX = 0
    static let tappableMaxX = levelWidth
    static let ceiling: CGFloat = 0
    static let floor: CGFloat = UIScreen.main.bounds.size.height
    static let leftWall: CGFloat = 0
    static let rightWall: CGFloat = UIScreen.main.bounds.size.width
    static let horizontalCentrePosition: CGFloat = rightWall / 2
}
