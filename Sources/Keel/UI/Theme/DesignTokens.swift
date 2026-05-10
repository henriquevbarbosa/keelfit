import SwiftUI

// MARK: - Color Tokens

extension Color {
    // Primary Palette (Dark Mode)
    static let appBackground = Color(red: 0.039, green: 0.039, blue: 0.039)    // #0A0A0A
    static let surface = Color(red: 0.078, green: 0.078, blue: 0.078)         // #141414
    static let surfaceElevated = Color(red: 0.102, green: 0.102, blue: 0.102)   // #1A1A1A
    static let divider = Color(red: 0.165, green: 0.165, blue: 0.165)           // #2A2A2A
    static let textPrimary = Color.white
    static let textSecondary = Color(red: 0.627, green: 0.627, blue: 0.627)    // #A0A0A0
    static let textTertiary = Color(red: 0.420, green: 0.420, blue: 0.420)      // #6B6B6B

    // Accent
    static let accent = Color(red: 0.784, green: 1.0, blue: 0.0)               // #C8FF00
    static let accentDim = Color(red: 0.620, green: 0.800, blue: 0.0)          // #9ECC00
    static let accentGlow = Color(red: 0.784, green: 1.0, blue: 0.0).opacity(0.25)

    // Semantic
    static let success = Color(red: 0.0, green: 0.902, blue: 0.463)             // #00E676
    static let warning = Color(red: 1.0, green: 0.702, blue: 0.0)              // #FFB300
    static let error = Color(red: 1.0, green: 0.322, blue: 0.322)              // #FF5252
    static let info = Color(red: 0.267, green: 0.541, blue: 1.0)               // #448AFF

    // Macros
    static let proteinColor = Color(red: 1.0, green: 0.420, blue: 0.420)        // #FF6B6B
    static let carbsColor = Color(red: 0.306, green: 0.863, blue: 0.769)        // #4ECDC4
    static let fatColor = Color(red: 1.0, green: 0.902, blue: 0.427)           // #FFE66D
}

// MARK: - Typography

extension Font {
    static let display = Font.system(size: 34, weight: .bold, design: .default)
    static let title1 = Font.system(size: 28, weight: .bold)
    static let title2 = Font.system(size: 22, weight: .semibold)
    static let title3 = Font.system(size: 18, weight: .semibold)
    static let bodyRegular = Font.system(size: 16, weight: .regular)
    static let bodyMedium = Font.system(size: 16, weight: .medium)
    static let callout = Font.system(size: 14, weight: .semibold)
    static let caption = Font.system(size: 12, weight: .regular)
}

// MARK: - Spacing (4pt base grid)

struct Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 32
    static let xxxl: CGFloat = 48
}

// MARK: - Radius

struct Radius {
    static let sm: CGFloat = 4
    static let md: CGFloat = 8
    static let lg: CGFloat = 12
    static let xl: CGFloat = 16
    static let full: CGFloat = 9999
}

// MARK: - Shadows (Dark Mode)

struct AppShadows {
    static let sm = ShadowStyle(offset: CGSize(width: 0, height: 1), radius: 2, opacity: 0.5)
    static let md = ShadowStyle(offset: CGSize(width: 0, height: 4), radius: 6, opacity: 0.4)
    static let lg = ShadowStyle(offset: CGSize(width: 0, height: 10), radius: 15, opacity: 0.3)
}

struct ShadowStyle {
    let offset: CGSize
    let radius: CGFloat
    let opacity: Double
}

// MARK: - Previews

#Preview("Tokens") {
    VStack(spacing: Spacing.md) {
        HStack(spacing: Spacing.sm) {
            Rectangle().fill(Color.accent).frame(width: 40, height: 40).cornerRadius(Radius.md)
            Rectangle().fill(Color.surface).frame(width: 40, height: 40).cornerRadius(Radius.md)
            Rectangle().fill(Color.proteinColor).frame(width: 40, height: 40).cornerRadius(Radius.md)
            Rectangle().fill(Color.carbsColor).frame(width: 40, height: 40).cornerRadius(Radius.md)
            Rectangle().fill(Color.fatColor).frame(width: 40, height: 40).cornerRadius(Radius.md)
        }
        Text("Display").font(.display).foregroundColor(.textPrimary)
        Text("Title 1").font(.title1).foregroundColor(.textSecondary)
        Text("Body").font(.bodyRegular).foregroundColor(.textTertiary)
    }
    .padding(Spacing.xl)
    .background(Color.appBackground)
}
