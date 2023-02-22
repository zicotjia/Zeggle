//
//  ContentView.swift
//  Zeggle
//
//  Created by Zico on 5/2/23.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        GameScene(gameLoop: GameLoop(level: SampleLevel.testBucket))
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
