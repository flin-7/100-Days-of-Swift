//
//  Helper.swift
//  Milestone 4
//
//  Created by Felix Lin on 11/5/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import Foundation

class Helper {
    
    public static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
