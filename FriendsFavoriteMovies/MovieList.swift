//
//  MovieList.swift
//  Birthdays
//
//  Created by 远路蒋 on 2024/10/21.
//

import SwiftUI
import SwiftData

struct MovieList: View {
    @Query private var movies: [Movie]
    @Environment(\.modelContext) private var context
    @State private var newMovie: Movie?
    
    /// You can use a custom view initializer when you need extra control over how special properties, such as queries, are set up when the view is created
    init(titleFilter: String = "") {
        let predicate = #Predicate<Movie>{ movie in
            titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)
        }
        _movies = Query(filter: predicate, sort: \Movie.title)
    }
    
    var body: some View {
//        NavigationSplitView {
            List {
                ForEach(movies) { movie in
                    NavigationLink(movie.title) {
                        MovieDetail(movie: movie, isNew: false)
                    }
                    
                }
                .onDelete(perform: { indexSet in
                    deleteMovies(indexs: indexSet)
                })
            }
            .navigationTitle("Movies")
            .toolbar(content: {
                ToolbarItem {
                    Button("Add movie", systemImage: "plus", action: addMovie)
                }
                ToolbarItem(placement: .topBarTrailing, content: {
                    EditButton()
                })
            })
            .sheet(item: $newMovie) { movie in
                NavigationStack {
                    MovieDetail(movie: movie, isNew: true)
                }
                .interactiveDismissDisabled()
            }
//        } detail: {
//            Text("Select a movie")
//                .navigationTitle("Movie")
//                .navigationBarTitleDisplayMode(.inline)
//        }

        
    }
    
    private func addMovie() {
        let newMovie = Movie(title: "", releaseDate: .now)
        context.insert(newMovie)
        self.newMovie = newMovie
    }
    
    private func deleteMovies(indexs: IndexSet) {
        for index in indexs {
            context.delete(movies[index])
        }
    }
}

#Preview {
    NavigationStack{
        MovieList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Filtered", body: {
    NavigationStack{
        MovieList(titleFilter: "g")
            .modelContainer(SampleData.shared.modelContainer)
    }
})
