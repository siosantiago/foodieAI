import SwiftUI

struct BuyIngredientsCTA: View {
    @EnvironmentObject var appState: AppState
    var ingredients: [String]

    @State private var isNavigating = false

    var body: some View {
        VStack(spacing: 12) {
            Button(action: buildLinks) {
                HStack {
                    Image(systemName: "cart.fill")
                    Text("Buy Ingredients")
                }
                .font(BrandFont.headline(.semibold))
            }
            .primaryButtonStyle()
            .disabled(ingredients.isEmpty)

            NavigationLink("", isActive: $isNavigating) {
                IngredientLinksView()
                    .environmentObject(appState)
            }
            .hidden()
        }
    }

    private func buildLinks() {
        Task { @MainActor in
            await appState.buildIngredientLinks(from: ingredients)
            isNavigating = true
        }
    }
}

#Preview {
    let state = AppState()
    return NavigationStack {
        ThemedContainer(title: "Preview", subtitle: "CTA") {
            BuyIngredientsCTA(ingredients: ["tomatoes", "basil", "mozzarella"])
                .environmentObject(state)
        }
        .tint(BrandColor.primary)
    }
}
