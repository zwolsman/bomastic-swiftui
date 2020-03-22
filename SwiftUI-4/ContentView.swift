//
//  ContentView.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 21/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI
typealias GameState = [Int: SquareStatus]


enum SquareStatus {
    case hidden
    case revealed(Int)
    case bomb
}

struct ContentView: View {
    
    @State var events = ["A 3-bomb game has started with a stake of 100 points"]
        
    
    var body: some View {
        NavigationView {
            VStack {
                GameField()
                    .padding(.horizontal, 16.0)
                    .layoutPriority(1)
                Spacer()
                GameStateView()
                Divider()
                List(events, id: \.self) { event in
                    Text(event)
                }
            }.navigationBarTitle("Bombastic", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GameField: View {
    let size = 5
    
    var body: some View {
        VStack(spacing: 8.0) {
            ForEach(0..<size, id: \.self) { index in
                GameRow(row: index, columns: self.size)
            }
        }.aspectRatio(1.0, contentMode: .fit)
    }
}

struct GameRow: View {
    let row: Int
    let columns: Int
    
    var body: some View {
        HStack(spacing: 8.0) {
            ForEach(0..<columns) { col in
                GameButton(index: self.row * self.columns + col)
            }
        }
    }
}

struct GameButton: View {
    let index: Int
    let state = SquareStatus.hidden
    
    init(index: Int) {
        self.index = index
    }
    
    func buttonClicked() {
        print("Pressed button\(index)")
    }
    
    var body: some View {
        HStack {
            Button(action: buttonClicked) {
                buttonText()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color(hue: 0.0, saturation: 0.0, brightness: 0.928))
            .foregroundColor(.white)
            .clipShape(Rectangle())
            .aspectRatio(1.0, contentMode: .fill)
        }
    }
    
    func buttonText() -> some View {
        switch(state) {
        case .bomb:
            return Text("BOMB")
                .foregroundColor(.red)
        case .hidden:
            return Text("[x]")
        case .revealed(let points):
            return Text("\(points)")
        }
    }
}

struct GameStateView: View {
    var body: some View {
        VStack {
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("Next")
                        .font(.headline)
                    Text("116")
                        .font(.largeTitle)
                        .foregroundColor(Color.green)
                    
                }  .padding(.trailing, 8.0)
                
                
                VStack(alignment: .leading) {
                    Text("Stake")
                        .font(.headline)
                    Text("100")
                        .font(.largeTitle)
                        .foregroundColor(Color.yellow)
                }
                
                Spacer()
                Button(action: {}) {
                    Text("Cashout")
                        .font(.largeTitle)
                }
            }
            .padding(.horizontal, 16.0)
            
            
        }
    }
}

extension Array
{
    func chunked(into size: Int) -> [[Element]]
    {
        return stride(from: 0, to: count, by: size).map
        {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
