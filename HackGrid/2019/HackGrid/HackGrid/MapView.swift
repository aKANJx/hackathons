//
//  MapView.swift
//  HackGrid
//
//  Created by Jean Paul Marinho on 14/09/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    
    @Binding var owners: [Owner]
    @Binding var selectedOwner: Owner?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let overlays = uiView.overlays
        uiView.removeOverlays(overlays)
        updateAnnotations(from: uiView)
        let coordinate = CLLocationCoordinate2D(
            latitude: -22.907390, longitude: -43.175200)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let newAnnotations = owners.map { OwnerAnnotation(owner: $0) }
        mapView.addAnnotations(newAnnotations)
        if let selectedAnnotation = newAnnotations.filter({ $0.id == selectedOwner?.id }).first {
            mapView.selectAnnotation(selectedAnnotation, animated: true)
        }
        
    }
    
    final class Coordinator: NSObject, MKMapViewDelegate {
        var control: MapView
        
        init(_ control: MapView) {
            self.control = control
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let coordinates = view.annotation?.coordinate else { return }
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: coordinates, span: span)
            drawRoute(mapView, to: coordinates)
            mapView.setRegion(region, animated: true)
        }
        
        func drawRoute(_ mapView: MKMapView, to destinationCoordinate: CLLocationCoordinate2D) {
            let sourceCoordinate = CLLocationCoordinate2D(
                latitude: -22.907390, longitude: -43.175200)
            let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
            let destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinate)
            let directionRequest = MKDirections.Request()
            directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
            directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
            directionRequest.transportType = .automobile
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate { (response, error) in
                guard let directionResonse = response else {
                    if let error = error {
                        print("we have error getting directions==\(error.localizedDescription)")
                    }
                    return
                }
                let route = directionResonse.routes[0]
                mapView.addOverlay(route.polyline, level: .aboveRoads)
                let rect = route.polyline.boundingMapRect
                mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor(named: "sec")
            renderer.lineWidth = 4.0
            return renderer
        }
    }
}
