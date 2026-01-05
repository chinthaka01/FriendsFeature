# FriendsFeature

`FriendsFeature` is a self‑contained micro frontend that implements the **Friends** tab of the Wefriends MFE demo iOS app. It is delivered as a Swift Package and talks to shared infrastructure only through protocols from `PlatformKit` and UI components from `DesignSystem`.

***

## What this feature demonstrates

- Using a **micro‑frontend entry type** (`FriendsFeatureEntry`) and a **factory** (`FriendsFeatureFactory`) to plug a feature into the host app without tight coupling.[29]
- Loading friend data from a **BFF endpoint** via a feature‑specific API protocol (`FriendsFeatureAPI`).
- A simple **view‑model‑driven SwiftUI screen** with loading, error, empty, and content states.[30]
- **Analytics integration** using a shared `Analytics` abstraction, including an `itemSelected` event when a friend is tapped.
- Clean **dependency injection** through a `FriendsDependencies` protocol and `FriendsDependenciesImpl` container.

***

## Public entry points

These are the only types the shell app needs to know about:

- `FriendsFeatureFactory`
  - Conforms to `FeatureFactory`.
  - Created by the shell with a `FriendsDependencies` instance.
  - `makeFeature()` returns a `MicroFeature` describing the Friends tab.

- `FriendsFeatureEntry`
  - Conforms to `MicroFeature`.
  - Provides:
    - `id = "friends"`
    - `title = "Friends"`
    - Tab icons: SF Symbol `person.3`.
  - Builds `FriendsRootView` using an injected `FriendsViewModel`.

***

## Dependencies

### Protocols from PlatformKit

- `FriendsFeatureAPI`
  - `fetchFriends() async throws -> [User]`
- `FriendsDependencies`
  - `friendsAPI: FriendsFeatureAPI`
  - `analytics: Analytics`
- `Analytics`
  - `track(_ event: AnalyticsEvent)`

### Implementations in this package

- `FriendsFeatureAPIClient`
  - Uses the shared `Networking` abstraction to call the BFF at `users`.
  - `fetchFriends()` returns `[User]` representing all users from the backend.

- `FriendsDependenciesImpl`
  - Simple container that wires:
    - `friendsAPI: FriendsFeatureAPI`
    - `analytics: Analytics`
  - Created by the shell and passed into `FriendsFeatureFactory`.

***

## View model

- `FriendsViewModel` (marked `@MainActor`)
  - Inputs:
    - `api: FriendsFeatureAPI`
    - `analytics: Analytics`
  - State:
    - `@Published var friends: [User]`
    - `@Published var isLoading: Bool`
    - `@Published var error: Error?`
  - Logic:
    - `loadFriends()`
      - Calls `api.fetchFriends()`.
      - For the demo, treats user with `id == 1` as the current profile and **filters them out** so only friends remain.
      - Updates `friends`, `isLoading`, and `error` accordingly.

This separation keeps networking and UI decoupled and makes the feature easy to test.

***

## UI structure

- `FriendsRootView`  
  - Holds `FriendsViewModel` via `@StateObject`.  
  - Sets up a `NavigationStack` and hosts `FriendsScreen`.[28]

- `FriendsScreen`  
  - Renders one of four states: loading, error, empty, or content (friends list).  
  - Triggers `loadFriends()` on first appear and on pull‑to‑refresh.[29]

- `FriendsListView`  
  - Displays a scrollable list of friends using `FriendCard`.  
  - Wraps each card in a navigation link to `FriendDetailScreen` and fires an `itemSelected` analytics event when tapped.[30]

- `FriendCard`  
  - Shows a friend’s avatar, name, and website using `DesignSystem` components.

- `FriendDetailScreen`  
  - Detail view presented when a friend is selected from the list.  
  - Shows:
    - Header with avatar, website, and `@username`.  
    - “Address” section with street, suite, city, and zip code.  
    - “Company” section with company name, catch phrase, and business summary.  
  - Uses `DSSection`, typography, and colors from the design system so the detail view feels consistent with the rest of the app.[30]

The UI is built entirely with `DesignSystem` tokens so it matches other features visually.

***

## How the shell app wires FriendsFeature

Example usage from the host app:

```swift
// Shared services
let analytics: Analytics = AnalyticsImpl()
let networking: Networking = NetworkingImpl()

// Friends feature wiring
let friendsAPI: FriendsFeatureAPI = FriendsFeatureAPIClient(networking: networking)
let friendsDeps = FriendsDependenciesImpl(friendsAPI: friendsAPI, analytics: analytics)
let friendsFactory = FriendsFeatureFactory(dependencies: friendsDeps)

// Build the MicroFeature for the tab bar
let friendsFeature = friendsFactory.makeFeature()

TabView {
    friendsFeature
        .makeRootView()
        .tabItem {
            Image(uiImage: friendsFeature.tabIcon)
            Text(friendsFeature.title)
        }

    // ... other features
}
```

With this setup, the Friends feature remains fully modular and replaceable: only its factory and dependency protocol surface to the shell, while all implementation details stay inside the `FriendsFeature` package.
