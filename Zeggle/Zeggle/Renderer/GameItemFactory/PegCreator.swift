//
//  PegCreator.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import Foundation
import SwiftUI

class PegCreator {

    @ViewBuilder
    static func createPeg(item: ZeggleItem) -> some View {
        if let peg = item as? Peg {
            switch peg.color {
            case .blue:
                PegView(peg: .constant(peg),
                        imageName: peg.removeFlag ? ImageNameToFile.bluePegGlow : ImageNameToFile.bluePeg)
            case .orange:
                PegView(peg: .constant(peg),
                        imageName: peg.removeFlag ? ImageNameToFile.orangePegGlow : ImageNameToFile.orangePeg)
            }
        } else {
            EmptyView()
        }
    }
}
