//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by nacho on 3/9/15.
//  Copyright (c) 2015 Ignacio Moreno. All rights reserved.
//

import UIKit

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    var receivedAudio:RecordAudio!
    
    private var sppedSound: SpeedSound!
    private var pitchSound: SoundPitch!
    private var echoSound: SoundEcho!
    private var reverbSound: SoundReverb!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sppedSound = SpeedSound(filePath: self.receivedAudio.filePathUrl);
        self.pitchSound = SoundPitch(filePath: self.receivedAudio.filePathUrl);
        self.echoSound = SoundEcho(filePath: self.receivedAudio.filePathUrl);
        self.reverbSound = SoundReverb(filePath: self.receivedAudio.filePathUrl);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    @IBAction func playSlow(sender: UIButton) {
        stop();
        self.sppedSound.setRate(soundRate: 0.5)
        self.sppedSound.toggleAvPlayer();
    }

    @IBAction func playFast(sender: UIButton) {
        stop();
        self.sppedSound.setRate(soundRate: 1.5)
        self.sppedSound.toggleAvPlayer();
    }
    
    @IBAction func playEcho(sender: UIButton) {
        stop();
        self.echoSound.setEffect(soundEffect: 0.1)
        self.echoSound.toggleAvPlayer()
    }
    
    @IBAction func playReverb(sender: UIButton) {
        stop();
        self.reverbSound.setEffect(soundEffect: 100)
        self.reverbSound.toggleAvPlayer()
    }
    
    @IBAction func stopSound(sender: UIButton) {
        stop();
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        stop();
        
        self.pitchSound.setEffect(soundEffect: 1000)
        self.pitchSound.toggleAvPlayer()
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        stop();
        
        self.pitchSound.setEffect(soundEffect: -1000)
        self.pitchSound.toggleAvPlayer()
    }
    
    private func stop() {
        if (self.sppedSound.isPlaying()) {
            self.sppedSound.stopAvPlayer();
        }
        if (self.pitchSound.isPlaying()) {
            self.pitchSound.stopAvPlayer();
        }
        if (self.echoSound.isPlaying()) {
            self.echoSound.stopAvPlayer();
        }
        if (self.reverbSound.isPlaying()) {
            self.reverbSound.stopAvPlayer();
        }
    }
    
    
}
