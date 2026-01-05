//
//  FriendDetailScreen.swift
//  FriendsFeature
//
//  Created by Chinthaka Perera on 12/30/25.
//

import Foundation
import SwiftUI
import PlatformKit
import DesignSystem

/// Detail screen shown when a friend is selected from the list.
///
/// Displays basic profile information along with address and company details.
struct FriendDetailScreen: View {
    let user: User

    var body: some View {
        ScrollView {
            VStack(spacing: DSSpacing.lg) {

                header

                DSSection(title: "Address") {
                    VStack(alignment: .leading, spacing: DSSpacing.xs) {
                        Text("\(user.address.street), \(user.address.suite)")
                        Text("\(user.address.city), \(user.address.zipcode)")
                            .foregroundColor(DSColor.secondaryText)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                DSSection(title: "Company") {
                    VStack(alignment: .leading, spacing: DSSpacing.xs) {
                        Text(user.company.name)
                            .font(DSTextStyle.headline)

                        Text(user.company.catchPhrase)
                            .italic()
                            .foregroundColor(DSColor.secondaryText)

                        Text(user.company.bs)
                            .font(DSTextStyle.caption)
                            .foregroundColor(DSColor.secondaryText)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.bottom, DSSpacing.lg)
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension FriendDetailScreen {

    var header: some View {
        VStack(spacing: DSSpacing.sm) {

            DSAvatar(name: user.name, size: 96, font: DSTextStyle.largeAvatar)

            Text(user.website)
                .font(DSTextStyle.title)
                .foregroundColor(DSColor.secondaryText)

            Text("@\(user.username)")
                .font(DSTextStyle.caption)
                .foregroundColor(DSColor.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, DSSpacing.lg)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(DSColor.card))
        )
    }
}
