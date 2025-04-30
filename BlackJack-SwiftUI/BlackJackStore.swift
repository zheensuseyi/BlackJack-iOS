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

    var deck: Array<String> {
        game.deck
    }
    var liveHand: Bool {
        game.liveHand
    }
    var handValues: [String: Int] {
        game.handValues
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
