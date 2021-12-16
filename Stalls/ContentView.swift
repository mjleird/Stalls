//
//  ContentView.swift
//  Stalls
//
//  Created by Matt Leirdahl on 12/12/21.
//

import SwiftUI
import CoreData
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isLoggedIn: Bool = false
    @State var loggedInUser: String = ""
    @State var showingAbout: Bool = false
    @State var showingCheckin: Bool = false
 
    @State var value: Int = 1
    @State var formTitle: String = "Search"
    
    var body: some View {
        NavigationView {
            VStack(){
                if loggedInUser != ""{
                    TabView(selection: $value) {
                        SearchView().tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }.standardViewWtihGradientBackground()
                            .tag(1)
                        StandardView().tabItem {
                            Label("Nearby", systemImage: "paperplane")
                        }.standardViewWtihGradientBackground()
                            .tag(2)
                        StandardView().tabItem {
                            Label("Timeline", systemImage: "newspaper")
                        }.standardViewWtihGradientBackground()
                            .tag(3)
                        ProfileView().tabItem {
                            Label("User Profile", systemImage: "person.crop.circle")
                        }.tag(4)
                    }.font(.headlineCustom)
                    .accentColor(.white)
                    .onChange(of: value) { val in
                        if(val == 1){
                            self.formTitle = "Search"
                        }else if (val == 2){
                            self.formTitle = "Nearby"
                        }else if(val == 3){
                            self.formTitle = "Timeline"
                        }else{
                            self.formTitle = "Profile"
                        }
                    }
                }else{
                    LoginView(username: $username, password: $password, loggedInUser: $loggedInUser)
                }
                
            }
            .navigationTitle(formTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    if loggedInUser != "" {
                        Button(action: {
                            self.showingCheckin = true
                        }){
                            Image(systemName: "plus").foregroundColor(.white).font(.system(size: 16))
                        }
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if loggedInUser != "" {
                        Button(action: {
                            self.showingAbout.toggle()
                        }){
                            Image(systemName: "info.circle").foregroundColor(.white).font(.system(size: 16))
                        }
                    }
                }
            }
            .customNavigation
               .standardViewWtihGradientBackground()
          .sheet(isPresented: $showingAbout) {
                                        NavigationView{
                                            AboutView()
                                        }
                                        
                                    }.sheet(isPresented: $showingCheckin) {
                                        NavigationView{
                                            createCheckIn(isPresented: $showingCheckin)
                                        }
                                        
                                    }
           
                
        }
    }
}

struct LoginView: View{
    @Binding var username: String
    @Binding var password: String
    @Binding var loggedInUser: String
    @State var showingCreateAccount: Bool = false
    @State var errorMessage: String = ""
    var body: some View {
        VStack{
            if(errorMessage != ""){
                Text(errorMessage)
            }
            SuperTextField(placeholder: Text("Username").foregroundColor(.gray), text: $username).roundedTextInput()
            SuperTextFieldSecure(placeholder: Text("Password").foregroundColor(.gray), text: $password).roundedTextInput()
            Button(action: {
                print("Calling login script")
                loginUser()
            }){
                Text("Login").frame(minWidth: 300)
                
            }.padding(.bottom, 10)
            Button(action: {
                print("Open create account")
                showingCreateAccount.toggle()
            }){
                Text("Create Account").frame(minWidth: 300)
            }
        }
        .buttonStyle(CustomButtonStyle())
            .sheet(isPresented: $showingCreateAccount) {
                NavigationView{
                    createAccount(showingForm: $showingCreateAccount, loggedInUser: $loggedInUser)
                }
            }.onAppear{
               loggedInUser = userInfo().getUserId()
            }
    }
    
    func loginUser(){
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            let uid = authResult?.user.uid ?? nil
            //print(authResult!.user.uid)
            if(uid != nil){
                loggedInUser = authResult!.user.uid
                userInfo().logInUser(userId: loggedInUser)
            }else{
                errorMessage = error?.localizedDescription ?? ""
               // print(error?.localizedDescription)
            }

        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct StandardView: View{
    
    var body: some View {
        Form{
            NavigationLink(destination: AboutView()){
                Text("Test")
            }
        }.onAppear{
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
}

