//
//  TileViewModel.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 23/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

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
    
    var color: Color {
        get {
            switch(state) {
            case .bomb:
                return Color.red
            case .empty:
                return Color.gray
            case .revealed(_):
                return Color.green
            }
        }
    }
    
    var text: String {
        get {
            switch(state) {
            case .bomb:
                return "BOMB"
            case .empty:
                return " "
            case .revealed(let points):
                return "+\(points)"
            }
        }
    }
}
