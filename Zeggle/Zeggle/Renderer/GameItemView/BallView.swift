//
//  GameItemView.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import SwiftUI

struct BallView: View {
    @Binding var ball: Ball

    var body: some View {
        Image(ball.isSpooky ? ImageNameToFile.spooky : ImageNameToFile.ball )
            .resizable()
            .frame(width: ball.physicsBody.radius.magnitude * 2, height: ball.physicsBody.radius.magnitude * 2)
            .position(x: ball.physicsBody.centre.hVector.magnitude, y: ball.physicsBody.centre.vVector.magnitude)
            .opacity(ball.healthBar)
    }
}

struct BallView_Previews: PreviewProvider {
    static let imageName = ImageNameToFile.ball
    static let xPos: CGFloat = 200
    static let yPos: CGFloat = 200
    static let radius: CGFloat = 30
    static let ball = Ball(centre: PhysicsVector2D(horizontal: 1, vertical: 1), hSpeed: 0, vSpeed: 0, type: .standard)

    static var previews: some View {
        BallView(ball: .constant(ball))
    }
}
