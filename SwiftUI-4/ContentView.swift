//
//  ContentView.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 21/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI
import Combine


enum TileStatus : Equatable {
    case empty
    case revealed(Int)
    case bomb
}

class GameLogic {
    
    private (set) var tiles = [TileStatus]()
    let initialStake: Int
    var bombAmount: Int
    private var bombs = [Int]()
    
    private(set) var stake: Int
    private (set) var next: Int?
    
    init(initialStake: Int, bombs: Int) {
        self.initialStake = initialStake
        self.stake = initialStake //calculateStake()
        self.next = initialStake //calculateNext()
        self.bombAmount = bombs
        
        generateTiles()
        generateBombs()
    }
    
    private func generateTiles()  {
        tiles.removeAll()
        for _ in 0..<25 {
            tiles.append(.empty)
        }
    }
    
    private func generateBombs() {
        bombs.removeAll()
        repeat {
            let rng = Int.random(in: 0..<25)
            if(!bombs.contains(rng)) {
                bombs.append(rng)
            }
        }while(bombs.count < bombAmount)
    }
    
    func reveal(index: Int) -> TileStatus {
        if(bombs.contains(index)) {
            tiles[index] = .bomb
        } else {
            let state = TileStatus.revealed(try! calculateReward())
            tiles[index] = state
            stake = calculateStake()
            next = calculateNext()
        }
        
        return tiles[index] //TODO: clean this up
    }
    
    private func calculateReward() throws -> Int {
        let emptyTiles = tiles.filter { $0 == .empty }.count
        let moves = 25 - emptyTiles
        let tiles = 25
        let bombs = 3
        var odds = Double(tiles - moves) / Double(tiles - moves - bombs)
        odds *= (1 - 0.005)
        return Int(floor(Double(stake) * odds)) - stake
    }
    
    private func calculateStake() -> Int {
        return tiles.reduce(initialStake) { (acc, tile) -> Int in
            if case let TileStatus.revealed(points) = tile {
                return acc + points
            } else {
                return acc
            }
        }
    }
    
    private func calculateNext() -> Int? {
        do {
            return try calculateReward()
        } catch (_) {
            return nil
        }
    }
}

class GameViewModel : ObservableObject {
    @Published private (set) var tiles = [TileViewModel]()
    @Published private (set) var stake: Int
    @Published private (set) var next: Int
    @Published private (set) var events = [String]()
    
    private let game: GameLogic
    
    init(game: GameLogic) {
        self.game = game
        self.stake = game.stake
        self.next = game.next!
        
        events.append("Started game with \(game.bombAmount) bombs and an initial stake of \(game.initialStake)")
        bindTiles()
    }
    
    private func bindTiles() {
        for i in game.tiles.indices {
            let model = TileViewModel(tileState: game.tiles[i]) {
                self.revealTile(index: i)
            }
            tiles.append(model)
        }
    }
    
    func cashout() {
        print("TODO")
    }
    
    private func revealTile(index: Int) {
        let newState = game.reveal(index: index)
        tiles[index].state = newState //TODO tidy up
        
        if case let TileStatus.revealed(points) = newState {
            events.insert("Found \(points) at tile \(index + 1)", at: 0)
        }
        if case TileStatus.bomb = newState {
            events.insert("Hit a bomb at tile \(index + 1)", at: 0)
        }
        
        if let next = game.next {
            self.stake = game.stake
            self.next = next
        }
    }
    
}

class TileViewModel : ObservableObject, Identifiable, CustomDebugStringConvertible {
    var debugDescription: String {
        "TileViewModel(state=\(state))"
    }
    
    
    let id = UUID()
    
    @Published var state: TileStatus
    let action: () -> ()
    
    init(tileState: TileStatus, action: @escaping () -> ()) {
        self.state = tileState
        self.action = action
    }
    
    var isEmpty: Bool {
        get {
            state == .empty
        }
    }
}

struct ContentView: View {
    @ObservedObject private var model = GameViewModel(game: GameLogic(initialStake: 100, bombs: 3))
    
    var body: some View {
        NavigationView {
            VStack {
                GameField(tiles: model.tiles)
                    .padding([.top, .leading, .trailing], 16.0)
                    .layoutPriority(1)
                Spacer()
                GameStateView(stake: model.stake, next: model.next)
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
        print("Rendering state \(dataSource.state)")
        switch(dataSource.state) {
        case .bomb:
            return Text("BOMB")
        case .empty:
            return Text("[x]")
        case .revealed(let points):
            return Text("\(points)")
        }
    }
}

struct GameStateView: View {
    var stake: Int
    var next: Int
    
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
                Button(action: {}) {
                    Text("Cashout")
                        .font(.largeTitle)
                }
            }
            .padding(.horizontal, 16.0)
            
            
        }
    }
}
