//
//  AboutBusItViewController.swift
//  BusIt
//
//  Created by Raquel Abrams on 2/22/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class AboutBusItViewController: UIViewController {
    
    
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        ScrollView.contentSize.height = 1200;
        
    }
    
    

}
