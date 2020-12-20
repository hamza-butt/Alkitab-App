//
//  easyLearningViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 16/11/2020.
//

import UIKit
import Network
import CoreData

class QariChoice: UIViewController {
    
    @IBOutlet weak var qari1View: UIView!
    @IBOutlet weak var qari2View: UIView!
    
    var arrayDataToDisplay:[String] = []
    var clickedIndex = Int()
    
    //ChapterOneQariOne
    let userDefaultArray = ["One", "Two", "Three","Four","Five","Six","Seven","Eight","Nine","Ten","Eleven","Twelve","Thirteen","Fourteen","Fifteen","Sixteen","Seventeen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("clciked index is \(clickedIndex)")
        maketheViewShadow(view: qari1View)
        maketheViewShadow(view: qari2View)
    }
    
    @IBAction func qari1BtnClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "QariOne") as! QariOne
        HomeViewController.modalPresentationStyle = .fullScreen
        
        HomeViewController.arrayDataToDisplay = arrayDataToDisplay
        HomeViewController.UserDefaultsName = "Chapter\(userDefaultArray[clickedIndex])QariOne"
        
        self.present(HomeViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func qari2BtnClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "QariTwo") as! QariTwo
        HomeViewController.modalPresentationStyle = .fullScreen
        
        HomeViewController.arrayDataToDisplay = arrayDataToDisplay
        HomeViewController.UserDefaultsName = "Chapter\(userDefaultArray[clickedIndex])QariTwo"
        
        self.present(HomeViewController, animated:true, completion:nil)
    }
    
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
}
extension QariChoice{
    
    func maketheViewShadow(view:UIView){
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 10
    }
    
}
