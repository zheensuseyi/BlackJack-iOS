//
//  ContentView.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/25/25.
//

import SwiftUI

// FIXME: Initalize view
struct GameView: View {
    @StateObject var vm: BlackJackStore
    @State private var inHand = false
    var body: some View {
        ZStack {
            casinoTurfGradient()
            VStack {
                HStack {
                    Button("New Hand ") {
                        vm.newHand()
                        inHand = true
                    }
                }
                Text("Zheens Casino")
                    .mainTitleText()
                if inHand {
                    displayHands
                }
                Spacer()
                Text("\(vm.money)")
                HStack {
                    Button("hit") {
                        vm.hit()
                    }
                    Button("stand") {
                        vm.stand()
                    }
                    Button("double") {
                        vm.double()
                    }
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private var displayHands: some View {
        HStack {
            ForEach(vm.dealer.hand, id: \.self) { card in
                Image(card)
                    .resizable()  // Make the image resizable
                    .frame(width: 100, height: 100)  // Set the desired size
            }
        }
        Spacer()
        HStack {
            ForEach(vm.user.hand, id: \.self) { card in
                Image(card)
                    .resizable()  // Make the image resizable
                    .frame(width: 100, height: 100)  // Set the desired size
                
            }
            .padding()
        }
    }
}

#Preview {
    GameView(vm: BlackJackStore())
}
