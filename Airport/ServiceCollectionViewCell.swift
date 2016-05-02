//
//  ServiceCollectionViewCell.swift
//  Airport
//
//  Created by RUBING MAO on 5/1/16.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {
    
    var service: Service! {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    private func updateUI() {
        titleLabel?.text! = service.name
        featuredImageView?.image! = service.featuredImage
    }
}
