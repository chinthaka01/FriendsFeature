//
//  File.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import SwiftUI

struct FriendsScreen: View {
    @ObservedObject var viewModel: FriendsViewModel

    var body: some View {
        List(viewModel.friends) { friend in
            VStack(alignment: .leading) {
                Text(friend.name)
                    .font(.headline)
                Text(friend.formattedBalance)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Friends")
        .onAppear {
            viewModel.loadFriends()
        }
    }
}
