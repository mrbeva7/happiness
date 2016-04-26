//
//  MapViewController.swift
//  Airport
//
//  Created by RUBING MAO on 4/26/16.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import Foundation
import UIKit

class MapViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = UIImage (named: "skybg.jpg")
        let entireScreen = UIScreen.mainScreen().bounds
        background?.drawInRect(entireScreen)
        
        //draw image
        // let location = CGPointMake(10, 10)
        // background?.drawAtPoint(location)
        
        
        
    }
    
}