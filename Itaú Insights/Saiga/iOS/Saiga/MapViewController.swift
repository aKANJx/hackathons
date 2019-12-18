//
//  ViewController.swift
//  Saiga
//
//  Created by Bruno Faganello Neto on 25/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import DTMHeatmap
import TagListView

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var collectionView: UICollectionView!
    var cellTags = [0: ["Escola", "Hospital", "Metrô", "Igreja", "Evento"],
                    1: ["Ponto ônibus", "Museu"],
                    2: ["Vestibular", "Zoologico", "Parque diversões"],
                    3: ["Campo esportivo"],
                    4: ["Ponto ônibus", "Igreja", "Museu"]]
    
    var locationManager = CLLocationManager()
    var points = Point.fetchAll()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createLocation()
        mapView.showsUserLocation = true
        self.configHeatMap()
        
        for point in points{
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longiute)
            annotation.title = point.name
            mapView.addAnnotation(annotation)
        }
        
        mapView.delegate = self
        mapView.showsCompass = false
        mapView.showsTraffic = false
        mapView.showsBuildings = false
        mapView.isRotateEnabled = false
        centerMapOnUser()
        self.updateMapCollection()
    }

    func updateMapCollection() {
        self.collectionView.center = CGPoint(x: self.collectionView.center.x, y: self.collectionView.center.y+500)
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseInOut, animations: {
            self.collectionView.center = CGPoint(x: self.collectionView.center.x, y: self.collectionView.center.y-500)
        }, completion: nil)
    }
    
    func configHeatMap() {
        let heatmap = DTMHeatmap()
        let data = self.generateData()
        heatmap.setData(data)
        self.mapView.add(heatmap)
    }
    
    func generateData() -> [AnyHashable: Any] {
        var data = [AnyHashable: Any]()
        let path = Bundle.main.path(forResource: "heatmapdata", ofType: "txt")
        let content = try! String(contentsOfFile: path!, encoding: .utf8)
        let lines = content.components(separatedBy: "\n")
        for line in lines {
            guard line != "" else {
                continue
            }
            let parts = line.components(separatedBy: ",")
            let lat = Double(parts[0])
            let long = Double(parts[1])
            let weight = 1.0
            let location = CLLocation(latitude: lat!, longitude: long!)
            var point = MKMapPointForCoordinate(location.coordinate)
            let type = NSValue(mkCoordinate: location.coordinate).objCType
            let pointValue = NSValue(&point, withObjCType: type)
            data[pointValue] = weight
        }
        return data
    }
    
    @IBAction func goToPressed(_ sender: UIButton) {
        let latitude:Double = -23.588765
        let longitude:Double = -46.688070
        let link:String = "waze://"
        let url:URL = URL(string: link)!
        if UIApplication.shared.canOpenURL(url) {
            let urlStr:NSString = NSString(format: "waze://?ll=%f,%f&navigate=yes",latitude, longitude)
            UIApplication.shared.openURL(URL(string: urlStr as String)!)
        }
    }
}

extension MapViewController:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return DTMHeatmapRenderer(overlay: overlay)
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {        
        
    }
}

extension MapViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {}
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading){}
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
    
    private func createLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func centerMapOnUser(){
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation, 1000, 1000)
            mapView.setRegion(viewRegion, animated: false)
        }
    }
}



extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row != 0 else {
        self.centerMapOnUser()
        return
        }
        let viewRegion = MKCoordinateRegionMakeWithDistance(self.points[indexPath.row-1].coordinate, 1000, 1000)
        mapView.setRegion(viewRegion, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.points.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as! MapCell
        cell.myLocationLabel.isHidden = (indexPath.row >= 1)
        cell.goToButton.isHidden = !(indexPath.row >= 1)
        cell.popCorn.text = "\(Int(arc4random_uniform(6) + 1))"
        cell.corn.text = "\(Int(arc4random_uniform(6) + 1))"
        cell.drink.text = "\(Int(arc4random_uniform(6) + 1))"
        cell.tagListView.addTags(self.cellTags[indexPath.row]!)
        let lower : UInt32 = 20
        let upper : UInt32 = 100
        let randomNumber = arc4random_uniform(upper - lower) + lower
        cell.money.text = "Ganho médio: R$\(randomNumber),00/hora"
        
        return cell
    }
}
