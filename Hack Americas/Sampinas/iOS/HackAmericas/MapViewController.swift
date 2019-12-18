//
//  MapViewController.swift
//  HackAmericas
//
//  Created by jeanpaul on 12/1/18.
//  Copyright © 2018 Jean Paul Marinho. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var panelView: UIView!
    let locationManager = CLLocationManager()
    var overlayCounter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        panelView.layer.roundCorners(radius: 12)
        panelView.layer.addShadow()
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadRoute1() {
        let sourceLocation = CLLocationCoordinate2D(latitude:-23.546539 , longitude: -46.653077)
        let destinationLocation = CLLocationCoordinate2D(latitude:-23.545388 , longitude: -46.650182)
        let destinationPin = POI(pinTitle: "Ponto de encontro", pinSubTitle: "", location: destinationLocation)
        self.mapView.addAnnotation(destinationPin)
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .walking
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }
            let route = directionResonse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
        }
    }
    
    func loadRoute2() {
        let sourceLocation = CLLocationCoordinate2D(latitude:-23.544462 , longitude: -46.668382)
        let destinationLocation = CLLocationCoordinate2D(latitude:-23.545388 , longitude: -46.650182)
        let sourcePin = POI(pinTitle: "Transporte - Início", pinSubTitle: "", location: destinationLocation)
        self.mapView.addAnnotation(sourcePin)
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
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
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
        }
    }
    
    func loadRoute3() {
        let sourceLocation = CLLocationCoordinate2D(latitude:-23.545388 , longitude: -46.650182)
        let destinationLocation = CLLocationCoordinate2D(latitude:-23.591700 , longitude: -46.671810)
        let destinationPin = POI(pinTitle: "Transporte - Final", pinSubTitle: "", location: destinationLocation)
        self.mapView.addAnnotation(destinationPin)
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
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
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
        }
    }
}



extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            
            let renderer = MKPolylineRenderer(overlay: overlay)
            switch self.overlayCounter {
            case 0:
                renderer.lineDashPattern = [0, 10]
                renderer.strokeColor = UIColor(named: "appBlue")
                renderer.lineWidth = 4.0
            case 1:
                renderer.strokeColor = UIColor(named: "appGreen")
                renderer.lineWidth = 4.0
            case 2:
                renderer.strokeColor = UIColor(named: "appGreen")
                renderer.lineWidth = 4.0
            default:
                print("")
            }
            self.overlayCounter = self.overlayCounter + 1
            return renderer
        }
        return MKPolylineRenderer()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            let noLocation = CLLocationCoordinate2D()
            let viewRegion = MKCoordinateRegion(center: noLocation, latitudinalMeters: 50, longitudinalMeters: 50)
            mapView.setRegion(viewRegion, animated: false)
            mapView.userTrackingMode = .followWithHeading
            loadRoute1()
            Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { (timer) in
                UIView.animate(withDuration: 0.6, animations: {
                    self.panelView.center = CGPoint(x: self.panelView.center.x, y: self.panelView.center.y + 200)
                })
                self.loadRoute2()
                self.loadRoute3()
            }
        default:
            return
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
    }
}
