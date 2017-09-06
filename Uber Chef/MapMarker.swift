//
//  MapMarker.swift
//  Uber Chef
//
//  Created by Aleksander Stefanovic on 2017-09-05.
//  Copyright © 2017 Aleksander Stefanovic. All rights reserved.
//

import MapKit

class MapMarker: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
