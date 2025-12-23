//
//  File.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import PlatformKit

struct FriendsFeatureFactory: FeatureFactory {
    let dependencies: FriendsDependencies

    func makeFeature() -> MicroFeature {
        FriendsFeatureEntry(dependencies: dependencies)
    }
}
