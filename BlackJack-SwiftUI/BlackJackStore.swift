//
//  BlackJackStore.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/29/25.
//

import SwiftUI
// FIXME: Work on VM
class BlackJackStore: ObservableObject {
    @Published var betAmount: Int = 5000
    @Published private var game: GameSettings = GameSettings()
    
    var user: GameSettings.Player {
        game.user
    }
    var money: Int {
        game.money
    }
    var dealer: GameSettings.Player {
        game.dealer
    }
    var liveHand: Bool {
        game.liveHand
    }
    
    func newHand() {
        game.newHand(bet: betAmount)
    }
    func hit() {
        game.userHit()
    }
    func stand() {
        game.stand(bet: betAmount)
    }
    func double() {
        game.double(bet: betAmount)
    }
    
    func increaseBetAmount() -> () {
        if betAmount >= money || game.liveHand {
            return
        }
        betAmount += 5000
    }
    func decreaseBetAmount() -> () {
        if betAmount <= 0 || game.liveHand {
            return
        }
        betAmount -= 5000
    }
}

/*#Preview {
    BlackJackStore(game: game)
}
*/
