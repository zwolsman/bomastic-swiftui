//
//  CreateGameScene.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 29/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI

struct CreateGameScene: View {
    
    @State private var stake: String = "100"
    @State private var color = "Blue"
    @State private var bomb = "3 bombs"
    let bombs = ["1 bomb", "3 bombs", "5 bombs"]
    let colors:[String:Color] =
        ["Black": flatBlackColor(),
         "Blue": flatBlueColor(),
         "Brown": flatBrownColor(),
         "Coffee": flatCoffeeColor(),
         "Forest Green": flatForestGreenColor(),
         "Gray": flatGrayColor(),
         "Green": flatGreenColor(),
         "Lime": flatLimeColor(),
         "Magenta": flatMagentaColor(),
         "Maroon": flatMaroonColor(),
         "Mint": flatMintColor(),
         "NavyBlue": flatNavyBlueColor(),
         "Orange": flatOrangeColor(),
         "Pink": flatPinkColor(),
         "Plum": flatPlumColor(),
         "Powder Blue": flatPowderBlueColor(),
         "Purple": flatPurpleColor(),
         "Red": flatRedColor(),
         "Sand": flatSandColor(),
         "Sky Blue": flatSkyBlueColor(),
         "Teal": flatTealColor(),
         "Watermelon": flatWatermelonColor(),
         "White": flatWhiteColor(),
         "Yellow": flatYellowColor()]
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Stake", text: $stake)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("OPTIONS"), footer: Text("You win an increasing reward for each green tile you uncover. The more bombs you play with, the higher the reward.")) {
                    Picker(selection: $color, label: Text("Color")) {
                        
                        ForEach(Array(colors.keys).sorted(), id: \.self) { key in
                            HStack(alignment: .center) {
                                Rectangle()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(self.colors[key]!)
                                    .padding(8.0)
                                Text(key)
                            }.tag(key)
                        }
                    }
                    Picker(selection: $bomb, label: Text("Bombs")) {
                        ForEach(bombs, id: \.self) { bomb in
                            Text(bomb).tag(bomb)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical, 8.0)
                }
                Section {
                    NavigationLink(destination:
                    GameScene(game: GameLogic(initialStake: Int(stake)!, bombs: Int("\(bomb.first!)")! ), color: colors[self.color]!)) {
                        Text("Create game")
                            .foregroundColor(.accentColor)
                    }
                    
                }
            }.navigationBarTitle("Create game")
            
        }
    }
}

struct CreateGameScene_Previews: PreviewProvider {
    static var previews: some View {
        CreateGameScene()
    }
}
