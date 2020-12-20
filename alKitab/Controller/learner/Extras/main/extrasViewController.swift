//
//  extrasViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 12/11/2020.
//

import UIKit

class extrasViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var extrasCollectionView: UICollectionView!
    
    var ImgArray:[UIImage] = [#imageLiteral(resourceName: "tajweed"),#imageLiteral(resourceName: "compass"),#imageLiteral(resourceName: "calender"),#imageLiteral(resourceName: "timing")]
    var ImgLabel1:[String] = ["Tajweed","Qibla","Islamic","Prayer"]
    var ImgLabel2:[String] = ["rules","direction","Calender","Timing"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maketheViewCirlce()
        
        extrasCollectionView.register(UINib(nibName: "ExtrasCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExtrasCollectionViewCell")
    }
    
    
    func maketheViewCirlce(){
        
        roundedView.layer.cornerRadius = roundedView.frame.height/2
    }
    

   

}
extension extrasViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExtrasCollectionViewCell", for: indexPath) as! ExtrasCollectionViewCell
        cell.setData(image: ImgArray[indexPath.row], Label1: ImgLabel1[indexPath.row], Label2: ImgLabel2[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width
        return CGSize(width: width * 0.4, height: width  * 0.4)
        
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if ImgLabel2[indexPath.row] == "rules"{
            
            
        }
        else if ImgLabel2[indexPath.row] == "direction"{
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "QiblaDirectionViewController") as! QiblaDirectionViewController
            HomeViewController.modalPresentationStyle = .fullScreen
            self.present(HomeViewController, animated:true, completion:nil)
        }
        else if ImgLabel2[indexPath.row] == "Calender"{
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "HijriCalenderViewController") as! HijriCalenderViewController
            HomeViewController.modalPresentationStyle = .fullScreen
            self.present(HomeViewController, animated:true, completion:nil)
        }
        else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "PrayerTimingViewController") as! PrayerTimingViewController
            HomeViewController.modalPresentationStyle = .fullScreen
            self.present(HomeViewController, animated:true, completion:nil)
        }
       
    }

}


extension extrasViewController{
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
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "evaluationViewController") as! evaluationViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    @IBAction func extraClicked(_ sender: Any) {
        
    }
    @IBAction func aboutClicked(_ sender: Any) {
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "aboutUsViewController") as! aboutUsViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    
}
