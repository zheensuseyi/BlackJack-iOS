//
//  GameSettings.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/25/25.
//

import Foundation

struct GameSettings {
    private(set) var betAmount: Double
    private(set) var money: Double = 100000.0
    private(set) var deck: Array<String> = []
    private(set) var playerHand: Array<String> = []
    private(set) var dealerHand: Array<String> = []
    private(set) var playerSum: Int = 0
    private(set) var dealerSum: Int = 0
    private(set) var busted = false


    private(set) var valueDict = ["2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10, "A": 11]
    init(betAmount: Double, deck: Array<String>) {
        self.betAmount = betAmount
        initalizeDeck()
    }
    // helper function to initalize a deck
    mutating func initalizeDeck(){
        var cardDeck: Array<String> = []
        let suits = [" Spades", " Diamonds", " Hearts", " Clubs"]
        let names = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
        for suit in suits {
            for name in names {
                cardDeck += Array(repeating: (name + suit), count: 4)
            }
        }
    }
    
    mutating func newHand(betAmount: Double) -> () {
        if betAmount > money {
            print("You broke!")
            return
        }
        money -= betAmount
        resetHand()
        if playerSum == 21 {
            print("Blackjack!")
            money += ((betAmount * 2) * (3/2))
        }
    }
    
    // FIXME: Reset game
    mutating func resetHand() { // helper function for newHand
        clearAll()
        playerHand.append
        dealerHand.append(hitHelp())
    }
    
    mutating func clearAll() {
        busted = false
        deck.removeAll()
        playerHand.removeAll()
        dealerHand.removeAll()
    }
    mutating func hitHelp() -> String {
        deck.shuffle()
        return deck.popLast()!
    }
    
    // FIXME: hit function for both player and dealer
    mutating func cardHit(hand: [String], cardSum: Int) -> () {
        var myHand = hand
        var mySum = cardSum
        myHand.append(hitHelp())
        mySum = calculateValue(hand: myHand)
        if cardSum > 21 {
            aceCheck(hand: hand, cardSum: mySum)
        }
        
    }
    
    mutating func calculateValue(hand: [String]) -> Int {
        var handSum: Int = 0
        for card in 0..<hand.count {
            let cardValue = hand[card].components(separatedBy: " ")
            handSum += valueDict[cardValue[0]]!
        }
        return handSum
    }
    
    mutating func bustedCheck(hand: [String], cardSum: Int) {
        if cardSum > 21 {
            aceCheck(hand: hand, cardSum: cardSum)
        }
    }
    
    // FIXME: ace check for both player and dealer
    mutating func aceCheck(hand: [String], cardSum: Int) {
        var value = cardSum
        for card in 0..<hand.count {
            let cardValue = hand[card].components(separatedBy: " ")
            if cardValue[0] == "A" {
                value -= 10
            }
        }
        if value > 21 {
            busted = true
        }
    }
    // FIXME: Stand function
    mutating func stand() -> () {
        print("You have chosen to stand")
        print("Your current sum is \(playerSum)")
        
    }

    // FIXME: Broken ahh function
 /*   mutating func sumCheck(hand: [String]) -> () {
        var handSum: Int = 0
        var bustedHand = false
        for i in hand {
            handSum += valueDict[i]
        }
        if(hand.contains("Ace" && handSum > 21)) {
            handSum -= 10
        }
        if(handSum > 21) {
           // print("Busted")
            return
        }
    }*/
    
}

/*
 
 
 MARK: Intent
 
 What does my BlackJack game need?
 
 Multiple Decks
 a way to keep track of players money,
 a way for a player to be dealt a hand,
 a way for a player to split, double, hit, stand, surrender, and buy insurance
 */
