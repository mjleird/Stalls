//
//  ViewExtensions.swift
//  Stalls
//
//  Created by Matt Leirdahl on 12/12/21.
//

import Foundation
import SwiftUI

struct NavigationBarModifier: ViewModifier {
  var backgroundColor: UIColor
  var textColor: UIColor

  init(backgroundColor: UIColor, textColor: UIColor) {
    self.backgroundColor = backgroundColor
    self.textColor = textColor
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithTransparentBackground()
    coloredAppearance.backgroundColor = .clear
      coloredAppearance.titleTextAttributes = [.foregroundColor: textColor, .font: UIFont(name: Fonts().mainFont, size: 32) as Any]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: textColor]

    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    UINavigationBar.appearance().tintColor = textColor
  }

  func body(content: Content) -> some View {
    ZStack{
       content
        VStack {
          GeometryReader { geometry in
             Color(self.backgroundColor)
                .frame(height: geometry.safeAreaInsets.top)
                .edgesIgnoringSafeArea(.top)
              Spacer()
          }
        }
     }
  }
}
extension View {
  func navigationBarColor(_ backgroundColor: UIColor, textColor: UIColor) -> some View {
    self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, textColor: textColor))
  }
}
extension View {
  var customNavigation: some View {
      self.navigationBarColor(Colors().hexStringToUIColor(hex: Colors().mainColor), textColor: UIColor.white)
  }
}
struct SuperTextField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
    
}
struct SuperTextFieldSecure: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            SecureField("", text: $text, onCommit: commit)
        }
    }
    
}
extension View {
    func standardViewWtihGradientBackground() -> some View {
            self
                .background(LinearGradient(gradient: Gradient(colors: [Color(Colors().hexStringToUIColor(hex: Colors().mainColor)), Color(Colors().hexStringToUIColor(hex: Colors().gradientSecondaryColor))]), startPoint: .top, endPoint: .bottom))
                .font(.bodyCustom)
        }
    func roundedTextInput() -> some View {
        self.padding()
            .background(.white)
            .foregroundColor(.blue)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
    
}
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding()
            .background(Color(Colors().hexStringToUIColor(hex: Colors().buttonColor)))
            .foregroundColor(Color.white)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeInOut(duration: 0.2))
    }
}

class HostingController<Content> : UIHostingController<Content> where Content : View {
  @objc override dynamic open var preferredStatusBarStyle: UIStatusBarStyle {
     return .lightContent
  }
}
extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.white)
            .padding(10)
    }
}
