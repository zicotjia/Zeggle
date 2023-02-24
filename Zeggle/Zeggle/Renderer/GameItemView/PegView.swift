//
//  PegView.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import SwiftUI

struct PegView: View {

    @Binding var peg: Peg
    @Binding private(set) var deleteButtonOn: Bool
    private(set) var imageName: String
    @EnvironmentObject var gameLoop: GameLoop

    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 0.7).onEnded { _ in
            guard gameLoop.state == .levelDesigner else {
                return
            }
            gameLoop.level.deleteItem(zeggleItem: peg)
        }
    }

    var tapGesture: some Gesture {
        LongPressGesture(minimumDuration: 0.0).onEnded { _ in
            guard gameLoop.state == .levelDesigner && deleteButtonOn else {
                return
            }
            gameLoop.level.deleteItem(zeggleItem: peg)
        }
    }

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: peg.physicsBody.radius.magnitude * 2, height: peg.physicsBody.radius.magnitude * 2)
            .position(x: peg.physicsBody.centre.hVector.magnitude, y: peg.physicsBody.centre.vVector.magnitude)
            .opacity(peg.healthBar)
            .gesture(longPressGesture)
            .gesture(tapGesture)
    }
}

struct PegView_Previews: PreviewProvider {

    static let peg = Peg(centre: PhysicsVector2D(horizontal: 400, vertical: 400), radius: 50, color: .blue)

    static var previews: some View {
        PegView(peg: .constant(peg), deleteButtonOn: .constant(true), imageName: "peg-orange-glow")
    }
}
