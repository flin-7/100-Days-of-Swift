//
//  Photo.swift
//  Milestone 4
//
//  Created by Felix Lin on 11/5/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import Foundation

class Photo: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
