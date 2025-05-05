//
//  ContentView.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/25/25.
//

import SwiftUI
// FIXME: FIX ALERTS
struct GameView: View {
    @ObservedObject var vm: BlackJackStore
    
    // MARK: The main screen!
    var body: some View {
        ZStack {
            casinoTurfGradient()
            VStack {
                TopOfScreen
                    .boldHeadLine()
                HStack {
                    adjustBetAmount
                    Spacer()
                }
                HandGridView(items: vm.dealer.hand)
                    .animation(.spring(duration: 2), value: vm.dealer.hand)
                Spacer()
                HandGridView(items: vm.user.hand)
                    .animation(.spring(duration: 2), value: vm.user.hand)
                bottomOfScreen
            }
            .padding()
        }
        
        // MARK: ALERTS
        .gameAlert(
            title: "You Lost😭",
            isPresented: $vm.dealerWin,
            message: { Text("Your Card Sum Was \(vm.user.cardSum)") }
        )
        .gameAlert(
            title: "You Win!",
            isPresented: $vm.userWin,
            message: { Text("New Bankroll $\(vm.money)💰") }
        )
        .gameAlert(
            title: "Hand pushed 😑",
            isPresented: $vm.push,
            message: { Text("Both Card Sums Is \(vm.user.cardSum)") }
        )
    }
    

    
    
    
    
    // MARK: Seperating everything for programming best practices!
    @ViewBuilder
    private var TopOfScreen: some View {
        HStack {
            Text("Bet:\n$\(vm.bet)")
            Spacer()
            Button(action: vm.newHand) {
                VStack {
                    Image("Two-Aces")
                        .imageSizeAdjust(width: 32, height: 32)
                    Text("New hand")
                }
                .font(.title3)
                .foregroundStyle(.red)
            }
            Spacer()
            Text("Total:\n$\(vm.money)")
        }
    }
    @ViewBuilder
    private var adjustBetAmount: some View {
        HStack {
            Button(action: vm.increaseBetAmount) {
                Image(systemName: "plus.square.fill")
                    .imageSizeAdjust(width: 30, height: 30)
            }
            Button(action: vm.decreaseBetAmount) {
                Image(systemName: "minus.square.fill")
                    .imageSizeAdjust(width: 30, height: 30)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.black, lineWidth: 2)
        )
    }
    @ViewBuilder
    private var bottomOfScreen: some View {
        HStack {
            Button(action: vm.stand) {
                Text("🐈\nSTAND")
            }

            
            Spacer()
            Button(action: vm.hit){
                Text("👊\nHIT")
            }
            Spacer()
            Button(action: vm.double) {
                Text("🤑\nDOUBLE")
            }
        }
        .title2Text()
    }
}

#Preview {
    GameView(vm: BlackJackStore())
}
