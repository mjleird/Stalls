//
//  StallsApp.swift
//  Stalls
//
//  Created by Matt Leirdahl on 12/12/21.
//

import SwiftUI
import Firebase
import GooglePlaces

@main
struct StallsApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        FirebaseApp.configure()
        GMSPlacesClient.provideAPIKey("AIzaSyCrnis3INHM5ND4n86bQZf1HsnQvaefA6U")
        
        return true
    }
}
