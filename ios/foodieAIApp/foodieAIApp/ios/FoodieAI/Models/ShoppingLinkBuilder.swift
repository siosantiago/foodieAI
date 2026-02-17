import Foundation

enum ShoppingLinkBuilder {
    // Encodes a query string for use in URLs
    private static func encode(_ text: String) -> String {
        text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? text
    }

    // Given a list of ingredient strings, build a set of shopping links across providers.
    // This does not call any external APIs; it constructs high-quality search URLs that open
    // the provider app/site to relevant results.
    static func buildLinks(for ingredients: [String]) -> [IngredientLink] {
        let cleaned = ingredients
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        guard !cleaned.isEmpty else { return [] }

        let query = encode(cleaned.joined(separator: ", "))

        var results: [IngredientLink] = []

        // Google Shopping
        if let url = URL(string: "https://www.google.com/search?tbm=shop&q=\(query)") {
            results.append(IngredientLink(title: "Google Shopping", url: url))
        }

        // Amazon
        if let url = URL(string: "https://www.amazon.com/s?k=\(query)") {
            results.append(IngredientLink(title: "Amazon", url: url))
        }

        // Walmart
        if let url = URL(string: "https://www.walmart.com/search?q=\(query)") {
            results.append(IngredientLink(title: "Walmart", url: url))
        }

        // Instacart (search)
        if let url = URL(string: "https://www.instacart.com/store/search?q=\(query)") {
            results.append(IngredientLink(title: "Instacart", url: url))
        }

        // Target
        if let url = URL(string: "https://www.target.com/s?searchTerm=\(query)") {
            results.append(IngredientLink(title: "Target", url: url))
        }

        // Costco (web search)
        if let url = URL(string: "https://www.costco.com/CatalogSearch?dept=All&keyword=\(query)") {
            results.append(IngredientLink(title: "Costco", url: url))
        }

        return results
    }
}
