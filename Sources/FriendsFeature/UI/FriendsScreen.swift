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

/// Main screen for the Friends feature.
///
/// Drives the UI based on the state in `FriendsViewModel`.
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
                FriendsListView(friends: viewModel.friends, analytics: viewModel.analytics)
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

/// List of friends rendered as cards with navigation to a detail screen.
///
/// Also fires an `itemSelected` analytics event when a friend is tapped.
struct FriendsListView: View {
    let friends: [User]
    let analytics: Analytics

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
                    .simultaneousGesture(TapGesture().onEnded {
                        analytics.track(
                            .itemSelected(id: user.id, type: .friend, pageName: .friends)
                        )
                    })
                }
            }
            .padding(.vertical, DSSpacing.sm)
        }
    }
}

/// Small card used to display a friend in the list.
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
    
    /// Standard error view with a retry button.
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
    
    /// Empty state shown when there are no friends to display.
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
