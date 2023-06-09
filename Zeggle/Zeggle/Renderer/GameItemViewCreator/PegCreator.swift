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
    static func createPeg(item: ZeggleItem, state: LevelEditorStates) -> some View {
        if let peg = item as? Peg {
            switch peg.color {
            case .blue:
                PegView(peg: .constant(peg),
                        deleteButtonOn: .constant(state == .deletePeg),
                        imageName: peg.removeFlag ? ImageNameToFile.bluePegGlow : ImageNameToFile.bluePeg)
            case .orange:
                PegView(peg: .constant(peg),
                        deleteButtonOn: .constant(state == .deletePeg),
                        imageName: peg.removeFlag ? ImageNameToFile.orangePegGlow : ImageNameToFile.orangePeg)
            case .zombie:
                PegView(peg: .constant(peg), deleteButtonOn: .constant(state == .deletePeg),
                        imageName: ImageNameToFile.zombie)
            case .red:
                PegView(peg: .constant(peg),
                        deleteButtonOn: .constant(state == .deletePeg),
                        imageName: peg.removeFlag ? ImageNameToFile.redPegGlow : ImageNameToFile.redPeg)
            case .yellow:
                PegView(peg: .constant(peg),
                        deleteButtonOn: .constant(state == .deletePeg),
                        imageName: peg.removeFlag ? ImageNameToFile.yellowPegGlow : ImageNameToFile.yellowPeg)
            case .pink:
                PegView(peg: .constant(peg),
                        deleteButtonOn: .constant(state == .deletePeg),
                        imageName: peg.removeFlag ? ImageNameToFile.pinkPegGlow : ImageNameToFile.pinkPeg)
            }
        } else {
            EmptyView()
        }
    }
}
