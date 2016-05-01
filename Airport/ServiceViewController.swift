//
//  serviceViewController.swift
//  Airport
//
//  Created by RUBING MAO on 4/25/16.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ServiceViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet var PausePlay: UIButton!
 
    var BackgroundAudio = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Nhumo_Mind, Body and Soul", ofType: "mp3")!)
    
    var BackgroundAudioPlayer: AVAudioPlayer!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try BackgroundAudioPlayer = AVAudioPlayer(contentsOfURL: BackgroundAudio)
            BackgroundAudioPlayer.play()
        } catch {
            print("error")
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        BackgroundAudioPlayer.stop()
    }

    @IBAction func PausePlay(sender: AnyObject) {
        
        if (BackgroundAudioPlayer.playing == true){
            BackgroundAudioPlayer.stop()
            //PausePlay.setImage("play", forState: UIControlState.Normal)
            PausePlay.setImage(UIImage(named: "play"), forState: .Normal)
        } else {
            BackgroundAudioPlayer.play()
            //PausePlay.setImage("pause", forState: UIControlState.Normal)
            PausePlay.setImage(UIImage(named: "pause"), forState: .Normal)
        }
        
    }

}