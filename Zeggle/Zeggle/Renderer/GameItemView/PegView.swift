//
//  PegView.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import SwiftUI

struct PegView: View {

    @Binding var peg: Peg
    private(set) var imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: peg.physicsBody.radius.magnitude * 2, height: peg.physicsBody.radius.magnitude * 2)
            .position(x: peg.physicsBody.centre.hVector.magnitude, y: peg.physicsBody.centre.vVector.magnitude)
            .opacity(peg.healthBar)
    }
}

struct PegView_Previews: PreviewProvider {

    static let peg = Peg(centre: PhysicsVector2D(horizontal: 400, vertical: 400), radius: 50, color: .blue)

    static var previews: some View {
        PegView(peg: .constant(peg), imageName: "peg-orange-glow")
    }
}
