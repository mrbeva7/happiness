//
//  CheckInViewController.swift
//  Airport
//
//  Created by RUBING MAO on 4/21/16.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import Foundation
import UIKit

class CheckInViewController : UIViewController, UITextFieldDelegate {

    //video starts here
    @IBOutlet var webView: UIWebView!
    
    override func viewDidAppear(animated: Bool) {
        webView.allowsInlineMediaPlayback = true
        
        let youtubeUrl = "https://www.youtube.com/embed/J6c8Vhoc38E"
        
        print("\(webView.frame.width), \(webView.frame.height)")
        
        webView.loadHTMLString("<iframe width=\"\(webView.frame.width)\" height=\"\(webView.frame.height)\" src=\"\(youtubeUrl)?playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
    }
    
    
    //for input departure time
    @IBOutlet weak var departureTimeLabel: UILabel!
    
//    @IBOutlet weak var departureTimeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
//        departureTimeTextField.delegate = self
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        // Hide the keyboard.
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    func textFieldDidEndEditing(textField: UITextField) {
//        departureTimeLabel.text = textField.text
//    }
    
    
    
    func setTime(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        departureTimeLabel.text = timeFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func timePicker(sender: UIDatePicker) {
        setTime(sender)
    }
    
    @IBOutlet weak var button: UIButton!
    
    //Alert message: ask user to turn on the bluetooth.
    
    //Alert message: ask user to give permission to turn on the camera
    
    
}
