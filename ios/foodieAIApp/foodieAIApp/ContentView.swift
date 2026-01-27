import SwiftUI

struct ContentView: View {
    @StateObject private var appState = AppState()

    var body: some View {
        TabView {
            VideoInputView()
                .tabItem { Label("Video", systemImage: "link") }
            RecipeView()
                .tabItem { Label("Recipe", systemImage: "book") }
            GroceryListView()
                .tabItem { Label("Grocery", systemImage: "cart") }
            CookAssistantView()
                .tabItem { Label("Cook", systemImage: "message") }
            OrderView()
                .tabItem { Label("Order", systemImage: "bag") }
        }
        .environmentObject(appState)
    }
}
