//
//  ViewController.swift
//  TreasureHuntProject
//
//  Created by Tomer Levi on 11/2/14.
//  Copyright (c) 2014 KLARNA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func playButtonPressed(sender: UIButton) {
        if gameName.text.isEmpty {
            UIAlertView(title: "Treasure Hunt", message: "Please Insert Game Name", delegate: nil, cancelButtonTitle: "OK").show()
            return;
        }
        // get game contents from server
        
        let url = NSURL(fileURLWithPath: NSString(format: "https://boiling-forest-7567.herokuapp.com/game/search?name=%@", gameName.text))
            
        var gameData: NSString?
            
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            //gameData = NSString(data: data, encoding: NSUTF8StringEncoding)
            //NSLog("game data length = %d",gameData!.length)
            //var stringData: NSData = gameData!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
            //var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(stringData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            // push main view controller
            dispatch_sync(dispatch_get_main_queue(), {
            var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var mainViewController : MainViewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as MainViewController
            //mainViewController.dataObject = json
                self.navigationController?.pushViewController(mainViewController, animated: true) })
        }
            
        task.resume()
    
    }
}

