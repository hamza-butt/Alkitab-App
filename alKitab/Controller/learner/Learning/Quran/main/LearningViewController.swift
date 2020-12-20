//
//  LearningViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 16/11/2020.
//

import UIKit

class LearningViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var learningTableView: UITableView!
    
    var LearningModulesLevel:[String] = ["The Aplhabets","Joint Letters","The Muqattiat Letters","The movements","The Thanveen","The Tanveen and Movement","Standing Fatha, Standing Kasrah and standing Dhuma","The Maddeoleen","Standing Fatha, Kasrah, Dhu,a, Maddoleen or Tanveen","The Skoon and Jazm","The Exercise of Sakoon","The Tashdeed","Exersice of Tashdeed","Tashdeed With Sakoon","Tashdeed With Sakoon","Tashdeed With Tashdeed","Tashdeed With Harof Madah"]
    
    var chaptersNames:[[String]] = [chapterOne,chapterTwo,chapterThree,chapterFour,chapterFive,chapterSix,chapterSeven,chapterEight,chapterNine,chapterTen,chapterEleven,chapterTwelve,chapterThirteen,chapterFourteen,chapterFifteen,chapterSixteen,chapterSeventeen]
    
    
    var LearningModulesImages:[UIImage] = [#imageLiteral(resourceName: "a001"),#imageLiteral(resourceName: "c003"),#imageLiteral(resourceName: "f033"),#imageLiteral(resourceName: "f033")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        learningTableView.register(UINib(nibName: "LearningTableViewCell", bundle: nil), forCellReuseIdentifier: "LearningTableViewCell")

    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    


}
extension LearningViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LearningModulesLevel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LearningTableViewCell", for: indexPath) as! LearningTableViewCell
       // cell.assignData(image: LearningModulesImages[indexPath.row], text: LearningModulesLevel[indexPath.row])
        cell.learningLabel.text = LearningModulesLevel[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "QariChoice") as! QariChoice
        
        //array which is going to display
        HomeViewController.arrayDataToDisplay = chaptersNames[indexPath.row]
        //index which is clicked by the user
        HomeViewController.clickedIndex = indexPath.row
    
        
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:true, completion:nil)

    }
    
}

