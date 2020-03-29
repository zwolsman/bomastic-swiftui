//
//  GameState.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 26/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI

struct GameStateView: View {
    @ObservedObject private (set) var model: GameViewModel
//    var stake: Int
//    var next: Int
//    var cashoutAction: () -> ()
//    var canCashOut: Bool
//
    var body: some View {
        VStack {
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("NEXT")
                        .font(.headline)
                    Text("\(model.next)")
                        .font(.largeTitle)
                        .foregroundColor(model.color)
                    
                }  .padding(.trailing, 8.0)
                
                
                VStack(alignment: .leading) {
                    Text("STAKE")
                        .font(.headline)
                    Text("\(model.stake)")
                        .font(.largeTitle)
                        .foregroundColor(Color.flatYellow)
                }
                
                Spacer()
                Button(action: model.cashout) {
                    Group {
                    Text("Cashout")
                    .font(.largeTitle)
                        .padding(.horizontal, 8.0)
                    }.background(model.isActive ? Color.flatYellow : Color.flatWhiteDark)
                
                }
                
                .foregroundColor(.flatWhite)
                .disabled(!model.isActive)
                
            }
            .padding(.horizontal, 16.0)
            
            
        }
    }
}
struct GameStateView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: 16.0) {
            GameStateView(model: GameViewModel(game: GameLogic(initialStake: 123, bombs: 3), color: Color.flatGreen))
            GameStateView(model: GameViewModel(game: GameLogic(initialStake: 123, bombs: 3), color: Color.flatMaroon))
            GameStateView(model: GameViewModel(game: GameLogic(initialStake: 123, bombs: 3), color: Color.flatWatermelon))
        }
    }
}
