//
//  GameViewModel.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 23/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import Foundation
import Combine

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
        events.insert("Cashed out \(stake) points. You've earned \(stake - game.initialStake) points", at: 0)
    }
    
    private func revealTile(index: Int) {
        let newState = game.reveal(index: index)
        tiles[index].state = newState //TODO tidy up
        
        if case let TileStatus.revealed(points) = newState {
            events.insert("You've found \(points) points in tile \(index + 1)", at: 0)
        }
        if case TileStatus.bomb = newState {
            events.insert("You hit a bomb in tile \(index + 1) and lost \(stake) points!", at: 0)
        }
        
        if let next = game.next {
            self.stake = game.stake
            self.next = next
        }
    }
    
}
