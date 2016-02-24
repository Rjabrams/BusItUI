//
//  BusStopSettingsViewController.swift
//  SidebarMenu
//
//  Created by Ivan Alvarado on 1/23/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import MapKit

class BusStopSettingsViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var viaSegueLabe: UILabel!
    
    
    @IBOutlet weak var pickerViewBusType: UIPickerView!
    @IBOutlet weak var pickerViewDirec: UIPickerView!
    @IBOutlet weak var pickerViewNumStops: UIPickerView!
    
    var viaSegue: MKAnnotationView!
    var clickedAnnotationLat: Double!
    var clickedAnnotationLng: Double!
    @IBOutlet weak var notificationButton: UIButton!
    
    
    var busType = ["LOOP", "UPPER CAMPUS"]
    var busDirec = ["inner", "outer", "Any"]
    var numStops = [1, 2, 3]
    
    var currentUser: NotificationSettings!
    var busTypeChosen = ""
    var busDirecChosen = ""
    var numStopsChosen = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        busTypeChosen = busType[0]
        busDirecChosen = busDirec[0]
        numStopsChosen = numStops[0]
        currentUser.listIndex = Int(((viaSegue.annotation?.subtitle)!)!)!
        viaSegueLabe.text = (viaSegue.annotation?.title)!
        
        clickedAnnotationLat = viaSegue.annotation?.coordinate.latitude
        clickedAnnotationLng = viaSegue.annotation?.coordinate.longitude
        print(clickedAnnotationLat)
        
        // Give notification button distinct tag
        notificationButton.tag = 5
        notificationButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int  {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.pickerViewBusType {
            return busType.count
        } else if pickerView == self.pickerViewDirec {
            return busDirec.count
        } else if pickerView == self.pickerViewNumStops {
            return numStops.count
        }
        return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.pickerViewBusType {
            return busType[row]
        } else if pickerView == self.pickerViewDirec {
            return busDirec[row]
        } else if pickerView == self.pickerViewNumStops {
            return String(numStops[row])
        }
        return ""
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        if pickerView == self.pickerViewBusType {
            busTypeChosen = busType[row]
            viaSegueLabe.text = busType[row]
        } else if pickerView == self.pickerViewDirec {
            busDirecChosen = busDirec[row]
            if busDirecChosen == "Clockwise" {
                busDirecChosen = "inner"
            }
            if busDirecChosen == "CounterClockwise" {
                busDirecChosen = "outer"
            }
            viaSegueLabe.text = busDirecChosen
        } else if pickerView == self.pickerViewNumStops {
            numStopsChosen = numStops[row]
            viaSegueLabe.text = String(numStops[row])
        }
        
    }
    
    func buttonClicked(sender:UIButton) {
        if(sender.tag == 5){
            currentUser.busType = busTypeChosen
            currentUser.busDirec = busDirecChosen
            currentUser.numStops = numStopsChosen
            currentUser.stopLat = clickedAnnotationLat
            currentUser.stopLng = clickedAnnotationLng
            currentUser.setNotification = true
            let alertTitle = "Notification Set"
            let alertMessage = "for \(currentUser.numStops) stops before \(viaSegue.annotation?.title)"
            let ac = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
