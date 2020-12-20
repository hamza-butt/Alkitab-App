//
//  LearningTableViewCell.swift
//  alKitab
//
//  Created by Hamza Butt on 16/11/2020.
//

import UIKit

class LearningTableViewCell: UITableViewCell {

    @IBOutlet weak var learningView: UIView!
    @IBOutlet weak var learningImg: UIImageView!
    @IBOutlet weak var learningLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        maketheViewShadow(view: learningView)
    }
    
    func maketheViewShadow(view:UIView){
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 10
    }
    func assignData(image:UIImage,text:String){
        learningImg.image = image
        learningLabel.text = text
    }

    
    
}
