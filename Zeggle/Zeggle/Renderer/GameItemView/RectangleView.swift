//
//  RectangleView.swift
//  Zeggle
//
//  Created by Zico on 20/2/23.
//

import SwiftUI

struct RectangleView: View {
    @Binding var rectangle: Block

    var body: some View {
        Image(ImageNameToFile.block)
            .resizable()
            .border(.black, width: 3)
            .frame(width: rectangle.physicsBody.width.magnitude, height: rectangle.physicsBody.height.magnitude)
            .position(x: rectangle.physicsBody.centre.hVector.magnitude,
                      y: rectangle.physicsBody.centre.vVector.magnitude)
            .opacity(rectangle.healthBar)
    }
}

struct RectangleView_Previews: PreviewProvider {

    static let rectangle = Block(centre: PhysicsVector2D(horizontal: 100, vertical: 100))
    static var previews: some View {
        RectangleView(rectangle: .constant(rectangle))
    }
}
