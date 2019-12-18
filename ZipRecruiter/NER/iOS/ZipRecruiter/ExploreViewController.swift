//
//  ExploreViewController.swift
//  ZipRecruiter
//
//  Created by Jean Paul Marinho on 06/05/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import UserNotifications
import MapKit
import CoreLocation
import AudioToolbox

class ExploreViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var recruiterView: UIView!
    @IBOutlet weak var directionsView: UIView!
    
    let locationManager = CLLocationManager()
    var firstLocationAppeared = false
    var recruiters: [Recruiter]?
    var selectedRecruiter: Recruiter?
    
    @IBOutlet weak var recruiterCompany: UILabel!
    @IBOutlet weak var recruiterCompanyImage: UIImageView!
    @IBOutlet weak var recruiterPhoto: UIImageView!
    @IBOutlet weak var recruiterName: UILabel!
    @IBOutlet weak var recruiterCompanyDescription: UILabel!
    @IBOutlet weak var recruiterAbilities: UILabel!
    
    
    @IBOutlet weak var directionsPhoto: RoundedImageView!
    @IBOutlet weak var directionsName: UILabel!
    @IBOutlet weak var directionsCompany: UILabel!
    @IBOutlet weak var directionsCompanyImage: UIImageView!
    @IBOutlet weak var directionsTime: UILabel!
    @IBOutlet weak var directionsDistance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyLoadViewStyle(styleView: self.settingsView)
        self.applyLoadViewStyle(styleView: self.recruiterView)
        self.applyLoadViewStyle(styleView: self.directionsView)
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.loadRecruiters()
    }
    
    func applyLoadViewStyle(styleView: UIView) {
        styleView.layer.cornerRadius = 10
        styleView.layer.shadowColor = UIColor.black.cgColor
        styleView.layer.shadowOpacity = 0.2
        styleView.layer.shadowOffset = CGSize.zero
        styleView.layer.shadowRadius = 5
    }
    
    func loadRecruiters() {
        APIClient.getRecruiters { (recruiters) in
            self.recruiters = recruiters
            self.mapView.addAnnotations(self.recruiters!)
        }
    }
    
    @IBAction func notificationPressed(_ sender: UIButton) {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Let's get a job!"
        content.body = "A recruiter is approaching you. Touch to accept the meeting."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        let date = Date(timeIntervalSinceNow: 5)
        let dateComponents = Calendar.current.dateComponents([.year,.month,.day                    ,.hour,.minute,.second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    @IBAction func settingsPressed(_ sender: UIButton) {
        self.settingsButton.isHidden = true
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.settingsView.frame.origin.y = 30
        }) { (success) in
        }
    }
    
    @IBAction func doneSettingsPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.settingsView.frame.origin.y = -160
        }) { (success) in
            self.settingsButton.isHidden = false
        }
    }
    
    @IBAction func companyPressed(_ sender: UIButton) {
    }
    
    @IBAction func requestPressed(_ sender: UIButton) {
        APIClient.sendRequest { (error) in
            guard error == nil else {
                return
            }
            SweetAlert().showAlert("Good job!", subTitle: "Now you need to wait for approval from this recruiter", style: .success, buttonTitle: "Gotcha")
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            let content = UNMutableNotificationContent()
            content.title = "Let's get a job!"
            content.body = "Your request was accepted. Touch to get more information."
            content.categoryIdentifier = "alarm"
            content.userInfo = ["customData": "fizzbuzz"]
            content.sound = UNNotificationSound.default()
            let date = Date(timeIntervalSinceNow: 10)
            let dateComponents = Calendar.current.dateComponents([.year,.month,.day                    ,.hour,.minute,.second], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
    }
    
    func generateRoute() {
        let sourceLocation = self.mapView.userLocation.coordinate
        let destinationLocation = self.selectedRecruiter?.coordinate
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation!, addressDictionary: nil)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .walking
        let directions = MKDirections(request: directionRequest)
        directions.calculate {
            (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            let boundingRect = route.polyline.boundingMapRect
            let rect = MKMapRect(origin: boundingRect.origin, size: MKMapSize(width: boundingRect.size.width + 1000, height: boundingRect.size.height + 1000))
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    func loadInfo(recruiter: Recruiter) {
        self.recruiterName.text = recruiter.name
        self.recruiterCompany.text = recruiter.company
        self.recruiterPhoto.image = UIImage(named: recruiter.photoID!)
        self.recruiterAbilities.text = recruiter.abilities
        self.recruiterCompanyDescription.text = recruiter.companyDescription
        self.recruiterCompanyImage.image = UIImage(named: recruiter.companyImageID!)
    }
}



extension ExploreViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.selectedRecruiter = view.annotation as? Recruiter
        self.loadInfo(recruiter: self.selectedRecruiter!)
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.recruiterView.frame.origin.y = 550
        }) { (success) in
        }
        self.mapView.setRegion(MKCoordinateRegionMakeWithDistance((view.annotation?.coordinate)!, 1000, 1000), animated: true)
    }
    
//    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
//        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
//            self.recruiterView.frame.origin.y = 750
//        }) { (success) in
//        }
//    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 0.43, green: 0.78, blue: 0.34, alpha: 1)
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.image = UIImage(named: "Pin-recruiter")
        }
        
        return annotationView
    }
}



extension ExploreViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !self.firstLocationAppeared {
            self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(locations[0].coordinate, 1000, 1000), animated: true)
            self.firstLocationAppeared = true
        }
    }
}



extension ExploreViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotation(self.selectedRecruiter!)
        self.recruiterView.frame.origin.y = 750
        self.directionsView.frame.origin.y = 30
        self.generateRoute()
        self.directionsName.text = self.selectedRecruiter?.name
        self.directionsPhoto.image = UIImage(named: (self.selectedRecruiter?.photoID)!)
        self.directionsCompany.text = self.selectedRecruiter?.company
        self.directionsCompanyImage.image = UIImage(named: (self.selectedRecruiter?.companyImageID)!)
    }
}
