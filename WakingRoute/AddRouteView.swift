//
//  AddRouteView.swift
//  WakingRoute
//
//  Created by KwanHoWong on 29/1/2024.
//

import SwiftUI
import PhotosUI

struct AddRouteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var showAddRouteView : Bool
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    
    @State var name : String = ""
    @State var initialLat : String = ""
    @State var initialLon : String = ""
    @State var destinationLat : String = ""
    @State var destinationLon : String = ""
    
    @State private var showAlert = false
    
    var body: some View {
        Text("Create a new route")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
        
        // Pick photo from photo album
        PhotosPicker(selection: $selectedItem, matching: .any(of: [.images, .not(.livePhotos)])) {
            Label(
                title: { Text("Select a photo") },
                icon: { Image(systemName: "photo.stack") }
            )
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selectedPhotoData = data
                }
            }
        }
        
        // Preview the selected image
        if let selectedPhotoData,
            let image = UIImage(data: selectedPhotoData) {

            Image(uiImage: image)
                .resizable()
                .frame(width: 100.0, height: 100.0)

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
                createRoute()
            }, label: {
                Text("Save")
            }).padding()
            Spacer()
            Button(action: {
                showAddRouteView = false
            }, label: {
                Text("Cancel")
            }).padding()
        }
        Spacer()
        
    }
    
    fileprivate func createRoute() {
        
        let route = Route(context: viewContext)
        
        route.name = name
        route.initialLat = Double(initialLat) ?? 0.0
        route.initialLon = Double(initialLon) ?? 0.0
        route.destinationLat = Double(destinationLat) ?? 0.0
        route.destinationLon = Double(destinationLon) ?? 0.0
        route.image = selectedPhotoData
        
        try? viewContext.save()
        
        self.name = ""
        self.initialLat = ""
        self.initialLon = ""
        self.destinationLat = ""
        self.destinationLon = ""
        
        showAddRouteView = false
    }
}

#Preview {
    AddRouteView(showAddRouteView: .constant(true))
}
