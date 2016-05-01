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
    var routeLayer: CAShapeLayer! //It draws a cubic Bezier spline in its coordinate space
    var finalPosition: EILOrientedPoint!
    
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
                self.locationView.showTrace = true
                self.locationView.traceColor = UIColor.brownColor()
                self.locationView.rotateOnPositionUpdate = false
                //self.locationView.showBeacons = true
                self.locationView.locationBorderColor = UIColor.darkGrayColor()
                self.locationView.locationBorderThickness = 3
                self.locationView.drawLocation(location) //drawing where you are
                
                //Mark : Inside of the airport
                //context is the object used for drawings
                //                let context = UIGraphicsGetCurrentContext()
                //                CGContextSetLineWidth(context, 3.0)
                //                CGContextSetStrokeColorWithColor(context, UIColor.darkGrayColor().CGColor)
                //
                //                //Creat a path
                //                CGContextMoveToPoint(context, 0, 0)
                //                CGContextAddLineToPoint(context, 0, 200)
                
                //Actually darw the path
                //CGContextStrokePath(context)
                //UIView.drawRect(locationView)
                
                let viewHorizontalLine = UIView.init(frame: CGRect(x: 55, y: 220, width: 210, height: 4))
                viewHorizontalLine.backgroundColor = UIColor.darkGrayColor()
                self.view.addSubview(viewHorizontalLine)
                
                let viewVerticalLine = UIView.init(frame: CGRect(x: 155, y: 100, width: 4, height: 230))
                viewVerticalLine.backgroundColor = UIColor.darkGrayColor()
                self.view.addSubview(viewVerticalLine)
                
                let startingPointImg = UIImage(named: "startingPoint")
                let startingPoint = UIImageView.init(frame: CGRectMake(0,0,30,30)) //It represents the dimensions of width and height.
                startingPoint.image = startingPointImg
                
            
                
                //locationView.drawObjectInBackground(UIView, withPosition: <#T##EILOrientedPoint#>, identifier: "map") //tells empty or not
                //locationView.drawObjectInForeground(<#T##object: UIView##UIView#>, withPosition: <#T##EILOrientedPoint#>, identifier: <#T##String#>)
                
                let startingP = EILOrientedPoint(x: 0.5, y:0.5, orientation: 0)
                self.locationView.drawObjectInBackground(startingPoint, withPosition: startingP, identifier: "startP")
               
                self.locationManager.startPositionUpdatesForLocation(self.location)
                
                //Reference : http://stackoverflow.com/questions/34431459/ios-swift-how-to-add-pinpoint-to-map-on-touch-and-get-detailed-address-of-th
                var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapping:")
//                startingPoint.userInteractionEnabled = true
//                destinationPoint.userInteractionEnabled = true
                //tappingRecognizer.numberOfTapsRequired = 1
                //self.view.addGestureRecognizer(tappingRecognizer)
                //startingPoint.addGestureRecognizer(tappingRecognizer)
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
        print(finalPoint)
    }
    
//    func tapping(img: AnyObject){
//        displayRoute()
//        print("route added")
//    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        var destPoint:CGPoint = CGPointZero
//        if let touch = touches.first as? UITouch{
//            destPoint = touch.locationView(self.view)
//        }
//    }
    
    //Mark : displaying the route
    func displayRoute(){
        var route = UIBezierPath()
        let startPoint = locationView.calculatePicturePointFromRealPoint(currentPosition)
        route.moveToPoint(startPoint)
        
        let destinationPointImg = UIImage(named: "destinationPoint")
        let destinationPoint = UIImageView.init(frame: CGRectMake(0,0,50,50)) //Itrepresents the dimensions of width and height.
        destinationPoint.image = destinationPointImg
        let destinationP = EILOrientedPoint(x : finalPosition.x, y:finalPosition.y, orientation: 0)
        self.locationView.drawObjectInBackground(destinationPoint, withPosition: destinationP, identifier: "destinationP")
        
        //let destinationPoint = locationView.calculatePicturePointFromRealPoint(EILOrientedPoint(x :4, y:1.5, orientation: 0))
        //let destinationPoint = locationView.calculatePicturePointFromRealPoint(EILOrientedPoint(x:finalPoint.x, y:finalPoint.y, orientation: 0))
        //route.addLineToPoint(CGPoint(x:finalPoint.x, y:startPoint.y))
        route.addLineToPoint(CGPoint(x: CGFloat (finalPosition.x), y:startPoint.y))
        route.addLineToPoint(CGPoint(x: CGFloat (finalPosition.x), y:CGFloat (finalPosition.y)))
        
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
        currentPosition = position
        self.locationView.updatePosition(position)
    }
    
    
    //Mark : zooming in scrollview
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}