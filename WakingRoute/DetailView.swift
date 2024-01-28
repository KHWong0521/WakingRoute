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
    @State var initialLat : Double = 0.0
    @State var initialLon : Double = 0.0
    @State var destinationLat : Double = 0.0
    @State var destinationLon : Double = 0.0
    
    fileprivate func saveAndBack() {
        route.name = name
        route.initialLat = initialLat
        route.initialLon = initialLon
        route.destinationLat = destinationLat
        route.destinationLon = destinationLon

        try? viewContext.save()

        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            TextField("Name", text: $name).padding()
            TextField("Initial Latitude", value: $initialLat, formatter: NumberFormatter()).padding()
            TextField("Initial Longtitude", value: $initialLon, formatter: NumberFormatter()).padding()
            TextField("Destination Latitude", value: $destinationLat, formatter: NumberFormatter()).padding()
            TextField("Destination Longtitude", value: $destinationLon, formatter: NumberFormatter()).padding()
            
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
            initialLat = route.initialLat
            initialLon = route.initialLon
            destinationLat = route.destinationLat
            destinationLon = route.destinationLon
        }
    }
}
