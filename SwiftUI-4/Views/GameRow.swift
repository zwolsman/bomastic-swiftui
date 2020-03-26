//
//  GameRow.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 26/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI

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

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        
        GameRow(tiles: generateTiles())
            .aspectRatio(5/1, contentMode: .fit)
            .padding(32)
    }
}

private func generateTiles() -> ArraySlice<TileViewModel> {
    var tiles = [TileViewModel]()
          
    for i in 0..<5 {
        tiles.append(TileViewModel(tileState: .empty, action: {
            tiles[i].state = .bomb
        }))
    }
    return tiles[0..<5]
}
