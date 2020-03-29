//
//  GameRowPreview.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 29/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI

struct GameRowPreview: View {
    let tiles: [TileViewModel]
    
    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<5) { row in
                HStack(spacing: 2) {
                    ForEach(0..<5) { col in
                        Tile(model: self.tiles[row * 5 + col])
                    }
                }
            }
            
        }.aspectRatio(1.0, contentMode: .fit)
            .frame(maxHeight: 64)
    }
}

struct Tile: View {
    @ObservedObject var model: TileViewModel
    var body: some View {
        Rectangle()
            .foregroundColor(model.color)
    }
}
struct GameRowPreview_Previews: PreviewProvider {
    static var previews: some View {
        GameRowPreview(tiles: generateTiles())
        
    }
}

private func generateTiles() -> [TileViewModel] {
    var tiles = [TileViewModel]()
    
    for i in 0..<25 {
        tiles.append(TileViewModel(tileState: .empty, color: Color.flatGreen, action: {
            tiles[i].state = .bomb
        }))
    }
    return tiles
}
