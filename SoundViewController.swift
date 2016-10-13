//
//  SoundViewController.swift
//  Sound Board
//
//  Created by 重信和宏 on 13/10/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
  
    
    
    
   
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
   
    @IBOutlet weak var addButton: UIButton!
    
   
    @IBOutlet weak var nameTextField: UITextField!
    
    
    
    var audioRecorder: AVAudioRecorder?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        playButton.isEnabled = false
        addButton.isEnabled = false
        
        
        // Do any additional setup after loading the view.
    }
    func setupRecorder (){
        do {
            // Create an audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            // Create URL for the audio file
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask , true).first!
            let pathComponents = [basePath, "audiompa4"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print("@@@@@@@@@@@@@@@")
            print(audioURL)
            print("@@@@@@@@@@@@@@@")
            
            
            // Create setting for the audio recorder
            var settings : [String : AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            
            
            
            // Create audio recorder object
            
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder!.prepareToRecord()
            
            
            
        }catch _ as NSError {
            print("Hey error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    @IBAction func recordTapped(_ sender: AnyObject) {
    
    
        if (audioRecorder?.isRecording)!{
            //Stop the recording 
            audioRecorder?.stop()
            //Change the button title to record 
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
            addButton.isEnabled = true
            
        } else {
            //Start the recording 
            audioRecorder?.record()
            //Chagne the button title to stop
            recordButton.setTitle("Stop", for: .normal)
        
        }
        
        
    }
    
    @IBAction func playTapped(_ sender: AnyObject) {
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let sound = Sound(context:context)
        sound.name = nameTextField.text
        sound.audio = NSData(contentsOf: audioURL!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
     }
