//
//  File.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

/// Factory that creates the Friends micro feature.
///
/// The shell app owns an instance of this type and calls `makeFeature()`
/// to obtain the tab descriptor and root view for the Friends module.
public struct FriendsFeatureFactory: @MainActor FeatureFactory {
    public let dependencies: FriendsDependencies
    
    /// Stores the dependencies that will be injected into the feature entry.
    public init(dependencies: FriendsDependencies) {
        self.dependencies = dependencies
    }

    @MainActor
    public func makeFeature() -> MicroFeature {
        FriendsFeatureEntry(dependencies: dependencies)
    }
}
