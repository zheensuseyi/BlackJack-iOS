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
            Image("2_of_clubs")
                .resizable()
                .scaledToFit()
            Text("\(vm.deck)")
        }
        .padding()
    }
}

#Preview {
    ContentView(vm: BlackJackStore())
}
