//
//  MaleViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 12/11/2020.
//

import UIKit

class MaleViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    

    @IBOutlet weak var maleCollectionView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var test:[String] = ["Niyah","Takbeer e Tehreema ","Qalma"]
        maleCollectionView.register(UINib(nibName: "PrayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PrayerTableViewCell")
      
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
extension MaleViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrayerTableViewCell", for: indexPath) as! PrayerTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked")
    }
}
