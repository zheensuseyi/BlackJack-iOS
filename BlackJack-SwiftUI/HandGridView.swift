//
//  HandGridView.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 5/4/25.
//

import SwiftUI
struct HandGridView: View {
    let items: [String]
    var rows: [GridItem] {
        let rowCount = max(1, Int(sqrt(Double(items.count)).rounded()))
        return Array(repeating: GridItem(.flexible()), count: rowCount)
    }
    var body: some View {
        LazyHGrid(rows: rows, spacing: 10) {
            ForEach(items, id: \.self) { item in
                withAnimation {
                    Image(item)
                        .imageSizeAdjust(width: 100, height: 100)
                }
            }
            
        }
        .padding()
    }
}

