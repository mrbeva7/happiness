//
//  BarCodeViewController.swift
//  Airport
//
//  Created by RUBING MAO on 4/30/16.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

//Mark : Try to get user input with barcode
class BarCodeViewController : UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    
    let captureSession = AVCaptureSession ()
    var captureDevice: AVCaptureDevice?
    var captureLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var lblDataInfo: UILabel!
    @IBOutlet weak var lblDataType: UILabel!
    
    
    private func setupCaptureSession()
    {
        self.captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: self.captureDevice)
            //Add the input feed to the session and start it
            self.captureSession.addInput(deviceInput)
            self.setupPreviewLayer({
                self.captureSession.startRunning()
                self.addMetaDataCaptureOutToSession()
            })
        } catch {
            print("Something went wrong... :S")
        }
        
    }
    
    private func setupPreviewLayer(completion:() -> ())
    {
        self.captureLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        
        if let capLayer = self.captureLayer {
            capLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            capLayer.frame = self.view.layer.bounds
            self.view.layer.addSublayer(capLayer)
            self.view.bringSubviewToFront(lblDataInfo)
            self.view.bringSubviewToFront(lblDataType)
            completion()
        } else {
            print("An error occured beginning video capture.")
        }
    }
    
    private func addMetaDataCaptureOutToSession()
    {
        let metadata = AVCaptureMetadataOutput()
        self.captureSession.addOutput(metadata)
        metadata.metadataObjectTypes = metadata.availableMetadataObjectTypes
        metadata.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
    }
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        for metaData in metadataObjects
        {
            let decodedData:AVMetadataMachineReadableCodeObject = metaData as! AVMetadataMachineReadableCodeObject
            self.lblDataInfo.text = decodedData.stringValue
            self.lblDataType.text = decodedData.type
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.setupCaptureSession()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}