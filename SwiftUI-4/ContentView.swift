//
//  ContentView.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 21/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {

    var body: some View {
        
        TabView {
            GamesListScene().tabItem {
                Image(systemName: "app.fill")
                Text("Games")
            }.tag(0)
            
            NavigationView {
                
                List {
                    Text("Invites")
                }.navigationBarTitle("Invites")
                
            }.tabItem {
                Image(systemName: "app.fill")
                Text("Invites")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


