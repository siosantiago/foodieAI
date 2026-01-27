import SwiftUI

struct CookAssistantView: View {
    @EnvironmentObject private var appState: AppState
    @State private var question: String = ""
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if let answer = appState.lastAnswer {
                    Text(answer)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                TextField("Ask a cooking question", text: $question)
                    .textFieldStyle(.roundedBorder)

                Button(isLoading ? "Asking..." : "Ask") {
                    Task { await askQuestion() }
                }
                .disabled(question.isEmpty || isLoading)

                if let errorMessage {
                    Text(errorMessage).foregroundStyle(.red)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Cook Assistant")
        }
    }

    @MainActor
    private func askQuestion() async {
        guard let recipeId = appState.recipeResponse?.recipeId else {
            errorMessage = "Generate a recipe first."
            return
        }
        errorMessage = nil
        isLoading = true
        do {
            if appState.cookSessionId == nil {
                let session = try await APIClient.shared.startCookSession(recipeId: recipeId)
                appState.cookSessionId = session.sessionId
            }
            let answer = try await APIClient.shared.askCookQuestion(sessionId: appState.cookSessionId ?? "", question: question)
            appState.lastAnswer = answer.answer
            question = ""
        } catch {
            errorMessage = "Could not get an answer."
        }
        isLoading = false
    }
}
