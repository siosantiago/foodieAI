import Foundation

final class APIClient {
    static let shared = APIClient()

    private let baseURL = URL(string: "http://localhost:4000/api")!

    func ingest(videoUrl: String) async throws -> IngestResponse {
        try await request(path: "ingest", body: ["videoUrl": videoUrl])
    }

    func createRecipe(transcriptId: String? = nil, videoUrl: String? = nil) async throws -> RecipeResponse {
        var payload: [String: String] = [:]
        if let transcriptId { payload["transcriptId"] = transcriptId }
        if let videoUrl { payload["videoUrl"] = videoUrl }
        return try await request(path: "recipes", body: payload)
    }

    func groceryList(recipeId: String) async throws -> GroceryListResponse {
        let url = baseURL.appendingPathComponent("recipes/grocery-list/\(recipeId)")
        return try await get(url: url)
    }

    func startCookSession(recipeId: String, userId: String? = nil) async throws -> CookSessionResponse {
        var payload: [String: String] = ["recipeId": recipeId]
        if let userId { payload["userId"] = userId }
        return try await request(path: "cook/session", body: payload)
    }

    func askCookQuestion(sessionId: String, question: String) async throws -> CookAnswerResponse {
        return try await request(path: "cook/qna", body: ["sessionId": sessionId, "question": question])
    }

    func createOrder(recipeId: String, userLocation: String? = nil) async throws -> OrderResponse {
        var payload: [String: String] = ["recipeId": recipeId]
        if let userLocation { payload["userLocation"] = userLocation }
        return try await request(path: "order/ubereats", body: payload)
    }

    private func request<T: Decodable>(path: String, body: [String: String]) async throws -> T {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        return try await decode(request: request)
    }

    private func get<T: Decodable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return try await decode(request: request)
    }

    private func decode<T: Decodable>(request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
