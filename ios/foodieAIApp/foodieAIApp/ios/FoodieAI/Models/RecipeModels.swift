import Foundation

struct Ingredient: Codable, Identifiable {
    let id = UUID()
    let name: String
    let quantity: String

    enum CodingKeys: String, CodingKey {
        case name
        case quantity
    }
}

struct RecipeStep: Codable, Identifiable {
    let id = UUID()
    let order: Int
    let instruction: String

    enum CodingKeys: String, CodingKey {
        case order
        case instruction
    }
}

struct Recipe: Codable {
    let title: String
    let servings: Int?
    let ingredients: [Ingredient]
    let steps: [RecipeStep]
    let notes: [String]?
}
