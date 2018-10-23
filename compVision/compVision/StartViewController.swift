//
//  StartViewController.swift
//  compVision
//
//  Created by Kaleb  on 10/22/18.
//  Copyright © 2018 CalebGrant. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // I wanna preload the next view controller so that
        // it won't be so slow when tapping the button
        // ViewController.load()  // < -- this code is useless
        _ = ViewController.self() // < -- ok this code works by forcing the
        // next view controller to load when this view loads
        
    }
    

    

}
