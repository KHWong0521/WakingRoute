//
//  MapView.swift
//  WakingRoute
//
//  Created by KwanHoWong on 28/12/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.302711, longitude: 114.147216), span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)))

    var body: some View {
        Map(position: $cameraPosition)
    }
}

#Preview {
    MapView()
}
