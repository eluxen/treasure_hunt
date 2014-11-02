//
//  DoneViewController.swift
//  TreasureHuntProject
//
//  Created by Eyal Luxenburg on 11/2/14.
//  Copyright (c) 2014 KLARNA. All rights reserved.
//

import UIKit

import AVFoundation

class DoneViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    var backgroundMusicPlayer: AVAudioPlayer!
    
    var elapsedTime: Int?
    
    @IBOutlet weak var secondsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSBundle.mainBundle().URLForResource("money.mp3", withExtension: nil)
        var error: NSError? = nil
        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
        secondsLabel.text = NSString(format: "In %d seconds!", elapsedTime!)
        self.navigationItem.title = "Congratulations!"
    }

    @IBAction func restartGameButtonPressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
