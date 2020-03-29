//
//  GameRow.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 29/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI

struct GameRow: View {
    @ObservedObject var model: GameViewModel
    var body: some View {
        HStack {
            GameRowPreview(tiles: model.tiles)
            VStack(alignment: .leading) {
                Text("Game \(UUID())")
                    .font(.headline)
                    .lineLimit(1)
                Text(model.events.first ?? "")
                    .font(.body)
            }
        }
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(model: GameViewModel(game: GameLogic(initialStake: 100, bombs: 3), color: .flatGreen))
            .frame(height: 64)
    }
}
