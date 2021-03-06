//
//  MapVC.swift
//  PinApp
//
//  Created by Stefan Markovic on 10/2/17.
//  Copyright © 2017 Stefan Markovic. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {

    //MARK: - Variables
    @IBOutlet var mapView: MKMapView!
    var restaurant: RestaurantMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsCompass = true
        addAnnotation()
    }
    
    //MARK: - Add annotation and get pin location from address
    func addAnnotation() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location!) { (placemarks, error) in
            if error != nil {
                print(error.debugDescription)
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        }
    }
    
    //MARK: - Customize annotation to show title and image
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(data: restaurant.image!)
        leftIconView.contentMode = .scaleAspectFill
        leftIconView.clipsToBounds = true
        annotationView?.leftCalloutAccessoryView = leftIconView
        annotationView?.pinTintColor = UIColor.orange
        
        return annotationView
    }

 
    
    
    

}











