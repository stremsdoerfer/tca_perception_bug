import ComposableArchitecture
import SwiftUI

struct ContentView: View {
  @Perception.Bindable var store: StoreOf<ContentReducer>

  var body: some View {
    WithPerceptionTracking {
      TabView(selection: $store.selectedTab.sending(\.updateTab)){
        Text("Tab Content 1").tabItem { Text("Tab Label 1") }.tag(1)
        Text("Tab Content 2").tabItem { Text("Tab Label 2") }.tag(2)
      }

//      TextField(text: $store.text.sending(\.updateText)) {
//        Text("heyo")
//      }

//      Picker("Title", selection: $store.selectedTab.sending(\.updateTab)) {
//        Text("home").tag(ContentReducer.Tab.home)
//      }
//      .pickerStyle(.wheel)
      .overlay {
        GeometryReader { proxy in
          Color.clear
            .preference(key: SizePreferenceKey.self, value: proxy.size)
        }
      }
      .onPreferenceChange(SizePreferenceKey.self) { _ in }
    }
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

@Reducer
struct ContentReducer {

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .updateTab(tab):
        state.selectedTab = tab
        return .none
      case let .updateText(text):
        state.text = text
        return .none
      case let .updatePresented(newVal):
        state.isPresented = newVal
        return .none
      }
    }
  }

  @ObservableState
  struct State {
    var selectedTab = Tab.home
    var text = "hey"
    var isPresented = false
  }

  @CasePathable
  enum Action {
    case updateTab(Tab)
    case updateText(String)
    case updatePresented(Bool)
  }

  enum Tab {
    case home
    case messages
    case settings
  }
}
