//
//  TileViewModel.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 23/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import Foundation
import Combine

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
}
