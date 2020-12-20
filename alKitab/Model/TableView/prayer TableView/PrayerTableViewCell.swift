//
//  PrayerTableViewCell.swift
//  alKitab
//
//  Created by Hamza Butt on 12/11/2020.
//

import UIKit

class PrayerTableViewCell: UITableViewCell {

    @IBOutlet weak var shadedView: UIView!
    @IBOutlet weak var typeLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        maketheViewShadow(view: shadedView)
    }

    func maketheViewShadow(view:UIView){
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 10
        
    }
    func assignData(text:String){
        typeLable.text = text
        
    }
    
}
