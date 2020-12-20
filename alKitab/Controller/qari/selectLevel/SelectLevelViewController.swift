//
//  SelectLevelViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 25/11/2020.
//

import UIKit

class SelectLevelViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var selectLevelTableView: UITableView!
    var LearningModulesLevel:[String] = ["Easy","Medium","Hard","Expert"]
    var LearningModulesImages:[UIImage] = [#imageLiteral(resourceName: "a001"),#imageLiteral(resourceName: "c003"),#imageLiteral(resourceName: "f033"),#imageLiteral(resourceName: "f033")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectLevelTableView.register(UINib(nibName: "LearningTableViewCell", bundle: nil), forCellReuseIdentifier: "LearningTableViewCell")
    }
    

}

extension SelectLevelViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LearningModulesLevel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LearningTableViewCell", for: indexPath) as! LearningTableViewCell
        cell.assignData(image: LearningModulesImages[indexPath.row], text: LearningModulesLevel[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 140
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        switch LearningModulesLevel[indexPath.row] {
//        case "Easy":
//
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "easyQariViewController") as! easyQariViewController
//            HomeViewController.modalPresentationStyle = .fullScreen
//            self.present(HomeViewController, animated:true, completion:nil)
//            return
//        case "Medium":
//
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "mediumQariViewController") as! mediumQariViewController
//            HomeViewController.modalPresentationStyle = .fullScreen
//            self.present(HomeViewController, animated:true, completion:nil)
//            return
//        case "Hard":
//
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "hardQariViewController") as! hardQariViewController
//            HomeViewController.modalPresentationStyle = .fullScreen
//            self.present(HomeViewController, animated:true, completion:nil)
//            return
//        default:
//
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "ExpertLearningViewController") as! ExpertLearningViewController
//            HomeViewController.modalPresentationStyle = .fullScreen
//            self.present(HomeViewController, animated:true, completion:nil)
//            return
//        }
//    }
    
}
