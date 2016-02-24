//
//  MapViewController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import MapKit

var dummyPoint = MKPointAnnotation()

class MapViewController: UIViewController, NSXMLParserDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nextBusLabel: UILabel!
    @IBOutlet weak var etaLabel: UILabel!
    @IBOutlet weak var nextStopLabel: UILabel!
    var listBuses = [Bus]()
    var parser = NSXMLParser()
    var timer  = NSTimer()
    var pushTimer = NSTimer()
    let currentUser = NotificationSettings()
    var cwBusStopList  = [BusStop]()  // Clockwise Bus Stops
    var ccwBusStopList = [BusStop]()  // Counter Clockwise Bus Stops
    var locationManager: CLLocationManager! // A reference to the location manager
    var userLocation: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        // Ask for user's location, display location, and update location
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            userLocation = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
            print("user location: \(userLocation.coordinate)")
        }
        
        
        
        
        // Make hamburger icon clickable
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Center opening map to UC Santa Cruz and set pin
        let location = CLLocationCoordinate2D(latitude: 36.9900, longitude: -122.0605)
        let span = MKCoordinateSpanMake(0.03, 0.03)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        
        // Bus Stops ------------------------------------------------------------------------------------------
        
        // - CounterClockwise ---------------------------------------------------------------------------------
        
        // Main Entrance, Outer
        let ccwLocation0 = CLLocationCoordinate2D(latitude: 36.977654, longitude: -122.053599)
        let ccwBusStop0 = BusStop(title: "Main Entrance (Outer)", subtitle: "0", coordinate: ccwLocation0, info: "CounterClockwise", listIndex: 0, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop0)
        ccwBusStopList.append(ccwBusStop0)
        
        // Lower Campus, Outer
        let ccwLocation1 = CLLocationCoordinate2D(latitude: 36.981430, longitude: -122.051962)
        let ccwBusStop1 = BusStop(title: "Lower Campus (Outer)", subtitle: "1", coordinate: ccwLocation1, info: "CounterClockwise",
            listIndex: 1, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop1)
        ccwBusStopList.append(ccwBusStop1)
        
        // Lower Quarry, Outer
        let ccwLocation2 = CLLocationCoordinate2D(latitude: 36.985851, longitude: -122.053511)
        let ccwBusStop2 = BusStop(title: "Lower Quarry Rd. (Outer)", subtitle: "2", coordinate: ccwLocation2, info: "CounterClockwise", listIndex: 2, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop2)
        ccwBusStopList.append(ccwBusStop2)
        
        // East Remote Parking Lot, Outer
        let ccwLocation3 = CLLocationCoordinate2D(latitude: 36.991276, longitude: -122.054696)
        let ccwBusStop3 = BusStop(title: "East Remote Parking Lot (Outer)", subtitle: "3", coordinate: ccwLocation3, info: "CounterClockwise", listIndex: 3, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop3)
        ccwBusStopList.append(ccwBusStop3)
        
        // East Field House, Outer
        let ccwLocation4 = CLLocationCoordinate2D(latitude: 36.994220, longitude: -122.055522)
        let ccwBusStop4 = BusStop(title: "East Field House (Outer)", subtitle: "4", coordinate: ccwLocation4, info: "CounterClockwise", listIndex: 4, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop4)
        ccwBusStopList.append(ccwBusStop4)
        
        // Bookstore, Outer
        let ccwLocation5 = CLLocationCoordinate2D(latitude: 36.997455, longitude: -122.055066)
        let ccwBusStop5 = BusStop(title: "Bookstore (Outer)", subtitle: "5", coordinate: ccwLocation5, info: "CounterClockwise",
            listIndex: 5, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop5)
        ccwBusStopList.append(ccwBusStop5)
        
        // Crown College, Outer
        let ccwLocation6 = CLLocationCoordinate2D(latitude: 36.999009, longitude: -122.055230)
        let ccwBusStop6 = BusStop(title: "Crown College (Outer)", subtitle: "6", coordinate: ccwLocation6, info: "CounterClockwise", listIndex: 6, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop6)
        ccwBusStopList.append(ccwBusStop6)
        
        // College 9/10, Outer
        let ccwLocation7 = CLLocationCoordinate2D(latitude: 36.999901, longitude: -122.058372)
        let ccwBusStop7 = BusStop(title: "College 9/10 (Outer)", subtitle: "7", coordinate: ccwLocation7, info: "CounterClockwise", listIndex: 7, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop7)
        ccwBusStopList.append(ccwBusStop7)
        
        // Science Hill, Outer
        let ccwLocation8 = CLLocationCoordinate2D(latitude: 36.999913, longitude: -122.062371)
        let ccwBusStop8 = BusStop(title: "Science Hill (Outer)", subtitle: "8", coordinate: ccwLocation8, info: "CounterClockwise", listIndex: 8, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop8)
        ccwBusStopList.append(ccwBusStop8)
        
        // Kresge College, Outer
        let ccwLocation9 = CLLocationCoordinate2D(latitude: 36.999225, longitude:  -122.064522)
        let ccwBusStop9 = BusStop(title: "Kresge College (Outer)", subtitle: "9", coordinate: ccwLocation9, info: "CounterClockwise", listIndex: 9, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop9)
        ccwBusStopList.append(ccwBusStop9)
        
        // College 8/Porter, Outer
        let ccwLocation10 = CLLocationCoordinate2D(latitude: 36.993011, longitude: -122.065332)
        let ccwBusStop10 = BusStop(title: "College 8/Porter (Outer)", subtitle: "10", coordinate: ccwLocation10, info: "CounterClockwise", listIndex: 10, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop10)
        ccwBusStopList.append(ccwBusStop10)
        
        // Family Student Housing, Outer
        let ccwLocation11 = CLLocationCoordinate2D(latitude: 36.991710, longitude: -122.066808)
        let ccwBusStop11 = BusStop(title: "Family Student Housing (Outer)", subtitle: "11", coordinate: ccwLocation11, info: "CounterClockwise", listIndex: 11, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop11)
        ccwBusStopList.append(ccwBusStop11)
        
        // Oakes College, Outer
        let ccwLocation12 = CLLocationCoordinate2D(latitude: 36.989923, longitude: -122.067298)
        let ccwBusStop12 = BusStop(title: "Oakes College (Outer)", subtitle: "12", coordinate: ccwLocation12, info: "CounterClockwise", listIndex: 12, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop12)
        ccwBusStopList.append(ccwBusStop12)
        
        // Arboretum, Outer
        let ccwLocation13 = CLLocationCoordinate2D(latitude: 36.983681, longitude: -122.065073)
        let ccwBusStop13 = BusStop(title: "Arboretum (Outer)", subtitle: "13", coordinate: ccwLocation13, info: "CounterClockwise", listIndex: 13, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop13)
        ccwBusStopList.append(ccwBusStop13)
        
        // Tosca Terrace, Outer
        let ccwLocation14 = CLLocationCoordinate2D(latitude: 36.979882, longitude: -122.059269)
        let ccwBusStop14 = BusStop(title: "Tosca Terrace (Outer)", subtitle: "14", coordinate: ccwLocation14, info: "CounterClockwise", listIndex: 14, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop14)
        ccwBusStopList.append(ccwBusStop14)
        
        // Western Dr., Outer
        let ccwLocation15 = CLLocationCoordinate2D(latitude: 36.978658, longitude: -122.057826)
        let ccwBusStop15 = BusStop(title: "Western Dr. (Outer)", subtitle: "15", coordinate: ccwLocation15, info: "CounterClockwise", listIndex: 15, imageName: "bustopouter.png")
        mapView.addAnnotation(ccwBusStop15)
        ccwBusStopList.append(ccwBusStop15)
        
        // - Clockwise ----------------------------------------------------------------------------------------
        
        // Barn Theater, Inner
        let cwLocation0 = CLLocationCoordinate2D(latitude: 36.977317, longitude: -122.054255)
        let cwBusStop0 = BusStop(title: "Barn Theater (Inner)", subtitle: "0", coordinate: cwLocation0, info: "Clockwise", listIndex: 0, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop0)
        cwBusStopList.append(cwBusStop0)
        
        // Western Dr., Inner
        let cwLocation1 = CLLocationCoordinate2D(latitude: 36.978753, longitude: -122.057694)
        let cwBusStop1 = BusStop(title: "Western Dr. (Inner)", subtitle: "1", coordinate: cwLocation1, info: "Clockwise", listIndex: 1, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop1)
        cwBusStopList.append(cwBusStop1)
        
        // Arboretum, Inner
        let cwLocation2 = CLLocationCoordinate2D(latitude: 36.982729, longitude: -122.062573)
        let cwBusStop2 = BusStop(title: "Arboretum (Inner)", subtitle: "2", coordinate: cwLocation2, info: "Clockwise", listIndex: 2, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop2)
        cwBusStopList.append(cwBusStop2)
        
        // Oakes College, Inner
        let cwLocation3 = CLLocationCoordinate2D(latitude: 36.990675, longitude: -122.066070)
        let cwBusStop3 = BusStop(title: "Oakes College (Inner)", subtitle: "3", coordinate: cwLocation3, info: "Clockwise", listIndex: 3, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop3)
        cwBusStopList.append(cwBusStop3)
        
        // College 8/Porter, Inner
        let cwLocation4 = CLLocationCoordinate2D(latitude: 36.992781, longitude: -122.064729)
        let cwBusStop4 = BusStop(title: "College 8/Porter (Inner)", subtitle: "4", coordinate: cwLocation4, info: "Clockwise", listIndex: 4, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop4)
        cwBusStopList.append(cwBusStop4)
        
        // Kerr Hall, Inner
        let cwLocation5 = CLLocationCoordinate2D(latitude: 36.996736, longitude: -122.063586)
        let cwBusStop5 = BusStop(title: "Kerr Hall (Inner)", subtitle: "5", coordinate: cwLocation5, info: "Clockwise", listIndex: 5, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop5)
        cwBusStopList.append(cwBusStop5)
        
        // Kresge College, Inner
        let cwLocation6 = CLLocationCoordinate2D(latitude: 36.999198,longitude: -122.064371)
        let cwBusStop6 = BusStop(title: "Kresge College (Inner)", subtitle: "6", coordinate: cwLocation6, info: "Clockwise", listIndex: 6, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop6)
        cwBusStopList.append(cwBusStop6)
        
        // Science Hill, Inner
        let cwLocation7 = CLLocationCoordinate2D(latitude: 36.999809, longitude: -122.062068)
        let cwBusStop7 = BusStop(title: "Science Hill (Inner)", subtitle: "7", coordinate: cwLocation7, info: "Clockwise", listIndex: 7, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop7)
        cwBusStopList.append(cwBusStop7)
        
        // McLaughlin & College 9/10, Inner
        let cwLocation8 = CLLocationCoordinate2D(latitude: 36.999719, longitude: -122.058393)
        let cwBusStop8 = BusStop(title: "College 9/10 (Inner)", subtitle: "8", coordinate: cwLocation8, info: "Clockwise", listIndex: 8, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop8)
        cwBusStopList.append(cwBusStop8)
        
        // Bookstore, Inner
        let cwLocation9 = CLLocationCoordinate2D(latitude: 36.996636, longitude: -122.055431)
        let cwBusStop9 = BusStop(title: "Bookstore (Inner)", subtitle: "9", coordinate: cwLocation9, info: "Clockwise", listIndex: 9, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop9)
        cwBusStopList.append(cwBusStop9)
        
        // East Remote Parking Lot, Inner
        let cwLocation10 = CLLocationCoordinate2D(latitude: 36.991263, longitude: -122.054873)
        let cwBusStop10 = BusStop(title: "East Remote Parking Lot (Inner)", subtitle: "10", coordinate: cwLocation10, info: "Clockwise", listIndex: 10, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop10)
        cwBusStopList.append(cwBusStop10)
        
        // Lower Quarry, Inner
        let cwLocation11 = CLLocationCoordinate2D(latitude: 36.985438, longitude: -122.053505)
        let cwBusStop11 = BusStop(title: "Lower Quarry Rd. (Inner)", subtitle: "11", coordinate: cwLocation11, info: "Clockwise", listIndex: 11, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop11)
        cwBusStopList.append(cwBusStop11)
        
        // Lower Campus, Inner
        let cwLocation12 = CLLocationCoordinate2D(latitude: 36.981535, longitude: -122.052068)
        let cwBusStop12 = BusStop(title: "Lower Campus (Inner)", subtitle: "12", coordinate: cwLocation12, info: "Clockwise", listIndex: 12, imageName: "bustopinner.png")
        mapView.addAnnotation(cwBusStop12)
        cwBusStopList.append(cwBusStop12)
        
        // End Bus Stops --------------------------------------------------------------------------------------
        
        let closestBusStopToUser = getClosestBusStop()
        
        // Parse XML file and build Marker objects
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://skynet.cse.ucsc.edu/bts/coord2.xml"))!)!
        let coord = Coord2()
        parser.delegate = coord
        parser.parse()
        print("coord has a count attribute of \(coord.count)")
        print("coord has \(coord.markers.count) markers")
        
        var i = 0
        for marker in coord.markers {
            // Append bus to Global Bus Obj List and add Annotation to Map
            let newMarker = MKPointAnnotation()
            newMarker.coordinate = CLLocationCoordinate2D(latitude: marker.lati, longitude: marker.lngi)
            newMarker.title = marker.route
            newMarker.subtitle = marker.direc
            if (newMarker.title == "Upper Campus") {
                listBuses.append(Bus(title: marker.route, id: marker.id, direc: marker.direc, exists: true, pin: newMarker, imageName: "ucsclogo.png"))
            mapView.addAnnotation(listBuses[i].pin)
            i++
            } else {
                listBuses.append(Bus(title: marker.route, id: marker.id, direc: marker.direc, exists: true, pin: newMarker, imageName: "calendar.png"))
                mapView.addAnnotation(listBuses[i].pin)
                i++
            }
        }
        
        // Get closest bus to closest bus stop to user with shortest eta
        if listBuses.count > 0 {
            var minETA = 100000
            
            for bus in listBuses {
                calculateETAofClosestBus(bus, destination: closestBusStopToUser) { (eta: Int) -> Void in
                    if eta < minETA {
                        minETA = eta
                        self.nextBusLabel.text = bus.title + " (" + bus.direc + ")"
                        self.nextStopLabel.text = closestBusStopToUser.title
                        self.etaLabel.text = "\(eta/60) min \(eta%60) sec"
                    }
                    
                }
            }
            
        }
        
        // Run reloadBuses() every 10 seconds
        timer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: "reloadBuses", userInfo: nil, repeats: true)

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
    }
    
    // Function that calculates the the ETA of the closest Bus to user's closest Bus stop
    func calculateETAofClosestBus(source: Bus, destination: BusStop, result: (eta: Int) -> Void) {
        var eta = 0

        var request = MKDirectionsRequest()
        var sourceItem = MKMapItem(placemark: MKPlacemark(coordinate: source.pin.coordinate, addressDictionary: nil))
        request.source = sourceItem
        request.transportType = .Automobile
        let destinationCoordinates = CLLocationCoordinate2D(latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude)
        let destinationItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinates, addressDictionary: nil))
        request.destination = destinationItem
        request.requestsAlternateRoutes = false
        var directions = MKDirections(request: request)
        
        directions.calculateETAWithCompletionHandler { (etaResponse, error) -> Void in
            if let error = error {
                print("Error while requesting ETA : \(error.localizedDescription)")
            } else {
                eta = Int((etaResponse?.expectedTravelTime)!)
                result(eta: eta)
                //print("\(Int((etaResponse?.expectedTravelTime)!/60)) min \(Int((etaResponse?.expectedTravelTime)!%60)) sec")
            }
        }
        
    }
    
    // Return the closest bus stop to user
    func getClosestBusStop() -> BusStop {
        
        let userLocationCoordinates = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        // Assign a dummy value
        var closestStop = cwBusStopList[0]
        let firstStopCoordinates = CLLocation(latitude: cwBusStopList[0].coordinate.latitude, longitude: cwBusStopList[0].coordinate.longitude)
        // Assign a dummy to minDistance
        var minDistance = userLocationCoordinates.distanceFromLocation(firstStopCoordinates)
        
        for stop in cwBusStopList {
            let currentStop = CLLocation(latitude: stop.coordinate.latitude, longitude: stop.coordinate.longitude)
            if userLocationCoordinates.distanceFromLocation(currentStop) < minDistance {
                minDistance = userLocationCoordinates.distanceFromLocation(currentStop)
                closestStop = stop
            }
        }
        
        for stop in ccwBusStopList {
            let currentStop = CLLocation(latitude: stop.coordinate.latitude, longitude: stop.coordinate.longitude)
            if userLocationCoordinates.distanceFromLocation(currentStop) < minDistance {
                minDistance = userLocationCoordinates.distanceFromLocation(currentStop)
                closestStop = stop
            }
        }
        
        return closestStop
        
    }
    
    // Function that continuously updates bus marker locations on map
    func reloadBuses() {
        
        // Print values set by BusStopSettingsVC
        print(currentUser.busType)
        print(currentUser.busDirec)
        print(currentUser.numStops)
        print(currentUser.setNotification)
        
        // Assume that no Buses exist
        for buses in listBuses {
            buses.exists = false
        }
        
        // Parse XML file and build Marker Objects
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://skynet.cse.ucsc.edu/bts/coord2.xml"))!)!
        let coord = Coord2()
        parser.delegate = coord
        parser.parse()
        print("coord has a count attribute of \(coord.count)")
        print("coord has \(coord.markers.count) markers")
        print("listBuses after coord has \(listBuses.count)")
        
        var listBusesCount: Int
        // Cross reference global listBuses w/ actual buses from XML
        for marker in coord.markers {
            
            if currentUser.setNotification { isBusInRadius(marker) }
            
            listBusesCount = -1
            for newBus in listBuses {
                listBusesCount++
                if marker.id == newBus.id {
                    newBus.exists = true
                    newBus.pin.coordinate = CLLocationCoordinate2D(latitude: marker.lati, longitude: marker.lngi)
                    break
                }
                // If we've reached the end of listBuses w/o matching a bus ID
                // this is a new bus, so append it to listBuses and add to Map
                if listBusesCount == (listBuses.count - 1) {
                    var newBusToAppend = MKPointAnnotation()
                    newBusToAppend.coordinate = CLLocationCoordinate2D(latitude: marker.lati, longitude: marker.lngi)
                    newBusToAppend.title = marker.route
                    newBusToAppend.subtitle = marker.direc
                    if (newBusToAppend.title == "Upper Campus") {
                        listBuses.append(Bus(title: marker.route, id: marker.id, direc: marker.direc, exists: true, pin: newBusToAppend, imageName: "ucsclogo.png"))
                    mapView.addAnnotation(newBusToAppend)
                    } else {
                        listBuses.append(Bus(title: marker.route, id: marker.id, direc: marker.direc, exists: true, pin: newBusToAppend, imageName: "calendar.png"))
                        mapView.addAnnotation(newBusToAppend)
                    }
                }
            }
        }
         let closestBusStopToUser = getClosestBusStop()
        // Get closest bus to closest bus stop to user with shortest eta
        if listBuses.count > 0 {
            var minETA = 100000
            
            for bus in listBuses {
                calculateETAofClosestBus(bus, destination: closestBusStopToUser) { (eta: Int) -> Void in
                    if eta < minETA {
                        minETA = eta
                        self.nextBusLabel.text = bus.title + " (" + bus.direc + ")"
                        self.nextStopLabel.text = closestBusStopToUser.title
                        self.etaLabel.text = "\(eta/60) min \(eta%60) sec"
                    }
                    
                }
            }
            
        }
        
        removeInactiveBuses()
        
    }
    
    // Remove Buses that have gone offline
    func removeInactiveBuses() {
        print("listBuses has \(listBuses.count)")
        var i = 0
        for bus in listBuses {
            if !bus.exists {
                mapView.removeAnnotation(listBuses[i].pin)
                listBuses.removeAtIndex(i)
            }
            i++
        }
    }
    
    // Searches for a bus in user specified zone
    func isBusInRadius(bus: Marker) {

        let busLocation = CLLocation(latitude: bus.lati, longitude: bus.lngi)
        var stopLocation = CLLocation(latitude: 0, longitude: 0)
        var delta = 101.0
        
        let CurrentStopIndex = currentUser.listIndex
        let numStop = currentUser.numStops
        
        var DesiredStopIndex = CurrentStopIndex - numStop
        //Check to see if User chosen bus type is the same as the bus in radius
        if (currentUser.busDirec == bus.direc) {
            //Chceck to see if the direction of the bus is the same
            if (currentUser.busDirec == "inner") {
                //If the Desired bus stop index is below 0, minus the index from the total number of bus stops
                if (DesiredStopIndex < 0) {
                    DesiredStopIndex = cwBusStopList.count + DesiredStopIndex
                    //Update stopLocation to store the new stop location information
                    stopLocation = CLLocation(latitude: cwBusStopList[DesiredStopIndex].coordinate.latitude, longitude: cwBusStopList[DesiredStopIndex].coordinate.longitude)
                    //Calculate the distance
                    delta = stopLocation.distanceFromLocation(busLocation)
                    
                } else {
                    
                    stopLocation = CLLocation(latitude: cwBusStopList[DesiredStopIndex].coordinate.latitude, longitude: cwBusStopList[DesiredStopIndex].coordinate.longitude)
                    delta = stopLocation.distanceFromLocation(busLocation)
                    
                }
                
            } else if (currentUser.busDirec == "outer"){
                if (DesiredStopIndex < 0) {
                    DesiredStopIndex = ccwBusStopList.count + DesiredStopIndex
                    //update stopLocation or create a new variable to store the new stop location information
                    stopLocation = CLLocation(latitude: ccwBusStopList[DesiredStopIndex].coordinate.latitude, longitude: ccwBusStopList[DesiredStopIndex].coordinate.longitude)
                    delta = stopLocation.distanceFromLocation(busLocation)
                    
                } else {
                    
                    stopLocation = CLLocation(latitude: ccwBusStopList[DesiredStopIndex].coordinate.latitude, longitude: ccwBusStopList[DesiredStopIndex].coordinate.longitude)
                    delta = stopLocation.distanceFromLocation(busLocation)
                }
            }
        }
        
        //let delta = stopLocation.distanceFromLocation(busLocation)
        
        // If bus is within 100m of bus stop
        if delta < 100 {
    
            // Send alert to user if app is open
            if (numStop == 1) {
                let alertView = UIAlertController(title: "Your bus is 1 stop away!", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertView, animated: true, completion: nil)
            } else {
                let alertView = UIAlertController(title: "Your bus is \(numStop) stops away!", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertView, animated: true, completion: nil)
            }
            
            // Send user a push notification if they have the app running in the bg
            pushTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("pushNotification"), userInfo: nil, repeats: false)
            currentUser.setNotification = false
            if (currentUser.busType == bus.route) && (currentUser.busDirec == bus.direc) {
                
            }
        }
    }
    
    // Send user a push notification if they have the app running in the bg
    func pushNotification() {

        let notification = UILocalNotification()
        if (currentUser.numStops == 1){
            notification.alertAction = "Go back to App"
            notification.alertBody = "Your Bus is 1 Stop Away!"
            notification.fireDate = NSDate(timeIntervalSinceNow: 1)
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            
        } else {
        notification.alertAction = "Go back to App"
        notification.alertBody = "Your Bus is \(currentUser.numStops) Stops Away!"
        notification.fireDate = NSDate(timeIntervalSinceNow: 1)
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    // Customize Annotations and Callout
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        let identifier = "BusStop"

        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        
        if annotation.isKindOfClass(BusStop.self) {
            
            if annotationView == nil {
                    // Check if annotation has custom image
                        let reuseId = "BusStop"
                        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                        annotationView!.canShowCallout = true
                        let btn = UIButton(type: .DetailDisclosure)
                        annotationView!.rightCalloutAccessoryView = btn

                
            } else {
                annotationView!.annotation = annotation
            }
            let cpa = annotation as! BusStop
            annotationView!.image = UIImage(named:cpa.imageName)
            annotationView!.frame.size = CGSize(width: 35, height: 35)
            annotationView!.canShowCallout = true
            let btn = UIButton(type: .DetailDisclosure)
            annotationView!.rightCalloutAccessoryView = btn
            return annotationView
        }
        
        return nil
    }
    
    // When righCalloutAccessoryView is tapped, segue through newView to BusStopSettingsVC
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.performSegueWithIdentifier("newView", sender: view)
    }
    
    // Pass data through newView to BusStopSettingsVC
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "newView") {
            // pass data to next view
            let destViewController:BusStopSettingsViewController = segue.destinationViewController as! BusStopSettingsViewController
            destViewController.viaSegue = sender as! MKAnnotationView
            destViewController.currentUser = currentUser
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// ParseBase class
// simple base class that is used to consume foundCharacters
// via the parser
class ParserBase : NSObject, NSXMLParserDelegate  {
    
    var currentElement:String = ""
    var foundCharacters = ""
    weak var parent:ParserBase? = nil
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        currentElement = elementName
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        self.foundCharacters = string
    }
    
} // End of MapViewController Class

