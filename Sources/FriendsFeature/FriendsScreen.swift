//
//  File.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import SwiftUI
import PlatformKit
import DesignSystem

struct FriendsScreen: View {
    @ObservedObject var viewModel: FriendsViewModel

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading friends…")
            } else if let error = viewModel.error {
                errorView(error)
            } else if viewModel.friends.isEmpty {
                emptyView()
            } else {
                FriendsListView(friends: viewModel.friends)
            }
        }
        .navigationTitle("Friends")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.default, value: viewModel.friends)
        .task {
            await viewModel.loadFriends()
        }
        .refreshable {
            await viewModel.loadFriends()
        }
    }
}

struct FriendsListView: View {
    let friends: [User]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: DSSpacing.sm) {
                ForEach(friends) { user in
                    NavigationLink {
                        FriendDetailScreen(user: user)
                    } label: {
                        FriendCard(user: user)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, DSSpacing.sm)
        }
    }
}

struct FriendCard: View {
    let user: User

    var body: some View {
        DSCard {
            HStack(spacing: DSSpacing.md) {

                DSAvatar(name: user.name)

                VStack(alignment: .leading, spacing: DSSpacing.xs) {
                    Text(user.name)
                        .font(DSTextStyle.headline)

                    Text(user.website)
                        .font(DSTextStyle.caption)
                        .foregroundColor(DSColor.secondaryText)
                }

                Spacer()
            }
        }
        .padding(.horizontal, DSSpacing.md)
    }
}

private extension FriendsScreen {
    func errorView(_ error: Error) -> some View {
        ContentUnavailableView {
            Label("Unable to Load Friends", systemImage: "exclamationmark.triangle.fill")
        } description: {
            Text(viewModel.error?.localizedDescription ?? "")
                .font(DSTextStyle.body)
        } actions: {
            DSButton(title: "Retry", icon: "arrow.counterclockwise") {
                Task {
                    await viewModel.loadFriends()
                }
            }
        }
    }
}

private extension FriendsScreen {
    func emptyView() -> some View {
        ContentUnavailableView {
            Label("No Friends", systemImage: "person.2.slash")
        } description: {
            Text("You don’t have any friends yet.")
                .font(DSTextStyle.body)
        } actions: {
            DSButton(title: "Retry", icon: "arrow.counterclockwise") {
                Task {
                    await viewModel.loadFriends()
                }
            }
        }
    }
}
