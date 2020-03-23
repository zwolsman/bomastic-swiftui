//
//  CreateGameView.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 22/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI

struct CreateGameView: View {
    
    @State var stake: String = ""
    @State var quantity = 0
    @State var color = "Red"
    
    let colors = ["Red": Color.red, "Blue": Color.blue, "Purple": Color.purple]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Stake", text: $stake)
                        .keyboardType(.numberPad)
                    Picker(selection: $color, label: Text("Color")) {
                        
                        ForEach(Array(colors.keys), id: \.self) { key in
                            HStack {
                                Circle()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(self.colors[key]!)
                                    .padding(8.0)
                                Text(key)
                            }.tag(key)
                        }
                    }
                }
            }.navigationBarTitle("Create game")
        }
    }
}

struct CreateGameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGameView()
    }
}
