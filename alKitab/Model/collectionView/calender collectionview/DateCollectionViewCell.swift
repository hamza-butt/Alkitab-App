//
//  DateCollectionViewCell.swift
//  alKitab
//
//  Created by Hamza Butt on 14/11/2020.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func  changeLabelColour(){
        dateLabel.backgroundColor = .red
        dateLabel.layer.shadowColor = UIColor.black.cgColor
        dateLabel.layer.shadowOpacity = 0.2
        dateLabel.layer.shadowOffset = .zero
        dateLabel.layer.shadowRadius = 5
        dateLabel.layer.cornerRadius = 5
    }

}
