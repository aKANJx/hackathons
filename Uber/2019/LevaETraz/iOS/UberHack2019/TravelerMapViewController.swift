//
//  TravelerMapViewController.swift
//  UberHack2019
//
//  Created by Jean Paul Marinho on 02/06/19.
//  Copyright © 2019 aKANJ. All rights reserved.
//

import UIKit
import MapKit
import FloatingPanel
import CoreLocation


protocol PanelActionsDelegate {
    func nextScreen(from currentID: Int, to nextID: Int?)
}

class TravelerMapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var panelController = FloatingPanelController()
    var locationManager = CLLocationManager()
    var panelVCIndex = 0
    let thing = Place(coordinate: CLLocationCoordinate2D(latitude: -23.548740, longitude: -46.732710), title: "Ponto de coleta")
    let patron = Place(coordinate: CLLocationCoordinate2D(latitude: -23.58, longitude: -46.77), title: "Casa da Maria Augusta")
    let home = Place(coordinate: CLLocationCoordinate2D(latitude: -23.588, longitude: -46.778), title: "Minha casa")
    var thingRouteVC: ThingRouteViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        panelController.delegate = self
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "ThingDetailVC") as? ThingDetailViewController
        detailVC?.delegate = self
        thingRouteVC = storyboard?.instantiateViewController(withIdentifier: "ThingRouteVC") as? ThingRouteViewController
        panelController.surfaceView.backgroundColor = .clear
        panelController.surfaceView.cornerRadius = 9.0
        panelController.set(contentViewController: detailVC!)
        panelController.addPanel(toParent: self)
        showThingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        panelController.removeFromParent()
    }
    
    @IBAction func notificationPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.scheduleNotification(notificationType: "LevaETraz")
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        switch panelVCIndex {
        case 1:
            showVendorConfirmation()
        case 3:
            showComplete()
        default:
            return
        }
    }
    
    func showThingLocation() {
        mapView.addAnnotation(thing)
        mapView.selectAnnotation(thing, animated: true)
        let offsetCenter = CLLocationCoordinate2D(latitude: thing.coordinate.latitude + thing.coordinate.latitude*0.00008, longitude: thing.coordinate.longitude)
        mapView.setRegion(MKCoordinateRegion(center: offsetCenter, latitudinalMeters: 500, longitudinalMeters: 500), animated: false)
        panelVCIndex = 0
    }
    
    func showThingDistance() {
        panelController.move(to: .tip, animated: true)
        addRoute(from: mapView.userLocation.coordinate, endCoord: thing.coordinate)
        panelVCIndex = 1
    }
    
    func showFullDistance() {
        thingRouteVC.configure(time: 55, distance: 28)
        panelController.set(contentViewController: thingRouteVC!)
        panelController.move(to: .tip, animated: true)
        mapView.addAnnotation(patron)
        mapView.addAnnotation(home)
        addRoute(from: thing.coordinate, endCoord: patron.coordinate, using: .automobile)
        addRoute(from: patron.coordinate, endCoord: home.coordinate, using: .automobile)
        panelVCIndex = 3
    }
    
    func showVendorConfirmation() {
        let vendorVC = storyboard?.instantiateViewController(withIdentifier: "ThingVendorVC") as? ThingVendorViewController
        vendorVC?.delegate = self
        panelController.set(contentViewController: vendorVC!)
        panelVCIndex = 2
        panelController.move(to: .full, animated: true)
    }
    
    func showComplete() {
        let completeVC = storyboard?.instantiateViewController(withIdentifier: "ThingCompleteVC") as? ThingCompletedViewController
        panelController.set(contentViewController: completeVC!)
        panelController.move(to: .half, animated: true)
        panelVCIndex = 4
    }
    
    func addRoute(from startCoord: CLLocationCoordinate2D, endCoord: CLLocationCoordinate2D, using transportType: MKDirectionsTransportType = .walking) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: startCoord, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: endCoord, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = transportType
        let directions = MKDirections(request: request)
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            if (unwrappedResponse.routes.count > 0) {
                self.mapView.addOverlay(unwrappedResponse.routes[0].polyline)
                let padding: CGFloat = 100
                self.mapView.setVisibleMapRect(unwrappedResponse.routes[0].polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), animated: true)
            }
        }
    }
}


extension TravelerMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 5
            polylineRenderer.lineDashPattern = [0, 10]

            return polylineRenderer
        }
        return MKPolylineRenderer()
    }
}



extension TravelerMapViewController: CLLocationManagerDelegate {
}


extension TravelerMapViewController: PanelActionsDelegate {
    
    func nextScreen(from currentID: Int, to nextID: Int?) {
        switch currentID {
        case 0:
            panelController.set(contentViewController: thingRouteVC!)
            thingRouteVC.configure(time: 3, distance: 2)
            showThingDistance()
        case 3:
            showFullDistance()
        default:
            return
        }
    }
}


extension TravelerMapViewController: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return DefaultFloatingPanelLayout()
    }
}
