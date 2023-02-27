//
//  MenuButtonsView.swift
//  Peggle
//
//  Created by Zico on 28/1/23.
//

import SwiftUI

struct MenuButtonsView: View {

    var body: some View {
        HStack(spacing: 0) {
            LoadButtonView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.cyan)
            SaveButtonView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.red)
            ResetButtonView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.yellow)
            NameBarView()
                .frame(minWidth: DimensionsConstants.deviceWidth * 0.3, maxWidth: .infinity, maxHeight: .infinity)
            ToggleMusicView()
                .frame(minWidth: 120, maxWidth: .infinity, maxHeight: .infinity)
            StartButtonView()

        }
    }
}

struct MenuButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        MenuButtonsView()
    }
}
