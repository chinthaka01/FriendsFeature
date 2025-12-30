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
            friends = try await api.fetchFriends()
        } catch {
            print("Failed to load friends: \(error)")
        }
    }
}
