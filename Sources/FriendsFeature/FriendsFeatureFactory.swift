//
//  File.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

public struct FriendsFeatureFactory: @MainActor FeatureFactory {
    public let dependencies: FriendsDependencies
    
    public init(dependencies: FriendsDependencies) {
        self.dependencies = dependencies
    }

    @MainActor
    public func makeFeature() -> MicroFeature {
        FriendsFeatureEntry(dependencies: dependencies)
    }
}
