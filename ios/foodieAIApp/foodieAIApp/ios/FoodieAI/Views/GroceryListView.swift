import SwiftUI

struct GroceryListView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            if let items = appState.recipeResponse?.recipe.ingredients {
                List {
                    ForEach(items) { item in
                        VStack(alignment: .leading) {
                            Text(item.name)
                            Text(item.quantity)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .navigationTitle("Grocery List")
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "cart")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                    Text("No ingredients yet").font(.headline)
                    Text("Generate a recipe first.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
        }
    }
}
