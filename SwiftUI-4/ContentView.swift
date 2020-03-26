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

struct GameField: View {
    let tiles: [TileViewModel]
    
    var body: some View {
        VStack(spacing: 8.0) {
            ForEach(0..<5, id: \.self) { index in
                GameRow(tiles: self.tiles[index * 5..<index * 5 + 5])
            }
        }.aspectRatio(1.0, contentMode: .fit)
    }
}

struct GameRow: View {
    let tiles: ArraySlice<TileViewModel>
    
    var body: some View {
        HStack(spacing: 8.0) {
            ForEach(tiles) { tile in
                GameButton(model: tile)
            }
        }
    }
}

struct GameButton: View {
    @ObservedObject var model: TileViewModel
    
    var body: some View {
        HStack {
            Button(action: model.action) {
                Text(model.text)
                    .foregroundColor(.white)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .clipShape(Rectangle())
            .background(model.color)
            .aspectRatio(1.0, contentMode: .fill)
            .allowsHitTesting(model.isEmpty)
        }
    }

}

struct GameStateView: View {
    var stake: Int
    var next: Int
    var cashoutAction: () -> ()
    
    var body: some View {
        VStack {
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("Next")
                        .font(.headline)
                    Text("\(next)")
                        .font(.largeTitle)
                        .foregroundColor(Color.green)
                    
                }  .padding(.trailing, 8.0)
                
                
                VStack(alignment: .leading) {
                    Text("Stake")
                        .font(.headline)
                    Text("\(stake)")
                        .font(.largeTitle)
                        .foregroundColor(Color.yellow)
                }
                
                Spacer()
                Button(action: cashoutAction) {
                    Text("Cashout")
                        .font(.largeTitle)
                }
                .padding(.horizontal, 8.0)
                .background(Color.yellow)
                .foregroundColor(.white)
                
            }
            .padding(.horizontal, 16.0)
            
            
        }
    }
}
