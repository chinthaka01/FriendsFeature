//
//  FriendsFeatureAPIClient.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

public final class FriendsFeatureAPIClient: FriendsFeatureAPI {
    public init() {}

    public func fetchFeeds() async throws -> any FriendsDTO {
        return FriendsDTOImpl()
    }
}
