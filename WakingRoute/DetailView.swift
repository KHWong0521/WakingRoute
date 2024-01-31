//
//  DetailView.swift
//  WakingRoute
//
//  Created by KwanHoWong on 28/12/2023.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var route : Route
    
    @State var name : String = ""
    @State var initialLat : String = ""
    @State var initialLon : String = ""
    @State var destinationLat : String = ""
    @State var destinationLon : String = ""
    @State var image : Data?
    
    fileprivate func saveAndBack() {
        route.name = name
        route.initialLat = Double(initialLat) ?? 0.0
        route.initialLon = Double(initialLon) ?? 0.0
        route.destinationLat = Double(destinationLat) ?? 0.0
        route.destinationLon = Double(destinationLon) ?? 0.0
        route.image = image

        try? viewContext.save()

        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            
            // Show the route image if exist
            if let image = image,
                let image = UIImage(data: image) {

                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200.0, height: 200.0)

            }
            
            VStack {
                HStack {
                    Text("Name:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    TextField("Name", text: $name)
                }
                
                HStack {
                    Text("Initial Latitude:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    TextField("Initial Latitude", text: $initialLat)
                }
                
                HStack {
                    Text("Initial Longtitude:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    TextField("Initial Longtitude", text: $initialLon)
                }
                
                HStack {
                    Text("Destination Latitude:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    TextField("Destination Latitude", text: $destinationLat)
                }
               
                HStack {
                    Text("Destination Longtitude:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    TextField("Destination Longtitude", text: $destinationLon)
                }
            }
            
            HStack {
                Button(action: {
                    saveAndBack()
                }, label: {
                    Text("Save")
                })
            }
            Spacer()
        }.onAppear {
            name = route.name!
            initialLat = String(route.initialLat)
            initialLon = String(route.initialLon)
            destinationLat = String(route.destinationLat)
            destinationLon = String(route.destinationLon)
            // image = route.image!
        }
    }
}
