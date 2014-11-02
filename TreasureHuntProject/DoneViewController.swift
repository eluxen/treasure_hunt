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
    
    var backgroundMusicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSBundle.mainBundle().URLForResource("money.mp3", withExtension: nil)
        var error: NSError? = nil
        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    }

}
