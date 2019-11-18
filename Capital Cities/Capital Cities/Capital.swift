//
//  Capital.swift
//  Capital Cities
//
//  Created by Felix Lin on 11/17/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var urlString: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, urlString: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.urlString = urlString
    }
}
