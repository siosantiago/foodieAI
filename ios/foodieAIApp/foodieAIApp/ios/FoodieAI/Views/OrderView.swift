import SwiftUI

struct OrderView: View {
    @EnvironmentObject private var appState: AppState
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if let link = appState.orderLink {
                    Text("Order link ready:")
                    Text(link)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Button(isLoading ? "Creating..." : "Create Uber Eats Order") {
                    Task { await createOrder() }
                }
                .disabled(isLoading)

                if let errorMessage {
                    Text(errorMessage).foregroundStyle(.red)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Order")
        }
    }

    @MainActor
    private func createOrder() async {
        guard let recipeId = appState.recipeResponse?.recipeId else {
            errorMessage = "Generate a recipe first."
            return
        }
        errorMessage = nil
        isLoading = true
        do {
            let order = try await APIClient.shared.createOrder(recipeId: recipeId)
            appState.orderLink = order.orderLink
        } catch {
            errorMessage = "Failed to create order link."
        }
        isLoading = false
    }
}
