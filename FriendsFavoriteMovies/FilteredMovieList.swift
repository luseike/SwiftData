//
//  FilteredMovieList.swift
//  FriendsFavoriteMovies
//
//  Created by 远路蒋 on 2024/10/22.
//

import SwiftUI

struct FilteredMovieList: View {
    
    /// state property to contain the search text, then pass it into the MovieList initializer in the view's body
    @State private var searchText = ""
    
    var body: some View {
        NavigationSplitView {
            MovieList(titleFilter: searchText)
            // .searchable 修饰器，添加搜索功能
                .searchable(text: $searchText)
        } detail: {
            Text("Select a movie")
                .navigationTitle("Movie")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilteredMovieList()
        .modelContainer(SampleData.shared.modelContainer)
}
