//
//  SecurityViewController.swift
//  Airport
//
//  Created by RUBING MAO on 4/21/16.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import Foundation
import UIKit

class SecurityViewController : UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidAppear(animated: Bool) {
        
        webView.allowsInlineMediaPlayback = true
            
        let youtubeUrl = "https://www.youtube.com/embed/s6-fO0iwbjQ"
            
        webView.loadHTMLString("<iframe width=\"\(webView.frame.width)\" height=\"\(webView.frame.height)\" src=\"\(youtubeUrl)?playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        
    }
    

}