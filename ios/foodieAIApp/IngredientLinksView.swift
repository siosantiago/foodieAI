import SwiftUI

struct IngredientLinksView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedLink: IngredientLink?

    var body: some View {
        ThemedContainer(title: "Buy Ingredients", subtitle: "Curated links from top retailers") {
            if appState.isBuildingIngredientLinks {
                VStack(spacing: 12) {
                    ProgressView()
                    Text("Finding the best links…")
                        .font(BrandFont.body())
                        .foregroundStyle(BrandColor.subtle)
                }
                .frame(maxWidth: .infinity)
            } else if appState.ingredientLinks.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "cart")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(BrandColor.subtle)
                    Text("No links yet")
                        .font(BrandFont.headline())
                        .foregroundStyle(.white)
                    Text("Generate a recipe or select ingredients to see where to buy them.")
                        .font(BrandFont.body())
                        .foregroundStyle(BrandColor.subtle)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(appState.ingredientLinks) { link in
                            Button {
                                selectedLink = link
                            } label: {
                                HStack(spacing: 12) {
                                    Image(systemName: "arrow.up.right.square")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(BrandColor.primary)
                                    Text(link.title)
                                        .font(BrandFont.headline())
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                            }
                            .padding(14)
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(BrandColor.card)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                                            .stroke(BrandColor.separator, lineWidth: 1)
                                    )
                            )
                        }
                    }
                    .padding(.vertical, 8)
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
            }
        }
        .sheet(item: $selectedLink) { link in
            SafariView(url: link.url)
                .ignoresSafeArea()
        }
        .tint(BrandColor.primary)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    let state = AppState()
    state.ingredientLinks = [
        IngredientLink(title: "Google Shopping", url: URL(string: "https://google.com")!),
        IngredientLink(title: "Amazon", url: URL(string: "https://amazon.com")!)
    ]
    return NavigationStack { IngredientLinksView().environmentObject(state) }
}
