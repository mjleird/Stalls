//
//  CreateAccount.swift
//  Stalls
//
//  Created by Matt Leirdahl on 12/12/21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct createAccount: View{
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var UserName: String = ""
    @State var Password: String = ""
    @Binding var showingForm: Bool
    @Binding var loggedInUser: String
    
    var body: some View {
        VStack(){
            Spacer()
            Form{
                Section(header: Text("User info").font(.headlineCustom)){
                    HStack(){
                        Text("Username").font(.headlineCustom)
                        Spacer()
                        TextField("Username", text: $UserName).multilineTextAlignment(.trailing).font(.headlineCustom)
                    }
                    HStack(){
                        Text("Password").font(.headlineCustom)
                        Spacer()
                        SecureField("Password", text: $Password).multilineTextAlignment(.trailing).font(.headlineCustom)
                    }
                }
                Section(header: Text("Account info").font(.headlineCustom)){
                    HStack(){
                        Text("First Name").font(.headlineCustom)
                        Spacer()
                        TextField("First Name", text: $firstName).multilineTextAlignment(.trailing).font(.headlineCustom)
                    }
                    HStack(){
                        Text("Last Name").font(.headlineCustom)
                        Spacer()
                        TextField("Last Name", text: $lastName).multilineTextAlignment(.trailing).font(.headlineCustom)
                    }
                }
               
            }.onAppear{
                UITableView.appearance().backgroundColor = .clear
            }
            Button(action: {
                print("Submit create account")
                var successAccount = createEmailAccount(email: UserName, pass: Password)
                if(successAccount == "success"){
                    showingForm.toggle()
                }
            }){
                Text("Create").frame(minWidth: 300)
            }
            Spacer()
        }
        .customNavigation
            .navigationBarTitle(Text("Create New Account"), displayMode: .inline)
            .standardViewWtihGradientBackground()
            .buttonStyle(CustomButtonStyle())
    }
    
    func createEmailAccount(email: String, pass: String) -> String{
        //create
        var returnString = ""
        Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
            print(error?.localizedDescription)
            let uid = authResult!.user.uid
            
            if (error == nil){
                loggedInUser = uid
                returnString =  "success"
            }else{
                returnString = error!.localizedDescription
            }
           
            print(uid)
        }
        return returnString
    }
}

