//
//  FriendList.swift
//  Birthdays
//
//  Created by 远路蒋 on 2024/10/21.
//

import SwiftUI
import SwiftData

struct FriendList: View {
    @Query(sort: \Friend.name) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    @State private var newFriend: Friend?
    
    var body: some View {
        NavigationSplitView {
            Group {
                if !friends.isEmpty {
                    List {
                        ForEach(friends) { friend in
                            NavigationLink(friend.name) {
                                FriendDetail(friend: friend, isNew: false)
                            }
                        }//.onDelete(perform: { indexSet in
                        // deleteFriends(indexes: indexSet)
                        //})
                        .onDelete(perform: deleteFriends(indexes:))
                        // .onDelete modifier to add a delete action to the ForEach view inside the list
                    }
                } else {
                    ContentUnavailableView("Add Friend", systemImage: "person.crop.circle.badge.plus")
                }
            }
            .navigationTitle("Friends")
            .toolbar(content: {
                ToolbarItem {
                    Button("Add friend", systemImage: "plus", action: addFriend)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            })
            // display a sheet for the new friend(when newFrient property set vlaue). Inside the closure, use the friend parameter to display the detail view
            // You can trigger a sheet to appear when an optional property has a value. To dismiss the sheet, set the value to nil.
            .sheet(item: $newFriend) { friend in
                
                NavigationStack {
                    FriendDetail(friend: friend, isNew: true)
                }
                .interactiveDismissDisabled()
            }
        } detail: {
            Text("Select a friend")
                .navigationTitle("Friend")
                .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
    
    private func addFriend() {
        let newFriend = Friend(name: "")
        context.insert(newFriend)
        self.newFriend = newFriend
    }
    
    private func deleteFriends(indexes: IndexSet) {
        for index in indexes {
            context.delete(friends[index])
        }
    }
}

#Preview {
    FriendList()
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("empty list", body: {
    FriendList()
        .modelContainer(for: Friend.self, inMemory: true)
})
