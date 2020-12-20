//
//  ExtrasCollectionViewCell.swift
//  alKitab
//
//  Created by Hamza Butt on 12/11/2020.
//

import UIKit

class ExtrasCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var extrasView: UIView!
    @IBOutlet weak var extrasImage: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        maketheViewShadow(view: extrasView)
        
    }
    
    func maketheViewShadow(view:UIView){
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 10
    }
    func setData(image:UIImage,Label1:String,Label2:String){
        self.extrasImage.image = image
        self.label1.text = Label1
        self.label2.text = Label2
        
    }
    

}
