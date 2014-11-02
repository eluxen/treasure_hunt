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
        
        // push main view controller
        var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var mainViewController : MainViewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as MainViewController
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
}

