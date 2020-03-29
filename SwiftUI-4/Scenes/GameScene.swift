//
//  GameScene.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 29/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI

struct GameScene: View {
    @ObservedObject var model: GameViewModel
    
    var body: some View {
        VStack {
            GameField(tiles: model.tiles)
                .padding([.top, .leading, .trailing], 16.0)
                .layoutPriority(1)
            Spacer()
            GameStateView(model: model)
            List(model.events, id: \.self) { event in
                Text(event)
                    .foregroundColor(.flatBlack)
                
            }
            .padding(.vertical, 0.0)
        }.navigationBarTitle("Bombastic", displayMode: .inline)
        
    }
}

struct GameScene_Previews: PreviewProvider {
    static var previews: some View {
        GameScene(model: GameViewModel(game: GameLogic(initialStake: 100, bombs: 3), color: Color.flatGreen))
    }
}
