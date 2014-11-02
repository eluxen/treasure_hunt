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
    
    var questionIndex: Int = 0
    
    var dataObject: NSDictionary?
    
    @IBOutlet weak var timeView: UIView!
    
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

    @IBAction func checkInButtonPressed(sender: AnyObject) {
        var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var doneViewController : UIViewController = storyboard.instantiateViewControllerWithIdentifier("DoneViewController") as UIViewController
        self.navigationController?.pushViewController(doneViewController, animated: true)
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
        //var questions: NSArray = dataObject!["Points"] as NSArray
        //var question: NSDictionary = questions[questionIndex] as NSDictionary
        UIAlertView(title: "Clue #1", message: /*question["Question"] as NSString*/ "Where is the dog?", delegate: nil, cancelButtonTitle: "Dismiss").show()
    }
    
    func checkIn() {
        
        
        
    }
    
    
}