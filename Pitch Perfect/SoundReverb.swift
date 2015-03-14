//
//  SoundReverb.swift
//  Pitch Perfect
//
//  Created by nacho on 3/13/15.
//  Copyright (c) 2015 Ignacio Moreno. All rights reserved.
//

import Foundation
import AVFoundation

class SoundReverb: SoundPitch {
    
    override func getAudioUnit() -> AVAudioUnit {
        let effect:AVAudioUnitReverb = AVAudioUnitReverb()
        effect.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral);
        effect.wetDryMix = self.effectValue as Float!
        return effect;
    }
}
