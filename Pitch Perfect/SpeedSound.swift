//
//  SlowSound.swift
//  Pitch Perfect
//
//  Created by nacho on 3/9/15.
//  Copyright (c) 2015 Ignacio Moreno. All rights reserved.
//

import UIKit
import AVFoundation

class SpeedSound: NSObject {
   
    private var player:AVAudioPlayer!
    private var filePath:NSURL?
    
    init!(fileName file: String!, fileExt fileExtension: String!) {
        self.filePath = NSBundle.mainBundle().URLForResource(file, withExtension: fileExtension)!;
        super.init()
        readFileIntoAvPlayer()
    }
    
    init!(filePath file:NSURL!) {
        self.filePath = file;
        super.init()
        readFileIntoAvPlayer()
    }
    
    func readFileIntoAvPlayer() {
        self.player = try! AVAudioPlayer(contentsOfURL: self.filePath!);
        
        
        player.prepareToPlay();
        player.volume = 1.0
        player.enableRate = true
    }
    
    func isPlaying() -> Bool {
        return player.playing ? true : false;
    }
    
    func setRate(soundRate rate:Float!) {
        self.player.rate = rate
    }
    
    func startAvPlayer() {
        if !player.playing {
            player.currentTime = 0.0
            player.play()
        }
    }
    
    func stopAvPlayer() {
        if player.playing {
            player.stop()
        }
    }
    
    func toggleAvPlayer() {
        if player.playing {
            player.pause()
        } else {
            player.currentTime = 0.0
            player.play()
        }
    }
}
