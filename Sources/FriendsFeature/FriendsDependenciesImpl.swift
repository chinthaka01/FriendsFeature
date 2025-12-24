//
//  FriendsDependenciesImpl.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

final public class FriendsDependenciesImpl: FriendsDependencies {
    public let friendsAPI: any FriendsFeatureAPI
    public let analytics: any Analytics
    
    
    public init(friendsAPI: FriendsFeatureAPI, analytics: Analytics) {
        self.friendsAPI = friendsAPI
        self.analytics = analytics
    }
}
