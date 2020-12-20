//
//  progressTableViewCell.swift
//  alKitab
//
//  Created by Hamza Butt on 27/11/2020.
//

import UIKit

class progressTableViewCell: UITableViewCell {

    @IBOutlet weak var mainVIew: UIView!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var qari1ProgressBar: UIProgressView!
    @IBOutlet weak var qari2ProgressBar: UIProgressView!
    
    @IBOutlet weak var qari1ProgressLabel: UILabel!
    @IBOutlet weak var qari2ProgressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        maketheViewShadow(view: mainVIew)
    }

    func maketheViewShadow(view:UIView){
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 10
        
        
    }
    
    func assignData(typeName:String,qari1AttainProgress:Int,qari2AttainProgress:Int,totalProgress:Int){
        typeLabel.text = typeName
        qari1ProgressBar.progress = Float(qari1AttainProgress) / Float(totalProgress)
        qari2ProgressBar.progress = Float(qari2AttainProgress) / Float(totalProgress)
        qari1ProgressLabel.text = ("\(qari1AttainProgress)/\(totalProgress)")
        qari2ProgressLabel.text = ("\(qari2AttainProgress)/\(totalProgress)")
       
    }

    
}
