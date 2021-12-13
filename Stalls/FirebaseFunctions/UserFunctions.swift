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
}

class firebaseUserFunctions{
    //var ref: DatabaseReference!

    //ref = Database.database().reference()
    
    func createObject(firebaseUser: firebaseUser){
        print("blah")
        self.ref.child("users").child(user.uid).setValue(["username": username])
    }
    
}
