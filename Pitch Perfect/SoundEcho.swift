//
//  SoundEcho.swift
//  Pitch Perfect
//
//  Created by nacho on 3/13/15.
//  Copyright (c) 2015 Ignacio Moreno. All rights reserved.
//

import Foundation
import AVFoundation

class SoundEcho: SoundPitch {
    
    override func getAudioUnit() -> AVAudioUnit {
        let effect:AVAudioUnitDelay = AVAudioUnitDelay()
        effect.delayTime = self.effectValue as Double
        return effect;
    }
}
