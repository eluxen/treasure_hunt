//
//  MainViewController.swift
//  TreasureHuntProject
//
//  Created by Tomer Levi on 11/2/14.
//  Copyright (c) 2014 KLARNA. All rights reserved.
//

import UIKit

import CoreLocation

import MapKit




class MainViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var theMap: MKMapView!
    
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    
    var manager:CLLocationManager!
    
    var myLocations: [CLLocation] = []
    
    var startTime: NSDate = NSDate()
    
    var aggregatedTime: Int = 0
    
    @IBOutlet weak var timeView: UIView!
    var questionContent: NSString = "Where is the dog?"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        timeView.layer.cornerRadius = 10;
        timeView.layer.masksToBounds = true;
        
        //Setup our Location Manager
        
        manager = CLLocationManager()
        
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestAlwaysAuthorization()
        
        manager.startUpdatingLocation()
        
        
        //Setup our Map View
        
        theMap.delegate = self
        
        theMap.mapType = MKMapType.Standard
        
        theMap.showsUserLocation = true
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateElapsedTime", userInfo: nil, repeats: true)
    }
    
    func GetGameData() -> NSDictionary {
        let url = NSURL(string: "http://nadav-klarna.ngrok.com/games/search?name=Where")
        
        var gameData: NSString?
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            gameData = NSString(data: data, encoding: NSUTF8StringEncoding)
        }
        
        task.resume()
        
        var stringData: NSData = gameData!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        var err: NSError?
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(stringData, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
        if (err != nil) {
            
        }
        else {
            
        }
        return json
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        myLocations.append(locations[0] as CLLocation)
        
        if (myLocations.count > 1){
            var sourceIndex = myLocations.count - 1
            
            var destinationIndex = myLocations.count - 2
            
            
            
            let c1 = myLocations[sourceIndex].coordinate
            
            let c2 = myLocations[destinationIndex].coordinate
            
            var a = [c1, c2]
            
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            
            theMap.addOverlay(polyline)
        }
        else
        {
            centerMapAtLocation(myLocations.last!.coordinate)
        }
        
    }
    
    func centerMapAtLocation(center_point: CLLocationCoordinate2D) {
        
        let spanX = 0.007
        
        let spanY = 0.007
        
        var newRegion = MKCoordinateRegion(center: center_point, span: MKCoordinateSpanMake(spanX, spanY))
        
        theMap.setRegion(newRegion, animated: true)
    }
    
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        
        
        if overlay is MKPolyline {
            
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            
            polylineRenderer.strokeColor = UIColor.blueColor()
            
            polylineRenderer.lineWidth = 4
            
            return polylineRenderer
            
        }
        
        return nil
        
    }
    
    func updateElapsedTime() {
        elapsedTimeLabel.text = NSString(format:"Time: %d sec", Int(abs(startTime.timeIntervalSinceNow)))
    }
    
    @IBAction func centerMapPressed(sender: AnyObject) {
        centerMapAtLocation(myLocations.last!.coordinate)
    }
    
    
    @IBAction func showQuestionPressed(sender: AnyObject) {
        UIAlertView(title: "Clue #1", message: questionContent, delegate: nil, cancelButtonTitle: "Dismiss").show()
    }
    
    func checkIn() {
        
        
        
    }
    
    
}