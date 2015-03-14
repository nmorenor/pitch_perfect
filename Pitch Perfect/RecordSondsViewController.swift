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
        
        let dirPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0];
        let currentDateTime = NSDate();
        let formatter = NSDateFormatter();
        formatter.dateFormat = "ddMMyyyy-HHmmss";
        let recordingName = formatter.stringFromDate(currentDateTime) + ".wav";
        let pathArray = [dirPath, recordingName];
        let filePath = NSURL.fileURLWithPathComponents(pathArray);
        println(filePath);
        
        var session = AVAudioSession.sharedInstance();
        session.setCategory(AVAudioSessionCategoryPlayback, error: nil);
        
        self.audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil);
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
            let playSoundVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController;
            let data = sender as RecordAudio;
            playSoundVC.receivedAudio = data;
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag) {
            recordedAudio = RecordAudio(file: recorder.url, withTitle: recorder.url.lastPathComponent);
        
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio);
        } else {
            println("Recording audio was not successful");
            setInitialState()
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        self.setInitialState();
        
        self.audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance();
        audioSession.setActive(false, error: nil);
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
