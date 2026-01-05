//
//  FriendsFeatureAPIClient.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

/// Concrete implementation of `FriendsFeatureAPI` used by the Friends feature.
///
/// Talks to the BFF.
public final class FriendsFeatureAPIClient: FriendsFeatureAPI {
    
    // Shared networking abstraction injected from the shell app.
    public let networking: Networking
    
    /// Base BFF path for users‑related endpoints.
    private let bffPath = "users"

    public init(networking: Networking) {
        self.networking = networking
    }

    /// Fetches all friends from the BFF.
    public func fetchFriends() async throws -> [User] {
        let users = try await networking.fetchList(
            bffPath: bffPath,
            type: User.self
        )
        
        return users
    }
}
