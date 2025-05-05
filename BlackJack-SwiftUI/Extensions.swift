//
//  Extensions.swift
//  FinalSetGame
//
//  Created by Zheen Suseyi on 2/23/25.
//

import Foundation
import SwiftUI
// MARK: Image extensions
extension Image {
    static let star: Image = Image(systemName: "star.fill")
    static let triangle: Image = Image(systemName: "triangle.fill")
    static let circle: Image = Image(systemName: "circle.fill")
}

// MARK: Color extensions
extension Color {
    static let darkBlue = Color(red: 0.1, green: 0.2, blue: 0.5)
    static let starYellow = Color(red: 1.0, green: 1.0, blue: 0.0)
}

// MARK: Animation extensions
extension Animation {
    func rotate(_ isSelected: Bool) -> Animation {
        if isSelected {
            return Animation.linear(duration: 1).repeatForever(autoreverses: false)
        }
        else {
            return self
        }
    }
}

// MARK: Text Modifiers
struct Title2TextModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(.bold)
    }
}

struct MainTitleTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.largeTitle)
            .fontWeight(.light)
    }
}
struct ScoreTextModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.starYellow)
            .fontWeight(.medium)
    }
}
struct buttonTextModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.title2)
    }
}

struct GameRulesTextModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.black)
            .padding()
            .font(.system(size: 18))
            .fontWeight(.light)
    }
}
struct PaddingLargeTitleModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
    }
}
struct contentViewTextModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollIndicators(.hidden)
            .padding()
    }
}

struct boldHeadLineModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.bold)
    }
}


// MARK: View extensions
extension View {
    // MARK: Custom BG gradients
    public func dayTimeGradient() -> some View {
        LinearGradient(gradient: Gradient(colors: [.cyan, .white]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    public func nightTimeGradient() -> some View {
        LinearGradient(gradient: Gradient(colors: [.darkBlue, .indigo]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    public func casinoTurfGradient() -> some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 10/255, green: 112/255, blue: 41/255),  // Turf Green
                Color(red: 0/255, green: 64/255, blue: 0/255)       // Deep Green
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    
    // MARK: Text/UI Modifiers
    public func mainTitleText() -> some View {
        modifier(MainTitleTextModifier())
    }
    public func title2Text() -> some View {
        modifier(Title2TextModifer())
    }
    public func scoreText() -> some View {
        modifier(ScoreTextModifer())
    }
    public func buttonText() -> some View {
        modifier(buttonTextModifer())
    }
    public func ruleText() -> some View {
        modifier(GameRulesTextModifer())
    }
    public func paddingLargeTitleText() -> some View {
        modifier(PaddingLargeTitleModifer())
    }
    public func contentViewModifier() -> some View {
        modifier(contentViewTextModifer())
    }
    public func boldHeadLine() -> some View {
        modifier(boldHeadLineModifier())
    }
}

extension Image {
    func imageSizeAdjust(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .frame(width: width, height: height)
            .foregroundStyle(.white)
    }
}

