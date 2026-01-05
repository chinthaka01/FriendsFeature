//
//  FriendsDependenciesImpl.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

/// Concrete implementation of `FriendsDependencies`
///
/// The shell app creates one of these and passes it into `FriendsFeatureFactory`.
/// So the Friends feature can access its API client and analytics without depending directly on app‑level types.
final public class FriendsDependenciesImpl: FriendsDependencies {
    public let friendsAPI: any FriendsFeatureAPI
    public let analytics: any Analytics
    
    
    public init(friendsAPI: FriendsFeatureAPI, analytics: Analytics) {
        self.friendsAPI = friendsAPI
        self.analytics = analytics
    }
}
