//
//  GameLogic.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 23/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import Foundation

enum TileStatus : Equatable {
    case empty
    case discovered(Int)
    case bomb
    case revealed(Bool)
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
        } while(bombs.count < bombAmount)
    }
    
    func reveal(index: Int) -> TileStatus {
        if(bombs.contains(index)) {
            tiles[index] = .bomb
        } else {
            let state = TileStatus.discovered(try! calculateReward())
            tiles[index] = state
            stake = calculateStake()
            next = calculateNext()
        }
        
        return tiles[index] //TODO: clean this up
    }
    
    func finish() {
        for i in tiles.indices {
            if case TileStatus.empty = tiles[i] {
                tiles[i] = .revealed(bombs.contains(i))
            }
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
        return tiles.reduce(initialStake) { (acc, tile) -> Int in
            if case let TileStatus.discovered(points) = tile {
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
