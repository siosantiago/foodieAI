import SwiftUI

struct RecipeView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            if let recipe = appState.recipeResponse?.recipe {
                List {
                    Section("Title") {
                        Text(recipe.title).font(.headline)
                    }
                    Section("Ingredients") {
                        ForEach(recipe.ingredients) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text(item.quantity).foregroundStyle(.secondary)
                            }
                        }
                    }
                    Section("Steps") {
                        ForEach(recipe.steps.sorted { $0.order < $1.order }) { step in
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Step \(step.order)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text(step.instruction)
                            }
                        }
                    }
                }
                .navigationTitle("Recipe")
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "book")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                    Text("No recipe yet").font(.headline)
                    Text("Generate a recipe from a video link.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
        }
    }
}
