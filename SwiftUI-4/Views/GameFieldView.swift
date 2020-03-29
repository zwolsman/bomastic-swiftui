//
//  GameFieldView.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 26/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI

struct GameField: View {
    let tiles: [TileViewModel]
    
    var body: some View {
        VStack(spacing: 8.0) {
            ForEach(0..<5, id: \.self) { index in
                GameFieldRow(tiles: self.tiles[index * 5..<index * 5 + 5])
            }
        }.aspectRatio(1.0, contentMode: .fit)
    }
}

struct GameField_Previews: PreviewProvider {
    static var previews: some View {
        GameField(tiles: generateTiles())
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
