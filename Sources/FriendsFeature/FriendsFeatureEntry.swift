import SwiftUI
import UIKit
import PlatformKit
import DesignSystem

struct FriendsFeatureEntry: @MainActor MicroFeature {
    let id = "friends"
    let title = "Friends"
    let tabIcon: UIImage
    let selectedTabIcon: UIImage

    private let dependencies: FriendsDependencies

    init(dependencies: FriendsDependencies) {
        self.dependencies = dependencies
        self.tabIcon = UIImage(systemName: "person.3")!
        self.selectedTabIcon = UIImage(systemName: "person.3")!
    }

    @MainActor
    func makeRootView() -> AnyView {
        let viewModel = FriendsViewModel(
            api: dependencies.friendsAPI,
            analytics: dependencies.analytics
        )
        return AnyView(FriendsRootView(viewModel: viewModel))
    }
}
