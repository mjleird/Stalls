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

struct SearchView: View {
   
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @State var returnedPlace: place = place()
    @State var showingCheckin = false
    
    var body: some View {
        Form{
            Section(header: Text("Search for a venue").font(.headlineCustom).foregroundColor(.white)){
                HStack(){
                    Text(returnedPlace.name)
                    Spacer()
                    Image(systemName: "arrow.right").foregroundColor(.white).font(.system(size: 16))
                }.onTapGesture{
                    showingCheckin.toggle()
                }
            }
            if(returnedPlace.sumOfCheckins > 0){
                Section(header: Text("Location Details").font(.headlineCustom).foregroundColor(.white)){
                    HStack(){
                        Text("Total Checkins")
                        Spacer()
                        Text("\(returnedPlace.sumOfCheckins, specifier: "%.2f")").foregroundColor(colorScheme == .dark ? Color.white : Color.black).fontWeight(.light).font(.headlineCustom)
                    }
                    HStack(){
                        Text("Average Score")
                        Spacer()
                        Text("\(returnedPlace.averageRating, specifier: "%.2f")").foregroundColor(colorScheme == .dark ? Color.white : Color.black).fontWeight(.light).font(.headlineCustom)
                    }
                    /*Text(returnedPlace.placeID).foregroundColor(colorScheme == .dark ? Color.white : Color.black).fontWeight(.light).font(.headlineCustom)*/
                    
                    
                }
            }
            
        }
        .customNavigation
        .standardViewWtihGradientBackground()
         .onAppear{
             UITableView.appearance().backgroundColor = .clear
            
         }.onChange(of: returnedPlace.placeID) { newValue in
             print("newValue \(newValue)")
             getFirebasePlaceValues(newVal: newValue)
             
         }
         .sheet(isPresented: $showingCheckin) {
             VStack(){
                 PlacePicker(presentationMode: _presentationMode, place: $returnedPlace)
             }
         }
        }
    func getFirebasePlaceValues(newVal: String){
            let db = Firestore.firestore()
            var returnObj = place() //INITIALISED AS EMPTY

            let newVar = db.collection("places").document(newVal).getDocument { (document, error) in
                    
                returnObj.placeID = newVal
                returnObj.sumOfCheckins = document?["rating"] as? Double ?? 0.0
                returnObj.sumOfRatings = document?["ratingSum"] as? Double ?? 0.0
                returnObj.name = document?["name"] as? String ?? ""
                returnObj.averageRating = returnObj.sumOfRatings / returnObj.sumOfCheckins
                print(document?["rating"] as? Double ?? 0.0)
                
                returnedPlace = returnObj
              }
        }
}
