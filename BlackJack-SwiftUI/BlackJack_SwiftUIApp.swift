//
//  BlackJack_SwiftUIApp.swift
//  BlackJack-SwiftUI
//
//  Created by Zheen Suseyi on 4/25/25.
//

import SwiftUI

@main
struct BlackJack_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            GameView(vm: BlackJackStore())
        }
    }
}
