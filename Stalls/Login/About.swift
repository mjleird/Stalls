//
//  About.swift
//  Barker
//
//  Created by Matt Leirdahl on 11/28/21.
//

import Foundation
import SwiftUI
import StoreKit
import SafariServices
import UIKit


struct AboutView: View {
    let version : String! = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
    let build : String! = (Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String)
    let shadow = 2 as CGFloat
    let padding = 5 as CGFloat
    
    @Environment(\.colorScheme) var colorScheme
    
    
    @State var showSafariPro = false
    
    var body: some View {
        Form{
            Section(header: Text("This App").font(.headlineCustom).foregroundColor(.white)){
                Button(action: {
                    //SKStoreReviewController.requestReview()
                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                }) {
                      Text("Rate Stalls").foregroundColor(colorScheme == .dark ? Color.white : Color.black).fontWeight(.light).font(.headlineCustom)
                 }.font(.headlineCustom)
                HStack{
                    Text("Version").font(.headlineCustom)
                    Spacer()
                    Text("\(version)").font(.headlineCustom)
                }
                HStack{
                    Text("Build").font(.headlineCustom)
                    Spacer()
                    Text("\(build)").font(.headlineCustom)
                }
                Text("© 2021, Garbage Pizza Industries").font(.headlineCustom)
                Button(action: {
                    userInfo().logOutUser()
                }) {
                    Text("Logout").foregroundColor(.red).fontWeight(.light).font(.headlineCustom)
                 }.font(.headlineCustom)
            }
        }
        .customNavigation
        .standardViewWtihGradientBackground()
         .navigationBarTitle(Text("About"), displayMode: .inline)
         .onAppear{
             UITableView.appearance().backgroundColor = .clear
         }
    }
    struct SafariView: UIViewControllerRepresentable {

        let url: URL

        func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
            return SFSafariViewController(url: url)
        }

        func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

        }

    }
}
