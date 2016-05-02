//
//  MapViewController.swift
//  Airport
//
//  Created by RUBING MAO on 4/26/16.
//  Copyright © 2016 RUBING MAO. All rights reserved.
//

import Foundation
import UIKit

//Reference : 
//1)Estimote Indoor Location SDK : https://github.com/Estimote/iOS-Indoor-SDK
//2)The SDK is available as EstimoteIndoorSDK in CocoaPods: https://cocoapods.org
class MapViewController : UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate, EILIndoorLocationManagerDelegate {
    
    //Mark : scollView and imageView variables
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    //Mark : Location variables
    @IBOutlet weak var locationView: EILIndoorLocationView!
    let locationManager = EILIndoorLocationManager()
    var location: EILLocation!
    var currentPosition: EILOrientedPoint!
    var finalPosition: EILOrientedPoint!
    var routeLayer: CAShapeLayer! //It draws a cubic Bezier spline in its coordinate space
    var endPoint : CGPoint!
    var destinationPoint : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mark : scollView and imageView setting
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 5.0
        
        //Mark : Location configuration
        ESTConfig.setupAppID("airportapp4-0ty", andAppToken: "3e4dd8d8127a4d2a2b5a800036333218")
        //App ID: airport-mws & App Token: 75913f1703ecf1f3e981b56eaff74e0f
        
        self.locationManager.delegate = self
        
        let fetchLocationRequest = EILRequestFetchLocation(locationIdentifier: "classroom-b305-ver2-ajz")
        fetchLocationRequest.sendRequestWithCompletion { (location, error) in
            if let location = location {
                self.location = location
                self.locationView.backgroundColor = UIColor.clearColor()
                self.locationView.showTrace = false
                self.locationView.traceColor = UIColor.brownColor()
                self.locationView.rotateOnPositionUpdate = false
                self.locationView.locationBorderColor = UIColor.darkGrayColor()
                self.locationView.locationBorderThickness = 3
                self.locationView.drawLocation(location) //drawing where you are
                
                //Mark : Inside of the airport
                
                let viewHorizontalLine = UIView.init(frame: CGRect(x: 55, y: 220, width: 210, height: 4))
                viewHorizontalLine.backgroundColor = UIColor.darkGrayColor()
                self.view.addSubview(viewHorizontalLine)
                
                let viewVerticalLine = UIView.init(frame: CGRect(x: 155, y: 100, width: 4, height: 230))
                viewVerticalLine.backgroundColor = UIColor.darkGrayColor()
                self.view.addSubview(viewVerticalLine)
                
                let startingPointImg = UIImage(named: "startingPoint")
                let startingPoint = UIImageView.init(frame: CGRectMake(0,0,30,30)) //It represents the dimensions of width and height.
                startingPoint.image = startingPointImg
                
                let startingP = EILOrientedPoint(x: 0.5, y:0.5, orientation: 0)
                //self.locationView.drawObjectInBackground(startingPoint, withPosition: startingP, identifier: "startP")
               
                self.locationManager.startPositionUpdatesForLocation(self.location)
                
                //Mark : set tapGestureRecognizer
                var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapping:")
                self.locationView.userInteractionEnabled = true
                self.locationView.addGestureRecognizer(tap)
                
            } else {
                print("can't fetch location: \(error)")
            }
        }
    }
    
    func tapping(sender:UITapGestureRecognizer){
        let finalPoint = locationView.calculateRealPointFromPicturePoint(sender.locationInView(locationView))
        self.finalPosition = EILOrientedPoint(x: finalPoint.x, y: finalPoint.y)
        displayRoute()
        checkDestination()
        print(finalPoint)
    }
    
    //Mark : displaying the route (drawing the path)
    func displayRoute(){
        var route = UIBezierPath()
        let startPoint = locationView.calculatePicturePointFromRealPoint(currentPosition)
        endPoint = locationView.calculatePicturePointFromRealPoint(finalPosition)
        route.moveToPoint(startPoint)
        route.addLineToPoint(CGPoint(x: endPoint.x, y:startPoint.y))
        route.addLineToPoint(endPoint)
        
        if routeLayer != nil {
            routeLayer.removeFromSuperlayer()
        }
        
        routeLayer = CAShapeLayer()
        routeLayer.path = route.CGPath
        routeLayer.strokeColor = UIColor.brownColor().CGColor
        routeLayer.fillColor = UIColor.clearColor().CGColor
        routeLayer.lineDashPattern = [4,5]
        locationView.layer.insertSublayer(routeLayer, atIndex: 0)
        
    }
    
    //Mark : check whether the user tap the different destination or not. If it's a different location, it will move the destination point and the path according to the new destination position.
    func checkDestination() {
        let destinationPointImg = UIImage(named: "destinationPoint")
        destinationPoint = UIImageView.init(frame: CGRectMake(0,0,50,50)) //Itrepresents the dimensions of width and height.
        destinationPoint.image = destinationPointImg

        if (locationView.objectWithidentifier("destinationP") == nil) {
            self.locationView.drawObjectInForeground(destinationPoint, withPosition: finalPosition, identifier: "destinationP")
        } else {
            self.locationView.moveObjectWithIdentifier("destinationP", toPosition: finalPosition, animated: false)
        }
    }
    
    func indoorLocationManager(manager: EILIndoorLocationManager!, didFailToUpdatePositionWithError error: NSError!) {
        print("failed to update position: \(error)")
    }
    
    func indoorLocationManager(manager:EILIndoorLocationManager!,didUpdatePosition position: EILOrientedPoint!,withAccuracy positionAccuracy: EILPositionAccuracy,
                               inLocation location: EILLocation!) {
        var accuracy: String!
        switch positionAccuracy {
        case .VeryHigh: accuracy = "+/- 1.00m"
        case .High:     accuracy = "+/- 1.62m"
        case .Medium:   accuracy = "+/- 2.62m"
        case .Low:      accuracy = "+/- 4.24m"
        case .VeryLow:  accuracy = "+/- ? :-("
        case .Unknown:  accuracy = "unknown"
        }
        print(String(format: "x: %5.2f, y: %5.2f, orientation: %3.0f, accuracy: %@",
            position.x, position.y, position.orientation, accuracy))
        //Mark : set the current location
        currentPosition = position
        self.locationView.updatePosition(position)
    }
    
    
    //Mark : zooming in scrollview
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}