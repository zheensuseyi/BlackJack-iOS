//
//  AspectVGrid.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 5/1/25.
//

import SwiftUI

// FIXME: Make this file a grid with dynamically adjusting collums so that the cards dont go out of bounds
// FIXME: ADD ANIMATIONS TO THE CARDS
// FIXME:
struct DealerCardView: View, Animatable {
    @ObservedObject var vm: BlackJackStore
    var body: some View {
        HStack {
            ForEach(vm.dealer.hand, id: \.self) { card in
                Image(card)
                    .resizable()  // Make the image resizable
                    .frame(width: 100, height: 100)  // Set the desired size
            }
        }
    }
       
}

#Preview {
    DealerCardView(vm: BlackJackStore())
}
