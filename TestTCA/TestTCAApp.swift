import ComposableArchitecture
import SwiftUI

@main
struct TestTCAApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(store: Store(initialState: ContentReducer.State(), reducer: ContentReducer.init))
    }
  }
}
