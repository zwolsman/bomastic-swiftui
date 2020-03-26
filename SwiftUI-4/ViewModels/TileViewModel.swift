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
    
    var allowsHitTesting: Bool {
        get {
            state == .empty
        }
    }
    
    var color: Color {
        get {
            switch(state) {
            case .bomb:
                return .red
            case .empty, .revealed(_):
                return .gray
            case .discovered(_):
                return .green
            }
        }
    }
    
    var foreColor: Color {
        get {
            switch(state) {
            case .revealed(true):
                return .red
            default:
                return .white
            }
        }
    }
    
    var text: String {
        get {
            switch(state) {
            case .bomb, .revealed(true):
                return "BOMB"
            case .empty, .revealed(false):
                return " "
            case .discovered(let points):
                return "+\(points)"
            }
        }
    }
}
