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
    private let viewModel: FriendsViewModel

    @MainActor
    init(dependencies: FriendsDependencies) {
        self.dependencies = dependencies
        self.tabIcon = UIImage(systemName: "person.3")!
        self.selectedTabIcon = UIImage(systemName: "person.3")!
        
        self.viewModel = FriendsViewModel(
            api: dependencies.friendsAPI,
            analytics: dependencies.analytics
        )
    }

    @MainActor
    func makeRootView() -> AnyView {
        return AnyView(FriendsRootView(viewModel: viewModel))
    }
}
