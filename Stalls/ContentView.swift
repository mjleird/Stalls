//
//  ContentView.swift
//  Stalls
//
//  Created by Matt Leirdahl on 12/12/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(){
                if isLoggedIn{
                    Text("You're logged in")
                }else{
                    LoginView(username: $username, password: $password)
                }
                
            }.padding(.leading, 25)
                .padding(.trailing, 25)
            .navigationTitle("Stalls") // delete if you want no title
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())
            .customNavigation
            .standardViewWtihGradientBackground()
                
        }
    }
}

struct LoginView: View{
    @Binding var username: String
    @Binding var password: String
    @State var showingCreateAccount: Bool = false
    var body: some View {
        VStack{
            SuperTextField(placeholder: Text("Username").foregroundColor(.gray), text: $username).roundedTextInput()
            SuperTextFieldSecure(placeholder: Text("Password").foregroundColor(.gray), text: $password).roundedTextInput()
            Button(action: {
                print("Calling login script")
            }){
                Text("Login").frame(minWidth: 300)
            }.padding(.bottom, 10)
            Button(action: {
                print("Open create account")
                showingCreateAccount.toggle()
            }){
                Text("Create Account").frame(minWidth: 300)
            }
        }.buttonStyle(CustomButtonStyle())
            .sheet(isPresented: $showingCreateAccount) {
                NavigationView{
                    createAccount(showingForm: $showingCreateAccount)
                }
            }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
