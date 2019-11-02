//
//  Person.swift
//  Names to Faces
//
//  Created by Felix Lin on 10/25/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
