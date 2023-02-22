//
//  PegDetailsView.swift
//  Zeggle
//
//  Created by Zico on 22/2/23.
//

import SwiftUI

struct BallDetailsView: View {

    @Binding var ballsLeft: Int

    var body: some View {
        HStack {
            Image(ImageNameToFile.ball)
                .resizable()
                .frame(width: 50, height: 50)
            Text("x \(ballsLeft)")
        }
    }
}

struct PegDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BallDetailsView(ballsLeft: .constant(1))
    }
}
