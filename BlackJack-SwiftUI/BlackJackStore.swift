//
//  BlackJackStore.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/29/25.
//

import SwiftUI
// FIXME: Work on VM
class BlackJackStore: ObservableObject {
    @Published var game: GameSettings = GameSettings()
    var user: GameSettings.Player {
        game.user
    }
    var money: Double {
        game.money
    }
    var dealer: GameSettings.Player {
        game.dealer
    }
    var liveHand: Bool {
        game.liveHand
    }
    func newHand() {
        game.newHand()
    }
    func hit() {
        game.userHit()
    }
    func stand() {
        game.stand()
    }
    func double() {
        game.double()
    }
    
}

/*#Preview {
    BlackJackStore(game: game)
}
*/
