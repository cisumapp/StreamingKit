//
//  Users Search.swift
//  cisum
//
//  Created by Aarav Gupta on 05/05/24.
//

import SwiftUI

struct UserSearch: View {
    @State private var searchUser = ""
    let AccentColor = Color(red: 0.9764705882352941, green: 0.17647058823529413, blue: 0.2823529411764706)
    @StateObject var userSearchViewModel = UserSearchViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(userSearchViewModel.users) { user in
                        NavigationLink(value: user) {
                            VStack {
                                UserCell(user: user)

                                Divider()
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationDestination(for: User.self, destination: { user in
                Profile(user: user)
            })
            .searchable(text: $searchUser, prompt: "Search Users")
        }
    }
}

#Preview {
    UserSearch()
}
