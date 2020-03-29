//
//  GameViewModel.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 23/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import Foundation
import Combine
import UIKit
import SwiftUI

class GameViewModel : ObservableObject, Identifiable {
    let id = UUID()
    @Published private (set) var tiles = [TileViewModel]()
    @Published private (set) var stake: Int
    @Published private (set) var next: Int
    @Published private (set) var events = [String]()
    @Published private (set) var isActive = true
    
    let color: Color
    
    private let game: GameLogic
    
    init(game: GameLogic, color: Color) {
        self.game = game
        self.stake = game.stake
        self.next = game.next!
        self.color = color
        
        events.append("Started game with \(game.bombAmount) bombs and an initial stake of \(game.initialStake)")
        bindTiles()
    }
    
    private func bindTiles() {
        tiles.removeAll(keepingCapacity: true)
        for i in game.tiles.indices {
            let model = TileViewModel(tileState: game.tiles[i], color: color) {
                self.revealTile(index: i)
            }
            tiles.append(model)
        }
    }
    
    func cashout() {
        events.insert("Cashed out \(stake) points. You've earned \(stake - game.initialStake) points", at: 0)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        finish()
    }
    
    private func revealTile(index: Int) {
        let newState = game.reveal(index: index)
        tiles[index].state = newState //TODO tidy up
        
        if case let TileStatus.discovered(points) = newState {
            events.insert("You've found \(points) points in tile \(index + 1)", at: 0)
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
        if case TileStatus.bomb = newState {
            events.insert("You hit a bomb in tile \(index + 1) and lost \(stake) points!", at: 0)
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            finish()
        }
        
        if let next = game.next {
            self.stake = game.stake
            self.next = next
        }
    }
    
    private func finish() {
        game.finish()
        isActive = false
        bindTiles()
    }
}
