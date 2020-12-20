//
//  MaleViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 12/11/2020.
//

import UIKit

class FemaleViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    var prayerParts:[String] = ["Before Starting the prayer","Starting the prayer","In standing position"]
    @IBOutlet weak var feMaleCollectionView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feMaleCollectionView.register(UINib(nibName: "PrayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PrayerTableViewCell")
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    

}
extension FemaleViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerParts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrayerTableViewCell", for: indexPath) as! PrayerTableViewCell
        cell.assignData(text: prayerParts[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked")
    }
    
}
