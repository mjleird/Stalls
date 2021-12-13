//
//  CreateAccount.swift
//  Stalls
//
//  Created by Matt Leirdahl on 12/12/21.
//

import Foundation
import SwiftUI

struct createAccount: View{
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var UserName: String = ""
    @State var Password: String = ""
    @Binding var showingForm: Bool
    
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
                var successAccount = createEmailAccount()
                if(successAccount == true){
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
    
    func createEmailAccount() -> Bool{
        //create
        return true
    }
}

