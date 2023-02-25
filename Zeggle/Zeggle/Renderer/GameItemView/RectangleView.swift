//
//  RectangleView.swift
//  Zeggle
//
//  Created by Zico on 20/2/23.
//

import SwiftUI

struct RectangleView: View {
    @Binding var rectangle: Block
    @Binding private(set) var deleteButtonOn: Bool
    @EnvironmentObject var gameLoop: GameLoop

    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 0.7).onEnded { _ in
            guard gameLoop.state == .levelDesigner else {
                return
            }
            gameLoop.level.deleteItem(zeggleItem: rectangle)
        }
    }

    var tapGesture: some Gesture {
        LongPressGesture(minimumDuration: 0.0).onEnded { _ in
            guard gameLoop.state == .levelDesigner && deleteButtonOn else {
                return
            }
            gameLoop.level.deleteItem(zeggleItem: rectangle)
        }
    }

    var body: some View {
        Image(ImageNameToFile.block)
            .resizable()
            .border(.black, width: 3)
            .frame(width: rectangle.physicsBody.width.magnitude, height: rectangle.physicsBody.height.magnitude)
            .position(x: rectangle.physicsBody.centre.hVector.magnitude,
                      y: rectangle.physicsBody.centre.vVector.magnitude)
            .opacity(rectangle.healthBar)
            .gesture(longPressGesture)
            .gesture(tapGesture)
    }
}

struct RectangleView_Previews: PreviewProvider {

    static let rectangle = Block(centre: PhysicsVector2D(horizontal: 100, vertical: 100), height: 50)
    static var previews: some View {
        RectangleView(rectangle: .constant(rectangle), deleteButtonOn: .constant(false))
    }
}
