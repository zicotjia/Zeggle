//
//  BallCreator.swift
//  Zeggle
//
//  Created by Zico on 11/2/23.
//

import Foundation
import SwiftUI

class BallCreator {

    @ViewBuilder
    static func createBall(item: ZeggleItem) -> some View {
        if let ball = item as? Ball {
            BallView(ball: .constant(ball))
        } else {
            EmptyView()
        }
    }
}
