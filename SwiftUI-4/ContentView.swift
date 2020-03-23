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
                GameButton(dataSource: tile)
            }
        }
    }
}

struct GameButton: View {
    @ObservedObject var dataSource: TileViewModel
    
    var body: some View {
        HStack {
            gameButton()
                .allowsHitTesting(dataSource.isEmpty)
        }
    }
    
    func gameButton() -> some View {
        let button = createButton()
        switch(dataSource.state) {
        case .empty:
            return button
                .background(Color(hue: 0.0, saturation: 0.0, brightness: 0.928))
                .foregroundColor(.white)
        case .revealed(_):
            return button
                .background(Color.green)
                .foregroundColor(.white)
        case .bomb:
            return button
                .background(Color.red)
                .foregroundColor(.white)
        }
    }
    func createButton() -> some View {
        Button(action: dataSource.action) {
            buttonText()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .clipShape(Rectangle())
        .aspectRatio(1.0, contentMode: .fill)
    }
    
    func buttonText() -> some View {
        switch(dataSource.state) {
        case .bomb:
            return Text("BOMB")
        case .empty:
            return Text("[x]")
        case .revealed(let points):
            return Text("+\(points)")
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
            }
            .padding(.horizontal, 16.0)
            
            
        }
    }
}
