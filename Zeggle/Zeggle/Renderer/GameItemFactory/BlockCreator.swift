//
//  BlockCreatorView.swift
//  Zeggle
//
//  Created by Zico on 20/2/23.
//
import Foundation
import SwiftUI

class BlockCreator {

    @ViewBuilder
    static func createBlock(item: ZeggleItem) -> some View {
        if let block = item as? Block {
            RectangleView(rectangle: .constant(block))
        } else {
            EmptyView()
        }
    }
}
