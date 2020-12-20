//
//  showDetailLernerViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 03/12/2020.
//

import UIKit
import AVFoundation
import Firebase

class showDetailLernerViewController: UIViewController ,AVAudioPlayerDelegate{
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var playAudio: UIButton!
    
    var player: AVAudioPlayer!
    
    var imageToDisplay = String()
    var qariNumber = String()
    
    var clickedIndex = Int()
    
    var userDefaultName = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        showImage.image = UIImage(named: imageToDisplay)
        
        
    }
    
    @IBAction func playAudioClicked(_ sender: Any) {
        
        playSound(sound: imageToDisplay,text:qariNumber)
    }
    
    
    @IBAction func goBack(_ sender: Any){
        self.dismiss(animated: false, completion: nil)
    }
    
}


extension showDetailLernerViewController{
    
    func playSound(sound:String , text:String) {
        let soundName = ("\(sound)\(text)")
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { print("not found");return }
        
        do {
            
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            changeUserDefault()
            modifyFireBaseDocument()
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func changeUserDefault(){
        
        if clickedIndex ==  UserDefaults.standard.integer(forKey: userDefaultName){
            UserDefaults.standard.set(clickedIndex+1, forKey: userDefaultName)
            print(UserDefaults.standard.integer(forKey: userDefaultName))
        }
    }
    

    func modifyFireBaseDocument(){
        
        Firestore.firestore().collection("Users").whereField("id", isEqualTo: Auth.auth().currentUser?.uid as Any)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err.localizedDescription)")
                } else {
                    for document in querySnapshot!.documents {
                        document.reference.updateData([
                            self.userDefaultName: (self.clickedIndex+1)
                            
                        ])
                    }
                }
            }
    
    }
    
    
    
    
    
    
}
