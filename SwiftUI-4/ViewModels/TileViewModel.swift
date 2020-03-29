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
    
    private let _color: Color
    
    let id = UUID()
    
    @Published var state: TileStatus
    let action: () -> ()
    
    init(tileState: TileStatus, color: Color, action: @escaping () -> ()) {
        self.state = tileState
        self.action = action
        self._color = color
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
                return flatRedColor()
            case .empty, .revealed(_):
                return flatWhiteColor()
            case .discovered(_):
                return _color
            }
        }
    }
    
    var foreColor: Color {
        get {
            switch(state) {
            case .revealed(true):
                return flatRedColor()
            default:
                return flatWhiteColor()
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
