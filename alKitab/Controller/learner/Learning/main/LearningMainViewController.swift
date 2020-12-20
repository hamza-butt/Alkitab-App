//
//  LearningMainViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 28/11/2020.
//

import UIKit

class LearningMainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var learningMainTableView: UITableView!
    var LearningMainModulesLevel:[String] = ["Quran","Prayer","Qalma"]
    var LearningMainModulesImages:[UIImage] = [#imageLiteral(resourceName: "quran1"),#imageLiteral(resourceName: "prayer"),#imageLiteral(resourceName: "splash_icon_2.png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        learningMainTableView.register(UINib(nibName: "LearningTableViewCell", bundle: nil), forCellReuseIdentifier: "LearningTableViewCell")
    }
    
    
    
}



extension LearningMainViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LearningMainModulesLevel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LearningTableViewCell", for: indexPath) as! LearningTableViewCell
        cell.assignData(image: LearningMainModulesImages[indexPath.row], text: LearningMainModulesLevel[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone{
            return 140
        }
        else{
            return 210
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch LearningMainModulesLevel[indexPath.row] {
        case "Quran":
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "LearningViewController") as! LearningViewController
            HomeViewController.modalPresentationStyle = .fullScreen
            self.present(HomeViewController, animated:true, completion:nil)
            return
        case "Prayer":
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "PrayerViewController") as! PrayerViewController
            HomeViewController.modalPresentationStyle = .fullScreen
            self.present(HomeViewController, animated:true, completion:nil)
            return
        default:
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "QalmaViewController") as! QalmaViewController
            HomeViewController.modalPresentationStyle = .fullScreen
            self.present(HomeViewController, animated:true, completion:nil)
            return
        }
    }
}
extension LearningMainViewController{
    @IBAction func homeClicked(_ sender: Any) {
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    @IBAction func learnCLicked(_ sender: Any) {
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








