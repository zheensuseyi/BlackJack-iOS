//
//  BlackJackStore.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/29/25.
//

import SwiftUI
// FIXME: Work on VM
class BlackJackStore: ObservableObject {
  /*  @Published var userBet: Double
    init(userBet: Double) {
        self.userBet = userBet
    }*/
    var game: GameSettings = GameSettings()

    var money: Double {
        return game.money
    }
    var dealer: GameSettings.Player {
        return game.dealer
    }
    var user: GameSettings.Player {
        return game.user
    }
    var deck: Array<String> {
        return game.deck
    }
    var liveHand: Bool {
        return game.liveHand
    }
    var handValues: [String: Int] {
        return game.handValues
    }
    
}

/*#Preview {
    BlackJackStore(game: game)
}
*/
