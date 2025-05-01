//
//  AspectVGrid.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 5/1/25.
//

import SwiftUI

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
