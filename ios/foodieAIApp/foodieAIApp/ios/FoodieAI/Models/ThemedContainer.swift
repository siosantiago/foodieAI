import SwiftUI

struct ThemedContainer<Content: View>: View {
    var title: String
    var subtitle: String?
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(spacing: 20) {
            // Top bar
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(BrandFont.title())
                        .foregroundStyle(.white)
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(BrandFont.body())
                            .foregroundStyle(BrandColor.subtle)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)

            // Content
            VStack(spacing: 16) {
                content()
            }
            .padding()
            .cardStyle()
            .padding(.horizontal)

            Spacer(minLength: 0)
        }
        .appBackground()
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(BrandColor.background, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        ThemedContainer(title: "Discover", subtitle: "Let’s cook something great") {
            VStack(alignment: .leading, spacing: 12) {
                Text("Example content")
                    .font(BrandFont.headline())
                    .foregroundStyle(.white)
                Button("Primary action") {}
                    .font(BrandFont.headline(.semibold))
                    .primaryButtonStyle()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .tint(BrandColor.primary)
    }
}
