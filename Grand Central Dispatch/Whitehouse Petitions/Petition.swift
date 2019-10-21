//
//  Petition.swift
//  Whitehouse Petitions
//
//  Created by Felix Lin on 10/15/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
