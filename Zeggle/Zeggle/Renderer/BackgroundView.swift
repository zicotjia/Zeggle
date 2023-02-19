//
//  PlayArea.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Image(ImageNameToFile.background)
                .resizable(resizingMode: .stretch)
                .ignoresSafeArea()
        }
    }
}

struct PlayArea_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
