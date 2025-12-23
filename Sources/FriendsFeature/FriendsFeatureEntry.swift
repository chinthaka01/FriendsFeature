import SwiftUI
import UIKit
import PlatformKit
import DesignSystem

public struct FriendsFeatureEntry: MicroFeature {
    public let id = "friends"
    public let title = "Friends"
    public let tabIcon: UIImage

    private let dependencies: FriendsDependencies

    public init(
        dependencies: FriendsDependencies,
        tabIcon: UIImage = UIImage(systemName: "banknote")!
    ) {
        self.dependencies = dependencies
        self.tabIcon = tabIcon
    }

    public func makeRootView() -> AnyView {
        let viewModel = FriendsViewModel(
            api: dependencies.friendsAPI,
            analytics: dependencies.analytics
        )
        return AnyView(FriendsRootView(viewModel: viewModel))
    }
}
