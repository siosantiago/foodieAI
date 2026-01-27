import Foundation

struct IngestResponse: Codable {
    let transcriptId: String
    let transcript: String
    let videoUrl: String
}

struct RecipeResponse: Codable {
    let recipeId: String
    let transcriptId: String
    let recipe: Recipe
}

struct GroceryListResponse: Codable {
    let recipeId: String
    let items: [Ingredient]
}

struct CookSessionResponse: Codable {
    let sessionId: String
    let recipeId: String
    let userId: String?
}

struct CookAnswerResponse: Codable {
    let sessionId: String
    let answer: String
}

struct OrderResponse: Codable {
    let recipeId: String
    let provider: String
    let userLocation: String?
    let orderLink: String
    let items: [String]
}
