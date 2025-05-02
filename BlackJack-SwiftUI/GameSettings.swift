//
//  GameSettings.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/25/25.
//

import Foundation
// FIXME: Figure out bet amount
struct GameSettings {
    struct Player { // Blueprint for a player, also used for dealer
        var name: String
        var hand: Array<String> = []
        var cardSum: Int = 0
        var bustedHand: Bool = false
        var backsideCard: Bool = false
        init(name: String) {
            self.name = name
        }
    }
    private(set) var handValues = ["2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10, "A": 11] // how hand values are calculated
    private(set) var money: Int = 100000 // users money
    private(set) var dealer: Player = Player(name: "Dealer")
    private(set) var user: Player = Player(name: "You")
    private(set) var deck: Array<String> = []
    private(set) var liveHand: Bool = false // checks if hand is currently being played
    
    init() {
        deck = initalizeDeck()
    }

    mutating func newHand(bet: Int) -> () {
        if money < bet || liveHand {
            print("Please select a valid action")
            return
        }
        resetHand(bet: bet)
        debuggingStatements()
        if user.cardSum == 21 {
            print("Blackjack!")
            money += (bet * 5/2)
            liveHand = false
            return
        }
    }
    
    mutating func userHit(){
        if !liveHand {
            print("Please select a valid action")
            return
        }
        print("|||||||||||| USER HITS |||||||||||| \n")
        user = cardHit(player: user)
        debuggingStatements()
        if user.bustedHand {
            print("You busted!")
            liveHand = false
        }
    }
    
    
    mutating func cardHit(player: Player) -> Player {
        var myPlayer = player
        deck.shuffle()
        myPlayer.hand.append(deck.popLast()!)
        myPlayer = calculateHandValue(player: myPlayer)
        return myPlayer
    }
    
    mutating func calculateHandValue(player: Player) -> Player {
        var myPlayer = player
        myPlayer.cardSum = 0
        for card in 0..<myPlayer.hand.count {
            let cardValue = myPlayer.hand[card].components(separatedBy: "-")
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
            let cardValue = myPlayer.hand[card].components(separatedBy: "-")
            if cardValue[0] == "A" {
                myPlayer.cardSum -= 10
            }
        }
        if myPlayer.cardSum > 21 {
            myPlayer.bustedHand = true
            liveHand = false
        }
        return myPlayer
    }
    
    mutating func double(bet: Int) -> () {
        var betAmount = bet
        if !liveHand || money < betAmount {
            print("Please select a valid action")
            return
        }
        print("|||||||||||| USER DOUBLES |||||||||||| \n")
        money -= betAmount; betAmount *= 2
        user = cardHit(player: user)
        debuggingStatements()
        if user.bustedHand {
            print("You busted!")
            liveHand = false
            return
        }
        dealerTurn(bet: betAmount)
    }
    mutating func stand(bet: Int) -> () {
        if !liveHand {
            print("Please select a valid action")
            return
        }
        print("|||||||||||| USER STANDS |||||||||||| \n")
        removeBSC()
        dealerTurn(bet: bet)
    }
    
    mutating func dealerTurn(bet: Int) -> () {
        print("Time for the dealer to draw cards")
        removeBSC()
        while !dealer.bustedHand {
            print(" ||||||||| DEALER HITS ||||||||| \n")
            dealer = cardHit(player: dealer)
            debuggingStatements()
            if dealer.cardSum > 16 && dealer.cardSum < 22 {
                print(" ||||||||| DEALER STANDS ||||||||| \n")
                compareHands(bet: bet)
                return
            }
        }
        debuggingStatements()
        print("Dealer busted! You win")
        money += (bet * 2)
    }
    
    mutating func compareHands(bet: Int) -> () {
        debuggingStatements()
        if user.cardSum > dealer.cardSum {
            print(" ||||||||| USER WINS ||||||||| \n")
            money += (bet * 2)
            liveHand = false
            return
        }
        else if user.cardSum == dealer.cardSum {
            print(" ||||||||| PUSH ||||||||| \n")
            money += bet
            liveHand = false
            return
        }
        print(" ||||||||| DEALER WINS ||||||||| \n")
        liveHand = false
    }
    
    
    mutating func resetHand(bet: Int) { // helper function for newHand
        user = Player(name: user.name)
        dealer = Player(name: dealer.name)
        deck.removeAll()
        deck = initalizeDeck()
        liveHand = true
        money -= bet
        userHit(); userHit()
        dealer = cardHit(player: dealer)
        dealer.hand.append("backside")
        dealer.backsideCard.toggle()
    }
    
    
    mutating func removeBSC(){ // function that removes the dealer backside card
        if dealer.backsideCard {
            if let BSC = dealer.hand.firstIndex(of: "backside") {
                dealer.hand.remove(at: BSC)
                dealer.backsideCard.toggle()
            }
        }
    }
    
    mutating func initalizeDeck() -> [String]{ // helper function to initalize our deck which will consist of 4 standard poker decks
        var cardDeck: Array<String> = []
        let suits = ["-S", "-D", "-H", "-C"]
        let names = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
        for suit in suits {
            for name in names {
                cardDeck += Array(repeating: (name + suit), count: 4)
            }
        }
        return cardDeck.shuffled()
    }
    
    func debuggingStatements() { // for debugging
        print("USER HAND: \(user.hand)")
        print("USER SUM: \(user.cardSum)")
        print("DEALER HAND: \(dealer.hand)")
        print("DEALER SUM: \(dealer.cardSum)")
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
