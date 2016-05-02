//
//  Services.swift
//  Airport
//
//  Created by RUBING MAO on 4/29/16.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import UIKit

class Service {
    
    var name = ""
    var description = ""
    var location = ""
    var featuredImage: UIImage!
    
    init (name: String, description: String, featuredImage: UIImage!){
        self.name=name
        self.description=description
        self.featuredImage=featuredImage
    }
    
    static func createServices() -> [Service]{
        
        return[
            Service(name: "Restaurant", description: "Place to eat", featuredImage: UIImage(named: "helsinki_airport_arctic_bar_5")!),
            Service(name: "Shops", description: "Shopping", featuredImage: UIImage(named: "helsinki_airport_burberry_5")!),
            Service(name: "Smoking Room", description: "Smoking Area", featuredImage: UIImage(named: "Helsinki_smoking_room_G36")!)
//            Service(name: "", description: "", featuredImage: UIImage(named: "")!),
//            Service(name: "", description: "", featuredImage: UIImage(named: "")!),
//            Service(name: "", description: "", featuredImage: UIImage(named: "")!),
        ]
    }
}

