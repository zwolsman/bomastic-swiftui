//
//  ContentView.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 21/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject private var model = GameViewModel(game: GameLogic(initialStake: 100, bombs: 3))
    
    var body: some View {
        NavigationView {
            VStack {
                GameField(tiles: model.tiles)
                    .padding([.top, .leading, .trailing], 16.0)
                    .layoutPriority(1)
                Spacer()
                GameStateView(stake: model.stake, next: model.next, cashoutAction: model.cashout)
                Divider()
                List(model.events, id: \.self) { event in
                    Text(event)
                }
            }.navigationBarTitle("Bombastic", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


