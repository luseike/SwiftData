//
//  FriendDetail.swift
//  Birthdays
//
//  Created by 远路蒋 on 2024/10/21.
//

import SwiftUI
import SwiftData

struct FriendDetail: View {
    /**
     @Bindable property lets you pass a binding to it
     all model class in swiftData are observable
     */
    @Bindable var friend: Friend
    let isNew: Bool
    
    // the dismiss environment value is a function, when you call it, swiftUI will dismiss the current modal presentation
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Movie.title) private var movies: [Movie]
    
    init(friend: Friend, isNew: Bool = false) {
        self.friend = friend
        self.isNew = isNew
    }
    
    var body: some View {
        
        // you can use the Form container view to present data for display and editing
        Form {
            TextField("Name", text: $friend.name)
                .autocorrectionDisabled()
            
            Picker("Favorite Movie", selection: $friend.favoriteMovie) {
                //                            Text("None")
                //                                .tag(nil as Movie?)
                // "None" 的item匹配到 nil as Movie? 无法正常工作，需要显示的使用 Optional<Movie>.none，下面ForEach中的tag也需要 Optional(movie)
                Text("None")
                    .tag(Optional<Movie>.none)
                
                
                ForEach(movies) { movie in
                    Text(movie.title)
                        .tag(Optional(movie))
                }
            }
        }
        // detial view should customize its own navigation bar
        .navigationTitle(isNew ? "New Friend" : "Friend")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem (placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel")  {
                        // present this view in a sheet to create a friend, the ContentView has already inserted one into the context, to cancel, you'll need to remove it
                        context.delete(friend)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    // to view the navigation bar, wrap the view in the preview in a Navigation Stack
    NavigationStack {
        FriendDetail(friend: SampleData.shared.friend)
    }
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("New Friend") {
    NavigationStack {
        FriendDetail(friend: SampleData.shared.friend, isNew: true)
    }
    .modelContainer(SampleData.shared.modelContainer)
}
