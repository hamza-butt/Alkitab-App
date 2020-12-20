//
//  easyQariViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 25/11/2020.
//

import UIKit

class easyQariViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var easyQariCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        easyQariCollectionView.register(UINib(nibName: "EMHLearningCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EMHLearningCollectionViewCell")
    }
    
    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
   

}

extension easyQariViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapterOne.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EMHLearningCollectionViewCell", for: indexPath) as! EMHLearningCollectionViewCell
        cell.assignData(image: chapterOne[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "showDetailViewController") as! showDetailViewController
        HomeViewController.selectedImage = chapterOne[indexPath.row]
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:true, completion:nil)
    }
}
