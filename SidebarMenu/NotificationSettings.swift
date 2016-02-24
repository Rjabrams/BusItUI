//
//  BusInfoWindow.swift
//  SidebarMenu
//
//  Created by Ivan Alvarado on 1/20/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import MapKit

// NotificationSettings Class to hold user's NotificationSettings values
class NotificationSettings {
    var busType = ""
    var busDirec = ""
    var numStops: Int = 0
    var setNotification = false
    var stopLat: Double = 0.0
    var stopLng: Double = 0.0
    var listIndex: Int = 0
}