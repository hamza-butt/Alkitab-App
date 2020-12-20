//
//  evaluationViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 24/11/2020.
//

import UIKit

class evaluationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}


extension evaluationViewController{
    @IBAction func homeClicked(_ sender: Any) {
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    @IBAction func learnCLicked(_ sender: Any) {
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "LearningMainViewController") as! LearningMainViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    @IBAction func evaluateClicked(_ sender: Any) {
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
