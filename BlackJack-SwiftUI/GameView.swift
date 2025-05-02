//
//  ContentView.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/25/25.
//

import SwiftUI

// FIXME: Clean up code
// FIXME: Change buttons
// FIXME: Add alerts
// FIXME: Add animations
struct GameView: View {
    @StateObject var vm: BlackJackStore
    
    // FIXME: Make a grid so cards don't go out of bounds
    var body: some View {
        ZStack {
            casinoTurfGradient()
            VStack {
                HStack {
                    betButtons
                    Spacer()
                    Button("New Hand") {
                        vm.newHand()
                    }
                    Spacer()
                    Text("$\(vm.money)")
                }
                dealerHand
                Spacer()
                userHand
                HStack {
                    handButtons
                        .font(.headline)
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private var dealerHand: some View {
        HStack {
            ForEach(vm.dealer.hand, id: \.self) { card in
                Image(card)
                    .resizable()  // Make the image resizable
                    .frame(width: 100, height: 100)  // Set the desired size
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private var userHand: some View {
        HStack {
            ForEach(vm.user.hand, id: \.self) { card in
                Image(card)
                    .resizable()  // Make the image resizable
                    .frame(width: 100, height: 100)  // Set the desired size
            }
        }
    }
    
    @ViewBuilder
    private var betButtons: some View {
        VStack {
            Text("Bet: $\(vm.betAmount)")
            HStack {
                Button(action: {
                    vm.increaseBetAmount()
                }) {
                    Image(systemName: "plus.square.fill") // Or use Image("yourImageName") for assets
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
                Button(action: {
                    vm.decreaseBetAmount()
                }) {
                    Image(systemName: "minus.square.fill") // Or use Image("yourImageName") for assets
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
            }
            .background(casinoTurfGradient())
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.black, lineWidth: 2)
            )
        }
        
    }
    @ViewBuilder
    private var handButtons: some View { // FIXME: Make this shorter
        Button(action: {
            vm.stand()
        }) {
            VStack {
                Text("🐈")
                Text("STAND")
            }
            .font(.headline)
        }
        Spacer()
        Button(action: {
            vm.hit()
        }) {
            VStack {
                Text("👊")
                Text("HIT")
            }
        }
        Spacer()
        Button(action: {
            vm.double()
        }) {
            VStack {
                Text("🤑")
                Text("Double")
            }
        }
    }
}

#Preview {
    GameView(vm: BlackJackStore())
}
