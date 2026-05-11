//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by saurabh on 09/05/26.
//

import SwiftUI
import Combine

@main
struct MatchMateApp: App {
    @StateObject private var settings = GameSettings()

    var body: some Scene {
        WindowGroup {
            MatchMateRootView()
                .environmentObject(settings)
        }
    }
}

#Preview {
    MatchMateRootView()
        .environmentObject(GameSettings())
}
