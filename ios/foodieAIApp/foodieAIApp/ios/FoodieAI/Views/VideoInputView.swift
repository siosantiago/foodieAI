import SwiftUI

struct VideoInputView: View {
    @EnvironmentObject private var appState: AppState
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            Form {
                Section("Video Link") {
                    TextField("Paste a video URL", text: $appState.videoUrl)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.URL)
                }

                Section {
                    Button(isLoading ? "Processing..." : "Generate Recipe") {
                        Task { await generateRecipe() }
                    }
                    .disabled(appState.videoUrl.isEmpty || isLoading)
                }

                if let errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }

                if let recipe = appState.recipeResponse?.recipe {
                    Section("Latest Recipe") {
                        Text(recipe.title).font(.headline)
                        Text("\(recipe.ingredients.count) ingredients")
                        Text("\(recipe.steps.count) steps")
                    }
                }
            }
            .navigationTitle("FoodieAI")
        }
    }

    @MainActor
    private func generateRecipe() async {
        errorMessage = nil
        isLoading = true
        do {
            let response = try await APIClient.shared.createRecipe(videoUrl: appState.videoUrl)
            appState.recipeResponse = response
        } catch {
            errorMessage = "Failed to generate recipe. Check backend connection."
        }
        isLoading = false
    }
}
