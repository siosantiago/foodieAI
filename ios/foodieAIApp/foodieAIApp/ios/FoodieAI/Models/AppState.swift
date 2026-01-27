import Foundation
import Combine

@MainActor
final class AppState: ObservableObject {
    @Published var videoUrl: String = ""
    @Published var recipeResponse: RecipeResponse?
    @Published var cookSessionId: String?
    @Published var lastAnswer: String?
    @Published var orderLink: String?
}
