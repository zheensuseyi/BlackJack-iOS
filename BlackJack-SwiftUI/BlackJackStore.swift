//
//  BlackJackStore.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/29/25.
//

import SwiftUI
// FIXME: FIX ALERTS
class BlackJackStore: ObservableObject {
    // MARK: viewmodel variables
    @Published var bet: Int = 5000 // default bet, can be changed by user
    @Published private var game: GameSettings = GameSettings() // initalizing viewmodel here
    @Published var gameChange: Bool = false
    var gameAlert: Alert { // this alert only gets called if gameChange = true
        let myAlert = Alert(title: Text("Hand Over"), message: Text("Your Card Sum was \(user.cardSum)"), dismissButton: .default(Text("close")))
        gameChange = false
        return myAlert
    }
    private var invalid = "Please select a valid action" // for debugging, might get turned into an alert
    
    // MARK: model variables
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
    
    
    // MARK: Model functions, validing these functions can be used here in the VM
    func newHand() {
        if money < bet || liveHand { // if a hand is in progress or money is less then the bet, exit
            print(invalid)
            return
        }
        game.newHand(bet: bet)
    }
    func hit() {
        if !liveHand {
            print(invalid)
            return
        }
        game.userHit()
        if !liveHand {
            gameChange = true
        }
    }
    func stand() {
        if !liveHand {
            print(invalid)
            return
        }
        game.stand(bet: bet)
        if !liveHand {
            gameChange = true
        }
    }
    func double() {
        if money < bet || !liveHand  {
            print(invalid)
            return
        }
        game.double(bet: bet)
        if !liveHand {
            gameChange = true
        }
    }
    
    
    // MARK: VM functions, these functions are strictly used for the view
    func increaseBetAmount() {
        if bet >= money || game.liveHand {
            print(invalid)
            return
        }
        bet += 5000
    }
    func decreaseBetAmount() {
        if bet <= 0 || game.liveHand {
            return
        }
        bet -= 5000
    }
}

