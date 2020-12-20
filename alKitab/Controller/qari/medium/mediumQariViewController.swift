//
//  mediumQariViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 25/11/2020.
//

import UIKit

class mediumQariViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var mediumQariCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mediumQariCollectionView.register(UINib(nibName: "EMHLearningCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EMHLearningCollectionViewCell")
    }
    

    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

}
extension mediumQariViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapterTwo.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EMHLearningCollectionViewCell", for: indexPath) as! EMHLearningCollectionViewCell
        cell.assignData(image: chapterTwo[indexPath.row])
        return cell
    }
}
