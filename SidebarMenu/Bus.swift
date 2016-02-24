//
//  Bus.swift
//  SidebarMenu
//
//  Created by Ivan Alvarado on 1/27/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import MapKit
import UIKit

// Bus Class for Bus Objects
class Bus {
    var title: String
    var id: String
    var direc: String
    var exists: Bool
    var pin: MKPointAnnotation
    var imageName: String!
    
    init(title: String, id: String, direc: String, exists: Bool, pin: MKPointAnnotation, imageName: String!) {
        self.title = title
        self.id = id
        self.direc = direc
        self.exists = exists
        self.pin = pin
        self.imageName = imageName
    }
    
}