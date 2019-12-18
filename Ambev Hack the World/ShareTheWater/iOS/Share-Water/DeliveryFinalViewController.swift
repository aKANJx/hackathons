//
//  DeliveryViewController.swift
//  Share-Water
//
//  Created by Jean Paul Marinho on 14/02/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DeliveryFinalViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationUpdate()
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            self.locationUpdate()
        }
    }
    
    func locationUpdate() {
        APIClient.deliveryLocation { coordinate, error in
            guard error == nil else {
                return
            }
            self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000), animated: true)
        }
    }
    
    func routeDraw() {
        let sourceCoordinate = self.mapView.userLocation.coordinate
        let destinationCoordinate = CLLocationCoordinate2D(latitude: -14.7934700, longitude: -39.0463100)
        let locMark = MKPlacemark(coordinate: sourceCoordinate, addressDictionary: nil)
        let destMark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
        let source = MKMapItem(placemark: locMark)
        let destination = MKMapItem(placemark: destMark)
        let request = MKDirectionsRequest()
        request.source = source
        request.destination = destination
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: { (response:MKDirectionsResponse?, error:Error?) in
            if error == nil {
                self.mapView.removeOverlays(self.mapView.overlays)
                let directionsResponse = response!
                let route = directionsResponse.routes[0]
                self.mapView.add(route.polyline, level: MKOverlayLevel.aboveRoads)
            }
        })
    }
}



extension DeliveryFinalViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.orange
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation) {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
            annotationView.image = UIImage(named: "truck-icon")
            return annotationView
        }
        return nil
    }
}
