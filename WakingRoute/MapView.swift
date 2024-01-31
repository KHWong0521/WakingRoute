//
//  MapView.swift
//  WakingRoute
//
//  Created by KwanHoWong on 28/12/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var showingSheet = false
    
    // @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.302711, longitude: 114.147216), span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)))

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Route.name, ascending: true)],
        animation: .default)
    
    private var routes: FetchedResults<Route>
    
    @State var selectedRoute : Route?
    
    // Default route
    @State var locationInit = CLLocationCoordinate2D(latitude: 22.39943398325637, longitude: 113.97537588636834)
    @State var locationDest = CLLocationCoordinate2D(latitude: 22.38246815344559, longitude: 113.97536914919361)
    
    var body: some View {
        ZStack {
            // Map(position: $cameraPosition)
            CustomMapView(initial: $locationInit, destination: $locationDest)
            
            VStack{
                HStack {
                    Button(action: {
                        showingSheet.toggle()
                    }, label: {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 60))
                            .background(.white)
                            .clipShape(Capsule())
                    }).frame(maxWidth: .infinity, alignment: .trailing).padding()
                }.frame(maxHeight: .infinity, alignment: .bottom).padding()
            }
        }
        .sheet(isPresented: $showingSheet) {
            List {
                ForEach(routes) { route in
                    Button(action: {
                        selectedRoute = route
                        
                        // pass selected route's coordinates to binding parameters
                        // For Custom Map View
                        locationInit.latitude = selectedRoute!.initialLat
                        locationInit.longitude = selectedRoute!.initialLon
                        locationDest.latitude = selectedRoute!.destinationLat
                        locationDest.longitude = selectedRoute!.destinationLon
                        
                        showingSheet = false
                    }, label: {
                        Text("\(route.name!)")
                    })
                }
            }
        }
    }
}
