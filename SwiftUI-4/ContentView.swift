//
//  ContentView.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 21/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI
import Combine


enum SquareStatus : Equatable {
    case empty
    case revealed(Int)
    case bomb
}

class Square : ObservableObject {
    @Published var status : SquareStatus
    
    init(status: SquareStatus) {
        self.status = status
    }
    
    var isEmpty: Bool {
        get {
            switch(status) {
            case .empty:
                return true
            default:
                return false
            }
        }
    }
}

class GameBoard: ObservableObject {
    @State var events = ["A 3-bomb game has started with a stake of 100 points"]
    @Published var stake = 100
    @Published var next: Int
    var squares = [Square]()
    var bombs = [Int]()
    
    init() {
        for _ in 0..<25 {
            squares.append(Square(status: .empty))
        }
        next = 100
        generateBombs()
    }
    
    private var emptySquares: Int {
        get {
            squares
                .filter { (Square) -> Bool in
                    switch(Square.status) {
                    case .empty:
                        return true
                    default:
                        return false
                    }
            }.count
        }
    }
    
    func reward() -> Int {
        let moves = 25 - emptySquares
        let tiles = 25
        let bombs = 3
        var odds = Double(tiles - moves) / Double(tiles - moves - bombs)
        odds *= (1 - 0.005)
        return Int(floor(Double(stake) * odds))
    }
    
    func generateBombs() {
        bombs.removeAll()
        repeat {
            let rng = Int.random(in: 0..<25)
            if(!bombs.contains(rng)) {
                bombs.append(rng)
            }
        }while(bombs.count < 3)
    }
    
    func resetGame() {
        
    }
    
    func reveal(index: Int) {
        print("Revealing \(index)")
        
        if(bombs.contains(index)) {
            squares[index].status = .bomb
        } else {
            let points = reward()
            squares[index].status = .revealed(points)
            
            stake += points
            next = reward()
        }
        print("\(squares[index].status)")
    }
    
    var gameOver: Bool {
        get {
            false
        }
    }
    
    
}


class GameLogic {
    
    private (set) var tiles = [SquareStatus]()
    private let initialStake: Int
    private var bombAmount: Int
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
    
    func reveal(index: Int) {
        if(bombs.contains(index)) {
            tiles[index] = .bomb
        } else {
            let state = SquareStatus.revealed(try! calculateReward())
            tiles[index] = state
            next = calculateNext()
        }
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
        tiles.reduce(initialStake) { (acc, tile) -> Int in
            if case let SquareStatus.revealed(points) = tile {
                return acc + points
            } else {
                return 0
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
    
    private let game: GameLogic
    
    init(game: GameLogic) {
        self.game = game
        self.stake = game.stake
        self.next = game.next!
        
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
        game.reveal(index: index)
        
        if let next = game.next {
            self.stake = game.stake
            self.next = next
        }
    }
    
}

class TileViewModel : ObservableObject {
    
    @Published private(set) var state: SquareStatus
    let action: () -> ()
    
    init(tileState: SquareStatus, action: @escaping () -> ()) {
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
    @ObservedObject private var game = GameBoard()
    
    var body: some View {
        NavigationView {
            VStack {
                GameField(game: game)
                    .padding([.top, .leading, .trailing], 16.0)
                    .layoutPriority(1)
                Spacer()
                GameStateView(stake: game.stake, next: game.next)
                Divider()
                List(game.events, id: \.self) { event in
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
    let game: GameBoard
    
    var body: some View {
        VStack(spacing: 8.0) {
            ForEach(0..<5, id: \.self) { index in
                GameRow(row: index, game: self.game)
            }
        }.aspectRatio(1.0, contentMode: .fit)
    }
}

struct GameRow: View {
    let row: Int
    let game: GameBoard
    
    var body: some View {
        HStack(spacing: 8.0) {
            ForEach(0..<5) { col -> GameButton in
                let index = self.row * 5 + col
                let square = self.game.squares[index]
                
                return GameButton(dataSource: square, action: { self.game.reveal(index: index) })
            }
        }
    }
}

struct GameButton: View {
    @ObservedObject var dataSource: Square
    var action: () -> ()
    
    var body: some View {
        HStack {
            gameButton()
                .allowsHitTesting(dataSource.isEmpty)
        }
    }
    
    func gameButton() -> some View {
        let button = createButton()
        switch(dataSource.status) {
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
        Button(action: action) {
            buttonText()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .clipShape(Rectangle())
        .aspectRatio(1.0, contentMode: .fill)
    }
    
    func buttonText() -> some View {
        print("Rendering state \(dataSource.status)")
        switch(dataSource.status) {
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
