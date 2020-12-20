//
//  homeViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 24/11/2020.
//

import UIKit
import Firebase

class homeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var firstShowingView: UIView!
    @IBOutlet weak var quranImage: UIImageView!
    @IBOutlet weak var getStartedFunc: UIButton!
    
    
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var progressTableView: UITableView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var userName:String = UserDefaults.standard.string(forKey: "fullName") ?? "Welcome"
    
    let chapterName = ["One", "Two", "Three","Four","Five","Six","Seven","Eight","Nine","Ten","Eleven","Twelve","Thirteen","Fourteen","Fifteen","Sixteen","Seventeen"]
    
    
    var progressTypes:[String] = ["The Aplhabets","Joint Letters","The Muqattiat Letters","The movements","The Thanveen","The Tanveen and Movement","Standing Fatha, Standing Kasrah and standing Dhuma","The Maddeoleen","Standing Fatha, Kasrah, Dhu,a, Maddoleen or Tanveen","The Skoon and Jazm","The Exercise of Sakoon","The Tashdeed","Exersice of Tashdeed","Tashdeed With Sakoon","Tashdeed With Sakoon","Tashdeed With Tashdeed","Tashdeed With Harof Madah"]
    
    let chapterTotal = [30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressTableView.isHidden = true
        firstShowingView.isHidden = true
        activityIndicator.isHidden  = true
        
        welcomeLabel.text = "Welcome \(userName)"
        
        maketheButtonROunded(button: getStartedFunc)
        
        progressTableView.register(UINib(nibName: "progressTableViewCell", bundle: nil), forCellReuseIdentifier: "progressTableViewCell")
        
        // check user Defaults
        self.checkUserDefualt()
        
        
        
    }
    
    
    
    @IBAction func getStartedClicked(_ sender: Any) {
        
        //
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "LearningViewController") as! LearningViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    
    
    
    
    
    
    
}

//MARK:-                            TABLEVIEW DELEGETE

extension homeViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progressTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressTableViewCell", for: indexPath) as! progressTableViewCell
        
        let qari1AttainProgress = UserDefaults.standard.integer(forKey: "Chapter\(chapterName[indexPath.row])QariOne")
        let qari2AttainProgress = UserDefaults.standard.integer(forKey: "Chapter\(chapterName[indexPath.row])QariTwo")
        let totalProgress = UserDefaults.standard.integer(forKey: "Chapter\(chapterName[indexPath.row])Total")
        
        
        cell.assignData(typeName: progressTypes[indexPath.row], qari1AttainProgress: qari1AttainProgress, qari2AttainProgress: qari2AttainProgress, totalProgress: totalProgress)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return 300
        }
        else{
            return 200
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


//MARK:-                           BOTTOM NAVIGATION


extension homeViewController{
    
    @IBAction func homeClicked(_ sender: Any) {
        
    }
    @IBAction func learnCLicked(_ sender: Any) {
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "LearningMainViewController") as! LearningMainViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    
    @IBAction func evaluateClicked(_ sender: Any) {
        
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "evaluationViewController") as! evaluationViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    @IBAction func extraClicked(_ sender: Any) {
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "extrasViewController") as! extrasViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    @IBAction func aboutClicked(_ sender: Any) {
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "aboutUsViewController") as! aboutUsViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    
}

extension homeViewController{
    
    
    func maketheButtonROunded(button:UIButton){
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 5
        button.layer.cornerRadius = 10
    }
    
 


}

extension homeViewController{
    

    func checkUserDefualt(){
        
        //first time installed app
        if UserDefaults.standard.object(forKey: "ChapterOneQariOne") == nil{
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            createUserDefaults()
            
            print("Created now ")
        }
        
        // already installed app
        else{
                //check if the all the userdefaults are empty or not
            if firstViewDecision(){
                firstShowingView.isHidden = true
                progressTableView.isHidden = false
                progressTableView.reloadData()
            }
            else{
                progressTableView.isHidden = true
                firstShowingView.isHidden = false
            }
        }
    }
    
    func createUserDefaults(){
        //ChapterOneQariOne
        Firestore.firestore().collection("Users").whereField("id", isEqualTo: Auth.auth().currentUser?.uid as Any)
            .getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err.localizedDescription)")
                } else {
                    for document in querySnapshot!.documents {
                        
                        for i in 0...16{
                            UserDefaults.standard.set(document.get("Chapter\(chapterName[i])QariOne"), forKey: "Chapter\(chapterName[i])QariOne")
                            UserDefaults.standard.set(document.get("Chapter\(chapterName[i])QariTwo"), forKey: "Chapter\(self.chapterName[i])QariTwo")
                            UserDefaults.standard.set(chapterTotal[i], forKey: "Chapter\(chapterName[i])Total")
                            
                        }
                        
                        activityIndicator.stopAnimating()
                        activityIndicator.isHidden = true
                        
                        //check if the all the userdefaults are empty or not
                        if firstViewDecision(){
                            firstShowingView.isHidden = true
                            progressTableView.isHidden = false
                            progressTableView.reloadData()
                        }
                        else{
                            progressTableView.isHidden = true
                            firstShowingView.isHidden = false
                        }
                        
                    }
                    
                    
                    
                }
            }
        
    }
    
    func firstViewDecision()->Bool{
        var check = false
        
        for i in 0...16{
            if ((UserDefaults.standard.integer(forKey: "Chapter\(chapterName[i])QariOne") > 0) || (UserDefaults.standard.integer(forKey: "Chapter\(chapterName[i])QariTwo") > 0)) {
                check = true
            }
        }
        return check
    }
}
