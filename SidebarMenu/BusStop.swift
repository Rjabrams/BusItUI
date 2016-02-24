//
//  Capital.swift
//  SidebarMenu
//
//  Created by Ivan Alvarado on 1/20/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import MapKit
import UIKit

// Bus Stop Class for Bus Stop Objects
class BusStop: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var custom_image: Bool = true
    var listIndex: Int
    var imageName: String!
    
    
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, info: String, listIndex: Int, imageName: String!) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.info = info
        self.listIndex = listIndex
        self.imageName = imageName
    }
}

