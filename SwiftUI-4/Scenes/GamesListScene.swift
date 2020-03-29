//
//  GamesListScene.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 29/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import SwiftUI

class GamesViewModel : ObservableObject {
    let id = UUID()
    @Published private (set) var games = [GameViewModel]()
    
    func addGame(game: GameViewModel) {
        games.append(game)
    }
}

struct GamesListScene: View {
    
    @ObservedObject private var model = GamesViewModel()
    @State private var createGame = false
    
    var body: some View {
        NavigationView {
        List(model.games) { game in
            NavigationLink(destination: GameScene(model: game)) {
                GameRow(model: game)
                    .frame(maxHeight: 64)
            }
        }.navigationBarTitle("Games")
            .navigationBarItems(trailing: Button(action: { self.createGame.toggle() }) { Text("New")})
            .sheet(isPresented: $createGame, content: {
                CreateGameScene(closeAction: self.showGameCreation, successAction: self.gameCreated)
            })
        }
    }
    
    
    private func gameCreated(game: GameViewModel) {
        model.addGame(game: game)
        createGame = false
    }
    private func showGameCreation() {
         createGame = true
    }
}

struct GamesListScene_Previews: PreviewProvider {
    static var previews: some View {
        GamesListScene()
    }
}
