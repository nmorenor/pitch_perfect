//
//  SoundPitch.swift
//  Pitch Perfect
//
//  Created by nacho on 3/11/15.
//  Copyright (c) 2015 Ignacio Moreno. All rights reserved.
//

import Foundation
import AVFoundation

class SoundPitch: NSObject {
    
    private var filePath:NSURL?
    private var audioEngine:AVAudioEngine!
    private var audioFile:AVAudioFile!
    internal var effectValue:NSNumber!
    private var audioPlayerNode:AVAudioPlayerNode!
    
    init!(fileName file: String!, fileExt fileExtension: String!) {
        self.filePath = NSBundle.mainBundle().URLForResource(file, withExtension: fileExtension)!;
        super.init()
        initEffect()
    }
    
    init!(filePath file:NSURL!) {
        self.filePath = file;
        super.init()
        initEffect()
    }
    
    func initEffect() {
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: self.filePath, error: nil)
    }
    
    func setEffect(soundEffect toEffect:NSNumber!) {
        if (audioPlayerNode != nil) {
            audioEngine.stop()
            audioEngine.reset()
        }
        self.effectValue = toEffect;
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let effect:AVAudioUnit = getAudioUnit()
        audioEngine.attachNode(effect)
        
        audioEngine.connect(audioPlayerNode, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
    }
    
    func getAudioUnit() -> AVAudioUnit {
        let effect:AVAudioUnitTimePitch = AVAudioUnitTimePitch()
        effect.pitch = effectValue as Float!
        return effect;
    }
    
    func isPlaying() -> Bool {
        if (audioPlayerNode == nil) {
            return false
        }
        return audioPlayerNode.playing ? true : false;
    }
    
    func startAvPlayer() {
        if (audioPlayerNode == nil) {
            return
        }
        if !audioEngine.running {
            audioPlayerNode.playAtTime(AVAudioTime(hostTime: AVAudioTime.hostTimeForSeconds(0)))
        }
    }
    
    func stopAvPlayer() {
        if (audioPlayerNode == nil) {
            return
        }
        if audioPlayerNode.playing {
            audioPlayerNode.stop()
            audioEngine.stop()
            audioEngine.reset()
        }
    }
    
    func toggleAvPlayer() {
        if (audioPlayerNode == nil) {
            return
        }
        if audioPlayerNode.playing {
            audioPlayerNode.stop()
        } else {
            audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
            audioEngine.startAndReturnError(nil)
            audioPlayerNode.play()
        }
    }
}
