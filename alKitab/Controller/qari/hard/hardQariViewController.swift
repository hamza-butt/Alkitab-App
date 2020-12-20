//
//  hardQariViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 25/11/2020.
//

import UIKit

class hardQariViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var hardQariCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hardQariCollectionView.register(UINib(nibName: "EMHLearningCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EMHLearningCollectionViewCell")
    }
    

    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

}
extension hardQariViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapterThree.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EMHLearningCollectionViewCell", for: indexPath) as! EMHLearningCollectionViewCell
        cell.assignData(image: chapterThree[indexPath.row])
        return cell
    }
}
