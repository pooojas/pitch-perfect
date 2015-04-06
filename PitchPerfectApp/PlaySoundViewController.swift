//
//  PlaySoundViewController.swift
//  PitchPerfectApp
//
//  Created by Sharma, Pooja on 4/4/15.
//  Copyright (c) 2015 Stubhub. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var audioPlayer : AVAudioPlayer!
    var recivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var audioPlayerNode : AVAudioPlayerNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            var filePathUrl = NSURL.fileURLWithPath(filePath)
            audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
            audioPlayer.enableRate=true
        }
        else{
            println("file path is missing!")
        }*/
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recivedAudio.filePathUrl, error: nil)
        audioPlayer = AVAudioPlayer(contentsOfURL:recivedAudio.filePathUrl , error: nil)
        audioPlayer.enableRate=true

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func stopPlay(sender: AnyObject) {
        audioPlayer.stop()
    }
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1500)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
   
    @IBAction func playDarthSound(sender: AnyObject) {
        playAudioWithVariablePitch(-1500)
    }
    @IBAction func playFastAudio(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayerNode.stop()
        audioPlayer.rate=2.0
        audioPlayer.currentTime=0.0
        audioPlayer.play()
    }
    @IBAction func playSlowSound(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayerNode.stop()
        audioPlayer.rate=0.5
        audioPlayer.currentTime=0.0
        audioPlayer.play()
        
    }
}
