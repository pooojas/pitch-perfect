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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recivedAudio.filePathUrl, error: nil)
        audioPlayer = AVAudioPlayer(contentsOfURL:recivedAudio.filePathUrl , error: nil)
        audioPlayer.enableRate=true

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stopPlay(sender: AnyObject) {
        audioPlayer.stop()
        audioEngine.reset()
    }
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1500)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
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
        sound(2.0)
    }
    @IBAction func playSlowSound(sender: AnyObject) {
        sound(0.5)
    }
    
    func sound(rate: Float){
        audioPlayer.stop()
        audioEngine.reset()
        audioPlayer.rate=rate
        audioPlayer.currentTime=0.0
        audioPlayer.play()
        
    }
}
