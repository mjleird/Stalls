//
//  UserFunctions.swift
//  Stalls
//
//  Created by Matt Leirdahl on 12/12/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import GooglePlaces

class place{
    var placeID = ""
    var name = ""
}
class checkInClass{
    var userId = ""
    var placeId = ""
    var rating = 0.0
    var type = ""
}
class firebaseStallFunctions{
    let db = Firestore.firestore()
    
    func createObject(firebaseCheckIn: checkInClass){
        var ref: DocumentReference? = nil
        
        var ref1: DocumentReference? = nil
        
        ref1 = self.db.collection("places").document(firebaseCheckIn.placeId)
        
        ref1!.getDocument { (document, error) in
            if(document!.exists == false){
                ref = self.db.collection("checkIns").addDocument(data: self.checkInDict(checkIn: firebaseCheckIn)!){ err in
                    let docId = ref!.documentID

                    self.db.collection("users").document(firebaseCheckIn.userId).collection("checkIns").document(docId).setData(self.checkInDict(checkIn: firebaseCheckIn)!)
                    
                    self.db.collection("places").document(firebaseCheckIn.placeId).setData(["placeId": firebaseCheckIn.placeId])
                    
                    self.db.collection("places").document(firebaseCheckIn.placeId).collection("reviews").document(docId).setData(self.checkInDict(checkIn: firebaseCheckIn)!)
                    
                    self.db.collection("places").document(firebaseCheckIn.placeId).updateData(["rating": FieldValue.increment(Int64(1)), "ratingSum" : FieldValue.increment(Int64(firebaseCheckIn.rating))])
                    
                }
            }else{
                ref = self.db.collection("checkIns").addDocument(data: self.checkInDict(checkIn: firebaseCheckIn)!){ err in
                    let docId = ref!.documentID
    
                    self.db.collection("users").document(firebaseCheckIn.userId).collection("checkIns").document(docId).setData(self.checkInDict(checkIn: firebaseCheckIn)!)
                    
                    self.db.collection("places").document(firebaseCheckIn.placeId).collection("reviews").document(docId).setData(self.checkInDict(checkIn: firebaseCheckIn)!)
                    
                    self.db.collection("places").document(firebaseCheckIn.placeId).updateData(["rating": FieldValue.increment(Int64(1)), "ratingSum" : FieldValue.increment(Int64(firebaseCheckIn.rating))])
                    
                }
            }
        }
            
    }
    func checkInDict(checkIn: checkInClass)-> [String: Any]?{
        let dict =
        ["userId": checkIn.userId,
         "placeId": checkIn.placeId,
         "type": checkIn.type,
         "rating": checkIn.rating] as [String : Any]
        
        return dict
    }
}
class googlePlacesFunctions{
    
    func getPlaceByID(){
        // A hotel in Saigon with an attribution.
        let placeID = "ChIJV4k8_9UodTERU5KXbkYpSYs"
        let placesClient = GMSPlacesClient.shared()

        // Specify the place data types to return.
        let fields: GMSPlaceField = [.name, .formattedAddress]

        placesClient.fetchPlace(fromPlaceID: "ChIJV4k8_9UodTERU5KXbkYpSYs", placeFields: fields, sessionToken: nil, callback: {
          (place: GMSPlace?, error: Error?) in
          if let error = error {
            print("An error occurred: \(error.localizedDescription)")
            return
          }
          if let place = place {
           // self.lblName?.text = place.name
            print("The selected place is: \(place.name)")
          }
        })
    }
}
