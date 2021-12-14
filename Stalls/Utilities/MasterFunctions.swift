//
//  MasterFunctions.swift
//  Stalls
//
//  Created by Matt Leirdahl on 12/13/21.
//

import Foundation
import UIKit

class userInfo{
    var userKeyName = "UserId"
    func checkIfLoggedIn() -> Bool{
        let userID = UserDefaults.standard.string(forKey: userKeyName)
        if (userID == nil){
            return false
        }
        return true
    }
    func logInUser(userId: String){
        UserDefaults.standard.set(userId, forKey: userKeyName)
    }
    func logOutUser(){
        UserDefaults.standard.set("", forKey: userKeyName)
    }
    func getUserId() -> String{
        let returnID = UserDefaults.standard.string(forKey: userKeyName) ?? ""
        return returnID
    }
}
