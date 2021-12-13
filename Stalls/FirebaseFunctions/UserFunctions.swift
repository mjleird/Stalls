//
//  UserFunctions.swift
//  Stalls
//
//  Created by Matt Leirdahl on 12/12/21.
//

import Foundation
import Firebase
import FirebaseFirestore

class firebaseUser{
    var objectID = ""
    var userID = ""
    var firstName = ""
    var lastName = ""
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
         "lastName": firebaseUser.lastName]
        
        return dict
    }
    
}
