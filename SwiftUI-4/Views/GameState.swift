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
    var canCashOut: Bool
    
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
                .background(canCashOut ? Color.yellow : Color.gray)
                .foregroundColor(.white)
                .disabled(!canCashOut)
                
            }
            .padding(.horizontal, 16.0)
            
            
        }
    }
}
struct GameStateView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: 16.0) {
            GameStateView(stake: 123, next: 12, cashoutAction: {}, canCashOut: true)
            GameStateView(stake: 123, next: 12, cashoutAction: {}, canCashOut: false)
        }
    }
}
