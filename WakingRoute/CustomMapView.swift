//
//  CustomMapView.swift
//  WakingRoute
//
//  Created by KwanHoWong on 30/1/2024.
//

import Foundation
import SwiftUI
import MapKit

struct CustomMapView: UIViewRepresentable {
    
    @Binding var initial: CLLocationCoordinate2D
    @Binding var destination: CLLocationCoordinate2D
    
    private let mapView = WrappableMapView()
    
    func makeUIView(context: UIViewRepresentableContext<CustomMapView>) -> WrappableMapView {
        mapView.delegate = mapView
        return mapView
    }
    
    func updateUIView(_ uiView: WrappableMapView, context: UIViewRepresentableContext<CustomMapView>) {
        
        uiView.showsUserLocation = true
        
        // Clean the mapView when parse a new route
        uiView.removeAnnotations(uiView.annotations)
        let overlays = uiView.overlays
        uiView.removeOverlays(overlays)
        
        // Initial position
        let initialAnnotation = MKPointAnnotation()
        initialAnnotation.coordinate = initial
        uiView.addAnnotation(initialAnnotation)
        let initialPlacemark = MKPlacemark(coordinate: initial)

        // Destination position
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = destination
        uiView.addAnnotation(destinationAnnotation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        
        // Draw route
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: initialPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let response = response else { return }
            
            let route = response.routes[0]
            uiView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            uiView.setRegion(MKCoordinateRegion(rect), animated: true)
            
            uiView.setVisibleMapRect(rect, edgePadding: .init(top: 50.0, left: 50.0, bottom: 50.0, right: 50.0), animated: true)
            
        }
        
    }
    
    func setMapRegion(_ region: CLLocationCoordinate2D){
        mapView.region = MKCoordinateRegion(center: region, latitudinalMeters: 60000, longitudinalMeters: 60000)
    }
    
}

class WrappableMapView: MKMapView, MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = getRandomColor()
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func getRandomColor() -> UIColor{
         let randomRed = CGFloat.random(in: 0...1)
         let randomGreen = CGFloat.random(in: 0...1)
         let randomBlue = CGFloat.random(in: 0...1)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
  
}
