//
//  File.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

/// View model for the Friends feature.
///
/// Loads the list of users from the BFF and exposes that excluding the user with ID '1'
/// considered “friends” to the UI.
@MainActor
final class FriendsViewModel: ObservableObject {
    
    /// API used to fetch users/friends.
    let api: any FriendsFeatureAPI
    
    /// Analytics abstraction shared with other features.
    let analytics: any Analytics
    
    /// Friends shown in the UI (excludes the current user).
    @Published var friends: [User] = []
    
    /// Whether a load operation is currently in progress.
    @Published var isLoading = true
    
    /// Last error that occurred while loading friends.
    @Published var error: Error? = nil

    init(api: FriendsFeatureAPI, analytics: Analytics) {
        self.api = api
        self.analytics = analytics
    }
    
    /// Loads friends from the API.
    ///
    /// In this demo we treat the user with `id == 1` as the current profile
    /// and filter them out of the friends list.
    func loadFriends() async {
        friends = []
        error = nil
        isLoading = true

        do {
            let allUsers = try await api.fetchFriends()

            // Remove the "logged-in user" (id 1) from the friends list.
            friends = allUsers.filter { $0.id != 1 }
        } catch {
            print("Failed to load friends: \(error)")
            self.error = error
        }

        isLoading = false
    }
}
