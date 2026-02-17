import SwiftUI

enum BrandColor {
    // Primary accent inspired by premium mobility apps
    static let primary = Color(red: 0/255, green: 122/255, blue: 255/255) // Deep electric blue
    static let primaryGradientStart = Color(red: 0/255, green: 92/255, blue: 205/255)
    static let primaryGradientEnd = Color(red: 10/255, green: 132/255, blue: 255/255)

    // Support colors
    static let background = Color.black
    static let card = Color(white: 0.08)
    static let separator = Color.white.opacity(0.12)
    static let subtle = Color.white.opacity(0.6)
}

enum BrandFont {
    static func largeTitle(_ weight: Font.Weight = .semibold) -> Font { .system(size: 34, weight: weight, design: .rounded) }
    static func title(_ weight: Font.Weight = .semibold) -> Font { .system(size: 28, weight: weight, design: .rounded) }
    static func headline(_ weight: Font.Weight = .semibold) -> Font { .system(size: 17, weight: weight, design: .rounded) }
    static func body(_ weight: Font.Weight = .regular) -> Font { .system(size: 16, weight: weight, design: .rounded) }
    static func caption(_ weight: Font.Weight = .medium) -> Font { .system(size: 13, weight: weight, design: .rounded) }
}

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(BrandColor.card)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(BrandColor.separator, lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 10)
            )
    }
}

extension View {
    func cardStyle() -> some View { modifier(CardStyle()) }

    func primaryButtonStyle() -> some View {
        self
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [BrandColor.primaryGradientStart, BrandColor.primaryGradientEnd], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: BrandColor.primary.opacity(0.6), radius: 16, x: 0, y: 8)
    }
}

struct AppBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            BrandColor.background.ignoresSafeArea()
            content
        }
    }
}

extension View {
    func appBackground() -> some View { modifier(AppBackground()) }
}
