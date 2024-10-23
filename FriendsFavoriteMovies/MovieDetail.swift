//
//  MovieDetail.swift
//  Birthdays
//
//  Created by 远路蒋 on 2024/10/21.
//

import SwiftUI

struct MovieDetail: View {
    @Bindable var movie: Movie
    
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    init(movie: Movie, isNew: Bool) {
        self.movie = movie
        self.isNew = isNew
    }
    
    var sortedFriends: [Friend] {
        movie.favoritedBy.sorted { first, second in
            first.name < second.name
        }
    }
    
    var body: some View {
        Form {
            TextField("Movie title", text: $movie.title)
            DatePicker("Please date", selection: $movie.releaseDate)
            
            if !movie.favoritedBy.isEmpty {
                Section("Favorited by") {
                    ForEach(movie.favoritedBy) { friend in
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationTitle(isNew ? "New Movie" : "Moive")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction ) {
                    Button("Cancel") {
                        context.delete(movie)
                        dismiss()
                    }
                }
            }
        })
    }
}

#Preview {
    NavigationStack {
        MovieDetail(movie: SampleData.shared.movie, isNew: true)
    }
}
