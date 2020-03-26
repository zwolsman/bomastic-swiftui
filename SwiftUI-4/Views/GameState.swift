//
//  GameState.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 26/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI

struct GameStateView: View {
    var stake: Int
    var next: Int
    var cashoutAction: () -> ()
    
    var body: some View {
        VStack {
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("Next")
                        .font(.headline)
                    Text("\(next)")
                        .font(.largeTitle)
                        .foregroundColor(Color.green)
                    
                }  .padding(.trailing, 8.0)
                
                
                VStack(alignment: .leading) {
                    Text("Stake")
                        .font(.headline)
                    Text("\(stake)")
                        .font(.largeTitle)
                        .foregroundColor(Color.yellow)
                }
                
                Spacer()
                Button(action: cashoutAction) {
                    Text("Cashout")
                        .font(.largeTitle)
                }
                .padding(.horizontal, 8.0)
                .background(Color.yellow)
                .foregroundColor(.white)
                
            }
            .padding(.horizontal, 16.0)
            
            
        }
    }
}
struct GameStateView_Previews: PreviewProvider {
    static var previews: some View {
        GameStateView(stake: 123, next: 12, cashoutAction: {})
    }
}
