//
//  FriendsFeatureAPIClient.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

public final class FriendsFeatureAPIClient: FriendsFeatureAPI {
    public let networking: Networking
    private let bffPath = "users"

    public init(networking: Networking) {
        self.networking = networking
    }

    public func fetchFriends() async throws -> [User] {
        let users = try await networking.fetchList(
            bffPath: bffPath,
            type: User.self
        )
        
        return users
    }
}
