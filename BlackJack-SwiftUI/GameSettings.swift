//
//  GameSettings.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/25/25.
//

import Foundation
// FIXME: Figure out bet amount
struct GameSettings {
    struct Player {
        var name: String
        var hand: Array<String> = []
        var cardSum: Int = 0
        var bustedHand: Bool = false
        init(name: String) {
            self.name = name
        }
    }
    private(set) var money = 100000.0
    private(set) var handValues = ["2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10, "A": 11]
    private(set) var dealer = Player(name: "Dealer")
    private(set) var user: Player = Player(name: "You")
    private(set) var deck: Array<String> = []
    private(set) var betAmount: Double = 1
    private(set) var liveHand: Bool = false
    
    init() { // will get the betAmount each hand from the player in the view, deck also gets initalized here
        deck = initalizeDeck()
    }

    mutating func newHand() -> () {
        if betAmount > money {
            print("Not enough funds")
            return
        }
        if user.cardSum == 21 {
            print("Blackjack!")
            money += ((betAmount * 2) * (3/2))
            clearBoard()
            return
        }
        resetHand()
    }
    mutating func resetHand() { // helper function for newHand
        clearBoard()
        deck = initalizeDeck()
        liveHand = true
        money -= betAmount
        user = cardHit(player: user)
        user = cardHit(player: user)
        dealer = cardHit(player: dealer)
    }
    
    // FIXME: hit function for both player and dealer
    mutating func cardHit(player: Player) -> Player {
        if !liveHand {
            print("You need to get in a new hand before doing this action")
            return player
        }
        var myPlayer = player
        deck.shuffle()
        myPlayer.hand.append(deck.popLast()!)
        myPlayer = calculateHandValue(player: myPlayer)
        return myPlayer
    }
    
    mutating func calculateHandValue(player: Player) -> Player {
        var myPlayer = player
        for card in 0..<myPlayer.hand.count {
            let cardValue = myPlayer.hand[card].components(separatedBy: " ")
            myPlayer.cardSum += handValues[cardValue[0]]!
        }
        if myPlayer.cardSum > 21 {
            myPlayer = aceCheck(player: myPlayer)
        }
        return myPlayer
    }
    
    mutating func aceCheck(player: Player) -> Player {
        var myPlayer = player
        for card in 0..<myPlayer.hand.count {
            let cardValue = myPlayer.hand[card].components(separatedBy: " ")
            if cardValue[0] == "A" {
                myPlayer.cardSum -= 10
            }
        }
        if myPlayer.cardSum > 21 {
            myPlayer.bustedHand = true
        }
        return myPlayer
    }
    
    mutating func double() -> () {
        if !liveHand || money < betAmount {
            print("Please select a valid action")
            return
        }
        print("You will now double, your turn ends now")
        money -= betAmount
        betAmount *= 2
        user = cardHit(player: user)
        if user.bustedHand {
            print("You busted!")
            clearBoard()
            return
        }
        compareHands()
    }
    mutating func stand() -> () {
        if !liveHand {
            print("Please select a valid action")
            return
        }
        print("You have chosen to stand, current cardSum is \(user.cardSum)")
        dealerTurn()
    }
    
    mutating func dealerTurn() -> () {
        print("Time for the dealer to draw cards")
        while !dealer.bustedHand {
            dealer = cardHit(player: dealer)
            if dealer.cardSum > 16 && dealer.cardSum < 22 {
                print("Dealer will now stand")
                compareHands()
                return
            }
        }
        print("Dealer busted! You wins")
        money += (betAmount * 2)
        clearBoard()
    }
    
    mutating func compareHands() -> () {
        if user.cardSum > dealer.cardSum {
            print("You win!")
            money += (betAmount * 2)
            clearBoard()
            return
        }
        else if user.cardSum == dealer.cardSum {
            print("Same value, push")
            money += betAmount
            clearBoard()
            return
        }
        else {
            print("You lost this hand")
            clearBoard()
            return
        }
    }
    
    // helper function to initalize the deck
    mutating func initalizeDeck() -> [String]{
        var cardDeck: Array<String> = []
        let suits = [" Spades", " Diamonds", " Hearts", " Clubs"]
        let names = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
        for suit in suits {
            for name in names {
                cardDeck += Array(repeating: (name + suit), count: 4)
            }
        }
        return cardDeck.shuffled()
    }

    mutating func clearBoard() { // clears the game, resets all previous hand activities except for money and name
        user = Player(name: user.name)
        dealer = Player(name: dealer.name)
        deck.removeAll()
        liveHand = false
    }
    
    // FIXME: Figure out splitting after you test some functionality
    mutating func split() -> () {
    }
    
    
}

/*
 
 
 MARK: Intent
 
 What does my BlackJack game need?
 
 Multiple Decks
 a way to keep track of players money,
 a way for a player to be dealt a hand,
 a way for a player to split, double, hit, stand, surrender, and buy insurance
 */
