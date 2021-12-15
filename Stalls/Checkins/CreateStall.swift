import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import GooglePlaces

struct createCheckIn: View{
   // @State var rating: String = ""
    @State var rating = 5.0
    @State private var isEditing = false
    @State var address = ""
    @State var returnedPlace: place = place()
    @State var checkIn: checkInClass = checkInClass()
    @State var showingCheckin = false
    @State var bathroomSelect = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(){
            Spacer()
            Form{
                Section(header: Text("Location").font(.headlineCustom)){
                    //NavigationLink("Navigator", destination: Text("Subsequent View"))
                    HStack(){
                        Text(returnedPlace.name)
                        Spacer()
                        Image(systemName: "arrow.right").foregroundColor(.white).font(.system(size: 16))
                    }.onTapGesture{
                        showingCheckin.toggle()
                    }
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
                Section(header: Text("Type").font(.headlineCustom)){
                    Picker(selection: $bathroomSelect, label: Text("Label")) {
                                   Text("Male").tag(0)
                                   Text("Female").tag(1)
                                   Text("Neutral").tag(2)
                               }.pickerStyle(SegmentedPickerStyle())
                }
            }.onAppear{
                UITableView.appearance().backgroundColor = .clear
                print("Opened")
            }
            Button(action: {
                print("Check in!")
                checkIn.userId = userInfo().getUserId()
                checkIn.placeId = returnedPlace.placeID
                checkIn.type = String(bathroomSelect)
                checkIn.rating = rating
                
                firebaseStallFunctions().createObject(firebaseCheckIn: checkIn)

            }){
                Text("Check in").frame(minWidth: 300)
            }
           .sheet(isPresented: $showingCheckin) {
                VStack(){
                    PlacePicker(presentationMode: _presentationMode, address: $address, place: $returnedPlace)
                }
                
            }
            Text(address).hidden()
            Spacer()
        }
        .customNavigation
            .navigationBarTitle(Text("Checkin"), displayMode: .inline)
            .standardViewWtihGradientBackground()
            .buttonStyle(CustomButtonStyle())
    }
    
}
struct PlacePicker: UIViewControllerRepresentable {

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    @Environment(\.presentationMode) var presentationMode
    @Binding var address: String
    @Binding var place: place

    func makeUIViewController(context: UIViewControllerRepresentableContext<PlacePicker>) -> GMSAutocompleteViewController {

        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator


        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
          UInt(GMSPlaceField.placeID.rawValue))
        autocompleteController.placeFields = fields

        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        filter.country = "US"
        autocompleteController.autocompleteFilter = filter
        return autocompleteController
    }

    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<PlacePicker>) {
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {

        var parent: PlacePicker

        init(_ parent: PlacePicker) {
            self.parent = parent
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            DispatchQueue.main.async {
                print(place.description.description as Any)
                self.parent.address =  place.name!
                self.parent.place.name = place.name!
                self.parent.place.placeID = place.placeID!
                self.parent.presentationMode.wrappedValue.dismiss()
            }
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}

