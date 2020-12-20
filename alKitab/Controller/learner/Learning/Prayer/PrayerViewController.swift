//
//  PrayerViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 12/11/2020.
//

import UIKit

class PrayerViewController: UIViewController {

    @IBOutlet weak var maleVIew: UIView!
    @IBOutlet weak var feMaleView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        maketheViewShadow(view: maleVIew)
        maketheViewShadow(view: feMaleView)
    }
    
    func maketheViewShadow(view:UIView){
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 10
        
    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func maleBtnClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "MaleViewController") as! MaleViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:true, completion:nil)
    }
    
    @IBAction func femaleBtnClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "FemaleViewController") as! FemaleViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:true, completion:nil)
    }
}
