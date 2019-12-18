//
//  RoutePreviewViewController.swift
//  HackEMTU
//
//  Created by Jean Paul Marinho on 4/7/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PreviewRouteViewController: UIViewController {

    public var address: String!
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var overlayCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func getRoutes() {
        self.mapView.delegate = self
        APIClient.getRoutes(with: self.address) { (routes) in
            self.loadMap(with: routes)
        }
    }
    
    func loadMap(with routes: [Route]) {
        for route in routes {
            var coordinates = [CLLocationCoordinate2D]()
            for point in route.points {
                coordinates.append(CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude))
            }
            let sourcePlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: route.pois[0].point.latitude, longitude: route.pois[0].point.longitude), addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: route.pois[1].point.latitude, longitude: route.pois[1].point.longitude), addressDictionary: nil)
            let sourceAnnotation = MKPointAnnotation()
            sourceAnnotation.title = route.pois[0].name
            if let location = sourcePlacemark.location {
                sourceAnnotation.coordinate = location.coordinate
            }
            let destinationAnnotation = MKPointAnnotation()
            destinationAnnotation.title = route.pois[1].name
            if let location = destinationPlacemark.location {
                destinationAnnotation.coordinate = location.coordinate
            }
            if route.points[0].latitude == routes.last!.points[0].latitude && route.points[0].longitude == routes.last!.points[0].longitude{
                self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
            }
            else {
                self.mapView.showAnnotations([sourceAnnotation], animated: true )
            }
            let customPolyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
            self.mapView.add((customPolyline), level: MKOverlayLevel.aboveRoads)
            let rect = customPolyline.boundingMapRect
            let rectSize = rect.size.width + 8000
            let mapRect = MKMapRect(origin: rect.origin, size: MKMapSize(width: rectSize, height: rectSize))
            self.mapView.setRegion(MKCoordinateRegionForMapRect(mapRect), animated: true)
        }
    }
    
    @IBAction func keeperPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OverlayKeeperVC")
        self.addChildViewController(vc!)
        vc?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview((vc?.view)!)
        vc?.didMove(toParentViewController: self)
    }
}



extension PreviewRouteViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            DispatchQueue.main.async {
                self.getRoutes()
            }
        default:
            return
        }
    }
}



extension PreviewRouteViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        let pin = annotation as! MKPointAnnotation
        if pin.title == "Work" {
            view.image = UIImage(named: "icon-work")
        }
        else if pin.title == "Home" {
            view.image = UIImage(named: "icon-home")
        }
        else if pin.title == "Bus Station" {
            view.image = UIImage(named: "icon-bus")
        }
        else if pin.title == "keeper-in" {
            view.image = UIImage(named: "icon-keeper-on")
        }
        else if pin.title == "keeper-off" {
            view.image = UIImage(named: "icon-keeper-off")
        }
       return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("entered")
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->MKOverlayRenderer {
        let myLineRenderer = MKPolylineRenderer(overlay: overlay)
        switch self.overlayCounter {
        case 0:
            myLineRenderer.lineDashPattern = [0, 10]
            myLineRenderer.strokeColor = UIColor(rgb: 0xFF6506)
            myLineRenderer.lineWidth = 3
        case 1:
            myLineRenderer.strokeColor = UIColor(rgb: 0x006699)
            myLineRenderer.lineWidth = 3
        case 2:
            myLineRenderer.strokeColor = UIColor(rgb: 0xFF6506)
            myLineRenderer.lineWidth = 3
        case 3:
            myLineRenderer.lineDashPattern = [0, 10]
            myLineRenderer.strokeColor = UIColor(rgb: 0xFF6506)
            myLineRenderer.lineWidth = 3

        default:
            print("")
        }
        self.overlayCounter = self.overlayCounter + 1
        return myLineRenderer
    }
}
