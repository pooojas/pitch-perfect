//
//  RecordSoundViewController.swift
//  PitchPerfectApp
//
//  Created by Sharma, Pooja on 3/24/15.
//  Copyright (c) 2015 Stubhub. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recording: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var recBtn: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recorderAudio: RecordedAudio!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        stopButton.hidden=true
        recBtn.enabled=true
        recording.hidden=false
        recording.text="Tap to record"
    }

    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden=false
        recording.hidden=false
        recording.text="recording"
        recBtn.enabled=false
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate=self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            
            recorderAudio = RecordedAudio(filePathUrl:recorder.url,title:recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recorderAudio)
        }
        else{
          println("recording did not finish sucessfully")
            recBtn.enabled=true
            stopButton.hidden=true
            recording.hidden=false
            recording.text="recording"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="stopRecording"){
            let playSoundVC:PlaySoundViewController=segue.destinationViewController as PlaySoundViewController
            let data = sender as RecordedAudio
            playSoundVC.recivedAudio=data
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recording.hidden=true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

