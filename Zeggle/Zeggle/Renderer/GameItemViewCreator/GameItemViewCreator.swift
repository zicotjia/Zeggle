//
//  GameItemCreator.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import Foundation
import SwiftUI

class GameItemViewCreator {

    @ViewBuilder
    static func createItemView(item: ZeggleItem, state: LevelEditorStates) -> some View {
        switch item {
        case is Ball:
            BallCreator.createBall(item: item)
        case is Peg:
            PegCreator.createPeg(item: item, state: state)
        case is Block:
            BlockCreator.createBlock(item: item, state: state)
        case is Bucket:
            BucketCreator.createBucket(item: item)
        default:
            EmptyView()
        }
    }
}
