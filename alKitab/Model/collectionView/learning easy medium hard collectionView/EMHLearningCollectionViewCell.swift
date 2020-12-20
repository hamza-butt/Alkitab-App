//
//  EMHLearningCollectionViewCell.swift
//  alKitab
//
//  Created by Hamza Butt on 16/11/2020.
//

import UIKit
//protocol  ChangeCellBackgroundDelegete {
//    func changeCellBackground(_ cell: EMHLearningCollectionViewCell)
//}

class EMHLearningCollectionViewCell: UICollectionViewCell {

    //var addCardiewCellDelegete:ChangeCellBackgroundDelegete?
    
    @IBOutlet weak var characterView: UIView!
    @IBOutlet weak var viewAboveImage: UIView!
    @IBOutlet weak var characterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        maketheViewShadow(view: characterView)
        maketheViewShadow(view: viewAboveImage)
    }

    func maketheViewShadow(view:UIView){
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 10
    }
    func assignData(image:String){
        characterImage.image = UIImage(named: image)
    }
    
   
    
    
}
