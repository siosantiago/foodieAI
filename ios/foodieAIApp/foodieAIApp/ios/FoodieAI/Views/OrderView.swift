import SwiftUI
import SafariServices

// SafariView provides an in-app browser experience for shopping links
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: Context) -> SFSafariViewController { SFSafariViewController(url: url) }
    func updateUIViewController(_ controller: SFSafariViewController, context: Context) {}
}

struct OrderView: View {
    @EnvironmentObject private var appState: AppState
    @State private var selectedLink: IngredientLink?

    private let columns = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]

    var body: some View {
        ThemedContainer(title: "Shop Ingredients", subtitle: "Individual items from top retailers") {
            if let ingredients = appState.recipeResponse?.recipe.ingredients, !ingredients.isEmpty {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(ingredients) { ingredient in
                            IngredientOrderCard(ingredient: ingredient) { link in
                                selectedLink = link
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
            } else {
                VStack(spacing: 24) {
                    Image(systemName: "cart.badge.plus")
                        .font(.system(size: 60))
                        .foregroundStyle(BrandColor.subtle)
                    
                    VStack(spacing: 8) {
                        Text("No Ingredients Yet")
                            .font(BrandFont.title())
                            .foregroundStyle(.white)
                        Text("Process a video to generate a recipe and see your shopping list here.")
                            .font(BrandFont.body())
                            .foregroundStyle(BrandColor.subtle)
                            .multilineTextAlignment(.center)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 80)
            }
        }
        .sheet(item: $selectedLink) { link in
            SafariView(url: link.url)
                .ignoresSafeArea()
        }
    }
}

struct IngredientOrderCard: View {
    let ingredient: Ingredient
    let onSelect: (IngredientLink) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image Section with Quantity Badge
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure(_), .empty:
                        ZStack {
                            BrandColor.card
                            Image(systemName: "leaf.fill")
                                .font(.title)
                                .foregroundStyle(BrandColor.subtle.opacity(0.3))
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 140)
                .frame(maxWidth: .infinity)
                .clipped()
                
                Text(ingredient.quantity)
                    .font(BrandFont.caption(.bold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(BrandColor.primary)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .padding(8)
            }

            // Ingredient Name and Action Menu
            VStack(alignment: .leading, spacing: 12) {
                Text(ingredient.name)
                    .font(BrandFont.headline())
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(height: 44, alignment: .topLeading)

                Menu {
                    let links = ShoppingLinkBuilder.buildLinks(for: [ingredient.name])
                    ForEach(links) { link in
                        Button {
                            onSelect(link)
                        } label: {
                            Label(link.title, systemImage: "cart")
                        }
                    }
                } label: {
                    HStack {
                        Text("Buy Now")
                            .font(BrandFont.caption(.bold))
                        Spacer()
                        Image(systemName: "chevron.up")
                            .font(.system(size: 10, weight: .bold))
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                    .background(BrandColor.primary.opacity(0.1))
                    .foregroundStyle(BrandColor.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(12)
        }
        .background(BrandColor.card)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(BrandColor.separator, lineWidth: 1)
        )
    }

    private var imageURL: URL? {
        let query = ingredient.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        // Using Unsplash as a placeholder service for ingredient images based on the name
        return URL(string: "https://source.unsplash.com/featured/400x400?\(query),food,fresh")
    }
}
