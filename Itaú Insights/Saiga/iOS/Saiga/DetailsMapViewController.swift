//
//  DetailsMapViewController.swift
//  Saiga
//
//  Created by Bruno Faganello Neto on 26/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit
import MapKit

class DetailsMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pipoca"
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: -23.598753, longitude: -46.679165)
        mapView.addAnnotation(annotation)
        
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: -23.598399, longitude: -46.682491)
        mapView.addAnnotation(annotation2)
        
        let annotation3 = MKPointAnnotation()
        annotation3.coordinate = CLLocationCoordinate2D(latitude: -23.594848, longitude: -46.685726)
        mapView.addAnnotation(annotation3)
        
        let annotation4 = MKPointAnnotation()
        annotation4.coordinate = CLLocationCoordinate2D(latitude: -23.589028, longitude: -46.688144)
        mapView.addAnnotation(annotation4)
        
        let annotation5 = MKPointAnnotation()
        annotation5.coordinate = CLLocationCoordinate2D(latitude: -23.583831, longitude: -46.683376)
        mapView.addAnnotation(annotation5)
        
        let annotation6 = MKPointAnnotation()
        annotation6.coordinate = CLLocationCoordinate2D(latitude: -23.606194, longitude: -46.677145)
        mapView.addAnnotation(annotation6)
        
        var region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        region.center = annotation5.coordinate
        mapView.setRegion(region, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
