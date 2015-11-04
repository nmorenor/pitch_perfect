//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by nacho on 3/4/15.
//  Copyright (c) 2015 Ignacio Moreno. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var tapToRecordLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    private var audioRecorder:AVAudioRecorder!
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    var recordedAudio:RecordAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewWillAppear(animated: Bool) {
        self.setInitialState();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }

    @IBAction func recordAudio(sender: UIButton) {
        self.setRecordingState();
        
        let dirPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0];
        let currentDateTime = NSDate();
        let formatter = NSDateFormatter();
        formatter.dateFormat = "ddMMyyyy-HHmmss";
        let recordingName:String = formatter.stringFromDate(currentDateTime) + ".wav";
        let pathArray:[String] = [dirPath, recordingName];
        let filePath = NSURL.fileURLWithPathComponents(pathArray);
        print(filePath);
        
        let session = AVAudioSession.sharedInstance();
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
        } catch _ {
        };
        
        self.audioRecorder = try? AVAudioRecorder(URL: filePath!, settings: [String : AnyObject]());
        self.audioRecorder.delegate = self;
        self.audioRecorder.meteringEnabled = true;
        self.audioRecorder.prepareToRecord();
        self.audioRecorder.record();
    }
    
    private func setInitialState() {
        recordLabel.hidden = true;
        stopButton.enabled = false;
        stopButton.hidden = true;
        pauseButton.enabled = false;
        pauseButton.hidden = true;
        tapToRecordLabel.hidden = false;
        recordButton.enabled = true;
    }
    
    private func setRecordingState () {
        recordLabel.hidden = false;
        tapToRecordLabel.hidden = true;
        stopButton.hidden = false;
        stopButton.enabled = true;
        pauseButton.hidden = false;
        pauseButton.enabled = true;
        recordButton.enabled = false;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController;
            let data = sender as! RecordAudio;
            playSoundVC.receivedAudio = data;
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            recordedAudio = RecordAudio(file: recorder.url, withTitle: recorder.url.lastPathComponent);
        
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio);
        } else {
            print("Recording audio was not successful");
            setInitialState()
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        self.setInitialState();
        
        self.audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance();
        do {
            try audioSession.setActive(false)
        } catch _ {
        };
    }
    
    @IBAction func puaseRecording(sender: UIButton) {
        if (self.audioRecorder.recording) {
            self.audioRecorder.pause();
            let image:UIImage! = UIImage(named: "resume")!
            self.pauseButton.setImage(image, forState: UIControlState.Normal);
        } else {
            let image:UIImage! = UIImage(named: "pause")!
            self.pauseButton.setImage(image, forState: UIControlState.Normal);
            self.audioRecorder.record();
        }
    }
}
