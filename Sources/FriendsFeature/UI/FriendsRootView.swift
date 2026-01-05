//
//  File.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/23/25.
//

import Foundation
import SwiftUI
import PlatformKit
import DesignSystem

/// Root container for the Friends feature.
///
/// Sets up the navigation stack for all Friends screens.
struct FriendsRootView: View {
    @StateObject private var viewModel: FriendsViewModel

    /// Injects an existing view model created by `FriendsFeatureEntry`.
    init(viewModel: FriendsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            FriendsScreen(viewModel: viewModel)
        }
    }
}
