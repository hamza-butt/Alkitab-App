//
//  showDetailViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 25/11/2020.
//

import UIKit
import AVFoundation
import Firebase


class showDetailViewController: UIViewController,AVAudioPlayerDelegate,AVAudioRecorderDelegate {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var recordAudio: UIButton!
    @IBOutlet weak var playAudioRecording: UIButton!
    @IBOutlet weak var sendAudio: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedImage = String()
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var meterTimer:Timer!
    var isAudioRecordingGranted: Bool!
    var isPlaying = false
    
    var recodingTime = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playAudioRecording.isHidden = true
        sendAudio.isHidden = true
        
        showImage.image = UIImage(named: selectedImage)
        // Do any additional setup after loading the view.
        
        check_record_permission()
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(press:)))
        longGesture.minimumPressDuration = 0
        recordAudio.addGestureRecognizer(longGesture)
        
    }
    
    
    @objc func longPress(press:UILongPressGestureRecognizer){
        if press.state == .began{
            //recoding start
            
            
            setup_recorder()
            audioRecorder.record()
            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            recordAudio.setImage(UIImage(named: "microphone.png"), for: UIControl.State.normal)
        }
        else{
            recordAudio.setImage(UIImage(named: "microphone_black.png"), for: UIControl.State.normal)
            
            finishAudioRecording(success: true)
            //timeLabel.text = "00:00:00"
        }
        
    }
    
    
    @IBAction func goBack(_ sender: Any)
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func upLoadAudio(_ sender: Any)
    {
        if getFileUrl().path != nil{
            print("url is \(getFileUrl().path)")
            
            // File located on disk
            let localFile:URL = getFileUrl()
            
            // Create a reference to the file you want to upload
            let riversRef = Storage.storage().reference().child("qariAudios/\(selectedImage).m4a")
            
            // Upload the file to the path "images/rivers.jpg"
            let uploadTask = riversRef.putFile(from: localFile, metadata: nil) { metadata, error in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurrebd!
                    self.showAlert(error:error!)
                    return
                }
                // Metadata contains file metadata such as size, content-type.
                //let size = metadata.size
                // You can also access to download URL after upload.
                riversRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        self.showAlert(error:error!)
                        return
                    }
                    print(downloadURL)
                }
            }
            
        }
    }
    
    
    
    
    //MARK:-                            Play Recording
    
    @IBAction func play_recording(_ sender: Any)
    {
        
        if FileManager.default.fileExists(atPath: getFileUrl().path)
        {
            playAudioRecording.setImage(UIImage(named: "play.png"), for: UIControl.State.normal)
            prepare_play()
            audioPlayer.play()
            isPlaying = true
        }
        else
        {
            display_alert(msg_title: "Error", msg_desc: "Audio file is missing.", action_title: "OK")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playAudioRecording.setImage(UIImage(named: "play_black.png"), for: UIControl.State.normal)
    }
    
    
}



extension showDetailViewController{
    //MARK:-                            check record permission
    
    func check_record_permission()
    {
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            isAudioRecordingGranted = true
            break
        case AVAudioSessionRecordPermission.denied:
            isAudioRecordingGranted = false
            break
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                if allowed {
                    self.isAudioRecordingGranted = true
                } else {
                    self.isAudioRecordingGranted = false
                }
            })
            break
        default:
            break
        }
    }
    
    //MARK:-                         generate path where you want to save that recording
    
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getFileUrl() -> URL
    {
        let filename = "myRecording.m4a"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        return filePath
    }
    
    
    //MARK:-                      Generalize function for display alert
    
    func display_alert(msg_title : String , msg_desc : String ,action_title : String)
    {
        let ac = UIAlertController(title: msg_title, message: msg_desc, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: action_title, style: .default)
        {
            (result : UIAlertAction) -> Void in
            _ = self.navigationController?.popViewController(animated: true)
        })
        present(ac, animated: true)
    }
    
    //MARK:-                       Setup recoder
    
    func setup_recorder()
    {
        if isAudioRecordingGranted
        {
            let session = AVAudioSession.sharedInstance()
            do
            {
                try session.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            }
            catch let error {
                display_alert(msg_title: "Error", msg_desc: error.localizedDescription, action_title: "OK")
            }
        }
        else
        {
            display_alert(msg_title: "Error", msg_desc: "Don't have access to use your microphone.", action_title: "OK")
        }
    }
    
    
    //MARK:-                           start the recorder
    
    @objc func updateAudioMeter(timer: Timer)
    {
        if audioRecorder.isRecording
        {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
            
            recodingTime = totalTimeString
            timeLabel.text = totalTimeString
            audioRecorder.updateMeters()
        }
    }
    
    func finishAudioRecording(success: Bool)
    {
        if success
        {
            if audioRecorder == nil{
                
                timeLabel.text = recodingTime
                display_alert(msg_title: "Error", msg_desc: "Recording failed.", action_title: "OK")
                return
            }
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            print("recorded successfully.")
            
            playAudioRecording.isHidden = false
            sendAudio.isHidden = false
            
        }
        else
        {
            display_alert(msg_title: "Error", msg_desc: "Recording failed.", action_title: "OK")
        }
    }
    
    //MARK:-                          Play the recording
    
    
    func prepare_play()
    {
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileUrl())
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error")
        }
    }
    
    
    func showAlert(error:Error){
        
        let alert = UIAlertController(title: "ERROR", message:error.localizedDescription,preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default,handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

