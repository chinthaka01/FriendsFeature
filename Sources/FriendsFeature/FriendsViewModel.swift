//
//  File.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

@MainActor
final class FriendsViewModel: ObservableObject {
    let api: any FriendsFeatureAPI
    let analytics: any Analytics
    
    @Published var friends: [User]?

    init(api: FriendsFeatureAPI, analytics: Analytics) {
        self.api = api
        self.analytics = analytics
    }
    
    func loadFriends() async {
        do {
            let allUsers = try await api.fetchFriends()
            
            guard let allUsers = allUsers, allUsers.isEmpty else {
                return
            }

            // We are considering the user with the id 1 as the profile.
            friends = allUsers.filter { $0.id != 1 }
        } catch {
            print("Failed to load friends: \(error)")
        }
    }
}
