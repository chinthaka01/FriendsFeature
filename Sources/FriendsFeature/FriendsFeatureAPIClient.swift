//
//  FriendsFeatureAPIClient.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

public final class FriendsFeatureAPIClient: FriendsFeatureAPI {
    
    private let bffBase = "https://jsonplaceholder.typicode.com"
    
    public let networking: Networking

    public init(networking: Networking) {
        self.networking = networking
    }

    public func fetchFriends() async throws -> [User]? {
        let url = "\(bffBase)/users"

        let users = try await networking.fetchList(
            url: url,
            type: User.self
        )
        
        return users
    }
}
