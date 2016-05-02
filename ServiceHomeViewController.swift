//
//  ServiceHomeViewController.swift
//  Airport
//
//  Created by RUBING MAO on 4/29/16.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import Foundation
import UIKit

// Mark : Try to display the services with collectionView controller -> currently, it displays with a tableView
class ServiceHomeViewController: UIViewController {
    
    //Mark: IBOutlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //@IBOutlet weak var currentImageButton: UIButton!
    
    //Mark: UICollectionViewDataSource
    private var services = Service.createServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    private struct Storyboard {
        static let CellIdentifier = "Service Cell"
    }
}

extension ServiceHomeViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! ServiceCollectionViewCell
        
        cell.service = services[indexPath.item]
        
        return cell
    }
}