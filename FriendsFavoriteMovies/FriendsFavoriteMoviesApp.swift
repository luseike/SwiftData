//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by 远路蒋 on 2024/10/19.
//

import SwiftUI
import SwiftData

@main
struct FriendsFavoriteMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Movie.self, Friend.self])
    }
}
