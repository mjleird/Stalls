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
import FirebaseFirestore

struct ProfileView: View {
   
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @State var returnedPlace: place = place()
    @State var showingCheckin = false
    
    @State var name: String = ""
    @State var userCheckins: Int = 0
    
    @State var userObject: firebaseUser = firebaseUser()
 

    var body: some View {
        Form{
            Section(header: Text("About me").font(.headlineCustom).foregroundColor(.white)){
                HStack(){
                    Text("Name")
                    Spacer()
                    Text("\(userObject.firstName) \(userObject.lastName)")
                }
                HStack(){
                    Text("# of Checkins")
                    Spacer()
                    Text("\(userObject.numberOfCheckins)")
                }
                HStack(){
                    Text("Average rating")
                    Spacer()
                    Text("\(userObject.averageRating)")
                }
            }
        }
        .customNavigation
        .standardViewWtihGradientBackground()
         .onAppear{
             UITableView.appearance().backgroundColor = .clear
            setUserObject()
         }.sheet(isPresented: $showingCheckin) {
             VStack(){
                 PlacePicker(presentationMode: _presentationMode, place: $returnedPlace)
             }
         }
    }
    func setUserObject(){
        let db = Firestore.firestore()
        var userToReturn = firebaseUser() //INITIALISED AS EMPTY

        let newVar = db.collection("users").document("XHno2vhDrGVAVRILi2KliHrfyjz1").getDocument { (document, error) in
              userToReturn.firstName = document?["firstName"] as! String ?? ""
              userToReturn.lastName = document?["lastName"] as! String ?? ""
              userToReturn.numberOfCheckins = document?["numberOfCheckins"] as! Double ?? 0
              userToReturn.sumOfCheckins = document?["ratingSum"] as! Double ?? 0
              userToReturn.averageRating = userToReturn.sumOfCheckins / userToReturn.numberOfCheckins
              print("downloaded")
            
              userObject = userToReturn
          }
    }
}
