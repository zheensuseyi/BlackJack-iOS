//
//  ContentView.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/25/25.
//

import SwiftUI

// FIXME: Initalize view
struct ContentView: View {
    @StateObject var vm: BlackJackStore
    var body: some View {
        VStack {
            Image("2-C")
                .resizable()
                .scaledToFit()
            Text("\(vm.money)")
            HStack {
                Button("New Hand") {
                    vm.newHand()
                }
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

#Preview {
    ContentView(vm: BlackJackStore())
}
