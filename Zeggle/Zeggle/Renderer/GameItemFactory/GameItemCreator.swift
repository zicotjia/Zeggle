//
//  GameItemCreator.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import Foundation
import SwiftUI

class GameItemCreator {

    @ViewBuilder
    static func createItemView(item: ZeggleItem) -> some View {
        switch item {
        case is Ball:
            BallCreator.createBall(item: item)
        case is Peg:
            PegCreator.createPeg(item: item)
        default:
            EmptyView()
        }
    }
}
