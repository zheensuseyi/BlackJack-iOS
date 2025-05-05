//
//  ContentView.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/25/25.
//

import SwiftUI
// FIXME: FIX ALERTS
struct GameView: View {
    @StateObject var vm: BlackJackStore
    var body: some View {
        ZStack {
            casinoTurfGradient()
            VStack {
                TopOfScreen
                HandGridView(items: vm.dealer.hand)
                    .animation(.spring(duration: 1.3), value: vm.dealer.hand)
                Spacer()
                HandGridView(items: vm.user.hand)
                    .animation(.spring(duration: 1.3), value: vm.user.hand)
                bottomOfScreen
            }
            .alert(isPresented: $vm.gameChange) {
                vm.gameAlert
            }
            .padding()
        }
    }
    
    
    
    
    
    
    
    
    @ViewBuilder
    private var TopOfScreen: some View {
        HStack {
            betButtons
            Spacer()
            Button(action: vm.newHand) {
                VStack {
                    Image("Two-Aces")
                        .imageSizeAdjust(width: 30, height: 30)
                    Text("New hand")
                        .boldHeadLine()
                }
            }
            Spacer()
            Text("$\(vm.money)")
                .fontWeight(.bold)
        }
    }
    
    @ViewBuilder
    private var betButtons: some View {
        VStack {
            Text("Bet: $\(vm.bet)")
                .fontWeight(.bold)
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
        .boldHeadLine()
    }
}

#Preview {
    GameView(vm: BlackJackStore())
}
