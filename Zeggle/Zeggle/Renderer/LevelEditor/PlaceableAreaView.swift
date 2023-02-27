//
//  PlaeableAreaView.swift
//  Zeggle
//
//  Created by Zico on 27/2/23.
//

import SwiftUI

struct PlaceableAreaView: View {
    var body: some View {
        EmptyView()
            .frame(width: DimensionsConstants.tappableLevelWidth, height: DimensionsConstants.tappableLevelHeight)
            .border(.pink, width: 3)
    }
}

struct PlaeableAreaView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceableAreaView()
    }
}
