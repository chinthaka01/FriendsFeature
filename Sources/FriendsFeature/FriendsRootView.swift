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

struct FriendsRootView: View {
    @StateObject private var viewModel: FriendsViewModel

    init(viewModel: FriendsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            FriendsScreen(viewModel: viewModel)
        }
    }
}
