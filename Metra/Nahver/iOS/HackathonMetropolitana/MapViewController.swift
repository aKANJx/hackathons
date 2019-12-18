//
//  ViewController.swift
//  HackathonMetropolitana
//
//  Created by Jean Paul Marinho on 19/03/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import MapKit
import AEXML
import CountdownLabel

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var vehicle: Vehicle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func loadVehicles() {
        let region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 13000, 13000)
        self.mapView.setRegion(region, animated: false)
        self.mapView.addAnnotations(Vehicle.vehicles())

    }
    
    func direction(sourceCoord: CLLocationCoordinate2D, destinationCoord: CLLocationCoordinate2D, transportType: MKDirectionsTransportType) -> MKDirections {
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoord, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoord, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = transportType
        return MKDirections(request: request)
    }
    
    func generateRoute(sourceCoord: CLLocationCoordinate2D, destinationCoord: CLLocationCoordinate2D, routeTitle: String, transportType: MKDirectionsTransportType) {
        let directions = self.direction(sourceCoord: sourceCoord, destinationCoord: destinationCoord, transportType: transportType)
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            if (unwrappedResponse.routes.count > 0) {
                let route = unwrappedResponse.routes[0]
                //self.collectDistanceLabel.text = "\(route.distance)m"
                route.polyline.title = routeTitle
                self.mapView.add(route.polyline)
            }
        }
    }
    
    func calculateETA(sourceCoord: CLLocationCoordinate2D, destinationCoord: CLLocationCoordinate2D, transportType: MKDirectionsTransportType) {
        let directions = self.direction(sourceCoord: sourceCoord, destinationCoord: destinationCoord, transportType: transportType)
        directions.calculateETA { (response, error) in
            guard response != nil else {
                return
            }
            //self.vehicleDistanceLabel.text = "\(response!.distance)m"
        }
    }
    
    func loadVehicle() {
        var routeCoordinates = [CLLocationCoordinate2D]()
        guard
            let xmlPath = Bundle.main.path(forResource: "Vehicle", ofType: "gpx"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
            else {
                print("resource not found!")
                return
        }
        var options = AEXMLOptions()
        options.parserSettings.shouldProcessNamespaces = false
        options.parserSettings.shouldReportNamespacePrefixes = false
        options.parserSettings.shouldResolveExternalEntities = false
        do {
            let xmlDoc = try AEXMLDocument(xml: data, options: options)
            if let locations = xmlDoc.root["trkpt"].all {
                for location in locations {
                    let latitude = Double(location.attributes["lat"]!)!
                    let longitude = Double(location.attributes["lon"]!)!
                    let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                    routeCoordinates.append(coordinate)
                }
            }
        }
        catch {
            return
        }
        self.vehicle = Vehicle(routeCoordinates: routeCoordinates)
        self.mapView.addAnnotation(self.vehicle!)
        self.generateRoute(sourceCoord: self.vehicle!.routeCoordinates[0], destinationCoord: self.vehicle!.routeCoordinates[(self.vehicle?.routeCoordinates.count)!-1], routeTitle: "VehicleRoute", transportType: .automobile)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            self.vehicle?.currentCoordinateIndex = (self.vehicle?.currentCoordinateIndex)! + 1
            self.vehicle?.updateCoordinate()
            self.calculateETA(sourceCoord: (self.vehicle!.coordinate), destinationCoord: self.vehicle!.routeCoordinates[(self.vehicle?.routeCoordinates.count)!-1], transportType: .automobile)
            self.mapView.removeAnnotation(self.vehicle!)
            self.mapView.addAnnotation(self.vehicle!)
        }

    }

    func loadCollect() {
        let region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 500, 500)
        self.mapView.setRegion(region, animated: true)
        let destination = Placemark(title: "Ponto de coleta", coordinate: CLLocationCoordinate2DMake(-23.689449, -46.570855))
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotation(destination)
        self.generateRoute(sourceCoord: self.mapView.userLocation.coordinate, destinationCoord: destination.coordinate, routeTitle: "CollectRoute", transportType: .walking)
        self.loadVehicle()
    }
    
    func locationUpdated() {
        self.loadVehicles()
    }
}





extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        switch annotation.self {
        case is Placemark:
            let annotationIdentifier = "destinationIdentifier"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                annotationView!.canShowCallout = true
            }
            else {
                annotationView!.annotation = annotation
            }
            annotationView!.image = UIImage(named: "vehicle-annotation")
            return annotationView
        case is Vehicle:
            let annotationIdentifier = "vehicleIdentifier"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            }
            else {
                annotationView!.annotation = annotation
            }
            annotationView!.image = UIImage(named: "vehicle")
            return annotationView
        default:
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.lineWidth = 5
            switch overlay.title!! {
            case "CollectRoute":
                polylineRenderer.strokeColor = UIColor.purple
            default:
                polylineRenderer.strokeColor = UIColor.yellow
            }
            return polylineRenderer
        }
        return MKPolylineRenderer()
    }
}
