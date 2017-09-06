//
//  MapController.swift
//  Uber Chef
//
//  Created by Aleksander Stefanovic on 2017-09-05.
//  Copyright © 2017 Aleksander Stefanovic. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        startMap(manager: locationManager);
    }
    
    func startMap(manager: CLLocationManager) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        let initialLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        
        let regionRadius: CLLocationDistance = 3000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
                    regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let gordon = MapMarker(title: "Gordon Ramsay",
                              locationName: "Ready to help for all your foodie needs!",
                              discipline: "Chef",
                              coordinate: CLLocationCoordinate2D(latitude: 37.792961, longitude: -122.413175))
        let heston = MapMarker(title: "Heston Blumenthal",
                             locationName: "Ready to help for all your foodie needs!",
                             discipline: "Chef",
                             coordinate: CLLocationCoordinate2D(latitude: 37.803962, longitude: -122.403175))
        let massimo = MapMarker(title: "Massimo Bottura",
                             locationName: "Ready to help for all your foodie needs!",
                             discipline: "Chef",
                             coordinate: CLLocationCoordinate2D(latitude: 37.782963, longitude: -122.433175))
        let rene = MapMarker(title: "René Redzepi",
                             locationName: "Ready to help for all your foodie needs!",
                             discipline: "Chef",
                             coordinate: CLLocationCoordinate2D(latitude: 37.772964, longitude: -122.393175))
        
        mapView.addAnnotation(gordon)
        mapView.addAnnotation(heston)
        mapView.addAnnotation(massimo)
        mapView.addAnnotation(rene)

    }
}
