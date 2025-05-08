//
//  BlackJackStore.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/29/25.
//

import SwiftUI
// FIXME: FIX ALERTS
class BlackJackStore: ObservableObject {
    // MARK: Viewmodel Variables that get affected by the view
    @Published private var game: GameSettings
    @Published var bet: Int = 5000
    
    // MARK: Variables for alerts
    @Published var userWin: Bool = false
    @Published var dealerWin: Bool = false
    @Published var push: Bool = false
    init() {
        game = GameSettings()
    }
    
    // MARK: model variables
    var money: Int {
        game.money
    }
    var user: GameSettings.Player {
        game.user
    }
    var dealer: GameSettings.Player {
        game.dealer
    }
    var liveHand: Bool {
        game.liveHand
    }
    
    
    // MARK: Core Game functions! Validation done at the view/user level while the actual logic is done at the model!
    func newHand() { // New Hand
        if money < bet || liveHand { // if a hand is in progress or money is less then the bet, exit
            print(invalid)
            return
        }
        userWin = false
        dealerWin = false
        push = false
        game.newHand(bet: bet)
        userWin = liveHand == false ? true : false // if a user hits a blackjack, the alert will still pop up
    }
    func hit() { // Add card to users hand
        if !liveHand { // if a hand isn't in progress, this will do nothing
            print(invalid)
            return
        }
        game.userHit()
        dealerWin = user.bustedHand // if dealer wins, then an alert will pop up
    }
    func stand() { // User stands, turn ends
        if !liveHand { // if a hand isn't in progress, this will do nothing
            print(invalid)
            return
        }
        game.stand(bet: bet)
        // MARK: checking to see who won for alert
        dealerWin = dealer.cardSum > user.cardSum && dealer.bustedHand != true
        userWin = user.cardSum > dealer.cardSum  && user.bustedHand != true
        if !userWin { // edge case for where dealer gets a busted hand
            userWin = dealer.bustedHand
        }
        push = user.cardSum == dealer.cardSum
    }
    func double() {
        if money < bet || !liveHand  {
            print(invalid)
            return
        }
        game.double(bet: bet)
        
        // MARK: checking to see who won for alert
        dealerWin = user.bustedHand
        userWin = dealer.bustedHand
    }
    
    
    // MARK: VM functions, these functions are strictly used for the view
    func increaseBetAmount() { // user increase bet amount
        if bet >= money || game.liveHand { // if bet amount higher then user money or if currently in a live hand, exit
            print(invalid)
            return
        }
        bet += 5000
    }
    func decreaseBetAmount() { // user decrease bet amount
        if bet <= 0 || game.liveHand { // if bet amount lower then 0 or if currently in a live hand, exit
            return
        }
        bet -= 5000
    }
    
    private var invalid = "Please select a valid action" // for debugging
}

