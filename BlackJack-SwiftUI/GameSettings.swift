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
    private(set) var dealer: Player = Player(name: "Dealer") // dealer
    private(set) var user: Player = Player(name: "You") // player
    private(set) var deck: Array<String> = [] // deck which gets initalized in init()
    private(set) var liveHand: Bool = false // checks if hand is currently being played
    
    init() {
        deck = initalizeDeck() // initalizing deck
    }

    mutating func newHand(bet: Int) {
        resetHand(bet: bet) // calling helper func
        debuggingStatements() // for debugging
        if user.cardSum == 21 { // if blackjack, pay user and end the hand
            print("Blackjack!")
            money += (bet * 5/2)
            liveHand = false
        }
    }
    
    mutating func userHit() {
        print("|||||||||||| USER HITS |||||||||||| \n")
        user = cardHit(player: user)
        debuggingStatements()
        if user.bustedHand {
            print("|||||||||||| USER BUSTED |||||||||||| \n")
            liveHand = false
        }
    }
    
    
    mutating func cardHit(player: Player) -> Player { // generic hit function used by both user and dealer
        var myPlayer = player
        deck.shuffle() // shuffles deck
        myPlayer.hand.append(deck.popLast()!) // appends the last card from the deck
        myPlayer = calculateHandValue(player: myPlayer) // calculates cardSum (current hand value)
        return myPlayer
    }
    
    mutating func calculateHandValue(player: Player) -> Player { // generic function to calculate hand value
        var myPlayer = player
        myPlayer.cardSum = 0
        for index in 0..<myPlayer.hand.count {
            let cards = myPlayer.hand[index].components(separatedBy: "-")
            myPlayer.cardSum += handValues[cards[0]]! // this dictionary is how we calculate card value
        }
        myPlayer = myPlayer.cardSum > 21 ? aceCheck(player: myPlayer) : myPlayer // if hand value > 21, then check for ace
        if myPlayer.cardSum > 21 { // if still > 21, its a busted hand
            myPlayer.bustedHand.toggle()
            liveHand = false
        }
        return myPlayer
    }
    
    mutating func aceCheck(player: Player) -> Player {
        var myPlayer = player
        for index in 0..<myPlayer.hand.count {
            let cards = myPlayer.hand[index].components(separatedBy: "-")
            if cards[0] == "A" {
                myPlayer.cardSum -= 10
            }
        }
        return myPlayer
    }
    
    mutating func double(bet: Int) {
        var betAmount = bet
        print("|||||||||||| USER DOUBLES |||||||||||| \n")
        money -= betAmount; betAmount *= 2
        user = cardHit(player: user)
        debuggingStatements()
        if user.bustedHand {
            print("You busted!")
            liveHand = false
            return
        }
        stand(bet: betAmount)
    }
    
    mutating func stand(bet: Int) {
        print("|||||||||||| USER STANDS |||||||||||| \n")
        removeBackSideCard()
        while !dealer.bustedHand {
            print(" ||||||||| DEALER HITS ||||||||| \n")
            dealer = cardHit(player: dealer)
            debuggingStatements()
            if dealer.cardSum > 16 && dealer.cardSum < 22 {
                print(" ||||||||| DEALER STANDS ||||||||| \n")
                compareHands(bet: bet)
                liveHand = false
                return
            }
        }
        userWins(bet: bet)
    }
    
    mutating func userWins(bet: Int) {
        debuggingStatements()
        print("Congrats! You win")
        money += (bet * 2)
        liveHand = false
    }
    
    mutating func compareHands(bet: Int) {
        debuggingStatements()
        if user.cardSum > dealer.cardSum {
            print(" ||||||||| USER WINS ||||||||| \n")
            money += (bet * 2)
            return
        }
        else if user.cardSum == dealer.cardSum {
            print(" ||||||||| PUSH ||||||||| \n")
            money += bet
            return
        }
        print(" ||||||||| DEALER WINS ||||||||| \n")
    }
    
    mutating func resetHand(bet: Int) { // helper function for newHand
        user = Player(name: user.name); dealer = Player(name: dealer.name)
        deck = initalizeDeck()
        liveHand = true
        money -= bet
        userHit(); userHit()
        dealer = cardHit(player: dealer)
        dealer.hand.append("backside")
        dealer.backsideCard.toggle()
    }
    
    mutating func removeBackSideCard(){ // function that removes the dealer backside card
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
                cardDeck.append(name + suit)
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



