//
//  ContentView.swift
//  Birthdays
//
//  Created by 远路蒋 on 2024/10/19.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Friend.name) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    var body: some View {
        TabView {
            FriendList().tabItem {
                Label("Friends", systemImage: "person.and.person")
            }
            
            FilteredMovieList().tabItem {
                Label("Movies", systemImage: "film.stack")
            }
        }
        
    }
    
    
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