// Coord2 class
// represents a coord2 tag
// it has a count attribute
// and a collection of markers
class Coord2 : ParserBase {
    
    var count = 0
    var markers = [Marker]()
    
    // didStartElement()
    override func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        //print("processing <\(elementName)> tag from Coord")
        
        if elementName == "coord2" {
            
            // if we are processing a coord2 tag, we are at the root
            // of XML file, extract the count value and set it
            print(attributeDict["count"])
            if let c = Int(attributeDict["count"]!) {
                self.count = c
            }
        }
        
        // if we found a marker tag, delegate further responsibility
        // to parsing to a new instance of Marker
        if elementName == "marker" {
            let marker = Marker()
            self.markers.append(marker)
            
            // push responsibility
            parser.delegate = marker
            
            // let marker know who we are
            // so that once marker is done XML processing
            // it can return parsing responsibility back
            marker.parent = self
        }
    }
}

// Marker class
class Marker : ParserBase {
    
    var id = ""
    var lat = ""
    var lng = ""
    var route = ""
    var direc = ""
    var lati = 0.0
    var lngi = 0.0
    
    // didEndElement()
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        //print("processing <\(elementName)> tag from Marker")
        
        // if we finished an item tag, the ParserBase parent
        // would have accumulated the found characters
        // so just assign that to our item variable
        if elementName == "id" {
            self.id = foundCharacters
        }
            
            // convert the lat to a Double
        else if elementName == "lat" {
            self.lat = foundCharacters
            // cast self.lat as Double
            if let doubleFromlat = Double(self.lat) {
                self.lati = doubleFromlat
            } else { print("foundCharacters for lat does not hold double") }
            
        }
            
            // convert the lng to a Double
        else if elementName == "lng" {
            self.lng = foundCharacters
            if let doubleFromlng = Double(self.lng) {
                self.lngi = doubleFromlng
            } else { print("foundCharacters for lng does not hold double") }
        }
            
        else if elementName == "route" {
            self.route = foundCharacters
        }
            
        else if elementName == "direction" {
            self.direc = foundCharacters
        }
            
            // if we reached the </marker> tag, we do not
            // have anything further to do, so delegate
            // parsing responsibility to parent
        else if elementName == "marker" {
            parser.delegate = self.parent
        }
        
        // reset found characters
        foundCharacters = ""
    }
    
}
