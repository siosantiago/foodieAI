import Foundation
import Combine

struct IngredientLink: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let url: URL
}

@MainActor
final class AppState: ObservableObject {
    @Published var videoUrl: String = ""
    @Published var recipeResponse: RecipeResponse?
    @Published var cookSessionId: String?
    @Published var lastAnswer: String?
    @Published var orderLink: String?

    // MARK: - Ingredient Links
    @Published var ingredientLinks: [IngredientLink] = []
    @Published var isBuildingIngredientLinks: Bool = false

    func buildIngredientLinks(from ingredients: [String]) async {
        isBuildingIngredientLinks = true
        defer { isBuildingIngredientLinks = false }
        let links = ShoppingLinkBuilder.buildLinks(for: ingredients)
        ingredientLinks = links
    }
}
