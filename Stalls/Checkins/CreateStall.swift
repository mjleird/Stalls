import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct createCheckIn: View{
   // @State var rating: String = ""
    @State var rating = 50.0
    @State private var isEditing = false
    
    var body: some View {
        VStack(){
            Spacer()
            Form{
                Section(header: Text("Location").font(.headlineCustom)){
                
                }
                Section(header: Text("Rating").font(.headlineCustom)){
                    Slider(
                            value: $rating,
                            in: 0...10,
                            step: 0.5
                        ) {
                            Text("Speed")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("10")
                        }
                }
            }.onAppear{
                UITableView.appearance().backgroundColor = .clear
            }
            Button(action: {
                print("Check in!")
               
            }){
                Text("Check in").frame(minWidth: 300)
            }
            Spacer()
        }
        .customNavigation
            .navigationBarTitle(Text("Checkin"), displayMode: .inline)
            .standardViewWtihGradientBackground()
            .buttonStyle(CustomButtonStyle())
    }
    
}
