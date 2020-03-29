//
//  GameButton.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 26/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI

struct GameButton: View {
    @ObservedObject var model: TileViewModel
    
    var body: some View {
        HStack {
            Button(action: model.action) {
                ZStack {
                    Rectangle()
                        .foregroundColor(model.color)
                Text(model.text)
                    .foregroundColor(model.foreColor)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .aspectRatio(1.0, contentMode: .fill)
            .allowsHitTesting(model.allowsHitTesting)
        }
    }

}

struct GameButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 16) {
            GameButton(model: TileViewModel(tileState: .empty, action: {}))
            .frame(width: 64, height: 64)
            
            GameButton(model: TileViewModel(tileState: .discovered(100), action: {}))
            .frame(width: 64, height: 64)
            
            GameButton(model: TileViewModel(tileState: .bomb, action: {}))
            .frame(width: 64, height: 64)
            
            GameButton(model: TileViewModel(tileState: .revealed(true), action: {}))
            .frame(width: 64, height: 64)
            
        }
    }
}
