//
//  ViewController.swift
//  Capital Cities
//
//  Created by Felix Lin on 11/17/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map Style", style: .plain, target: self, action: #selector(chooseMap))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", urlString: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", urlString: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", urlString: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", urlString: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", urlString: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.pinTintColor = .yellow
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Wikipedia", style: .default, handler: { [weak self ] _ in
            if let url = URL(string: capital.urlString) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let vc = SFSafariViewController(url: url, configuration: config)
                self?.present(vc, animated: true)
            }
        }))
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func chooseMap() {
        let ac = UIAlertController(title: "Map Style", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: {  [weak self] _ in
            self?.mapView.mapType = .standard
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: {  [weak self] _ in
            self?.mapView.mapType = .hybrid
        }))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: {  [weak self] _ in
            self?.mapView.mapType = .satellite
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}

