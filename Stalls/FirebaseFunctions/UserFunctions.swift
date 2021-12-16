//
//  UserFunctions.swift
//  Stalls
//
//  Created by Matt Leirdahl on 12/12/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class firebaseUser{
    var objectID = ""
    var userID = ""
    var firstName = ""
    var lastName = ""
    var numberOfCheckins = 0.0
    var sumOfCheckins = 0.0
    var averageRating = 0.0
}

class firebaseUserFunctions{    
    let db = Firestore.firestore()
    
    func createObject(firebaseUser: firebaseUser){
        db.collection("users").document(firebaseUser.objectID).setData(userDict(firebaseUser: firebaseUser)!)
    }
    func userDict(firebaseUser: firebaseUser) -> [String: Any]?{
        let dict =
        ["userId": firebaseUser.userID,
         "objectId": firebaseUser.objectID,
         "firstName": firebaseUser.firstName,
         "lastName": firebaseUser.lastName,
         "numberOfCheckins": firebaseUser.numberOfCheckins,
         "sumOfCheckins": firebaseUser.sumOfCheckins] as [String : Any]
    
        return dict
    }
       
}
