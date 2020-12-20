
import UIKit
import AVFoundation



class QariOne: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var qari1CollectionView: UICollectionView!
     
    var UserDefaultsName = String()
    var arrayDataToDisplay:[String] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        qari1CollectionView.register(UINib(nibName: "EMHLearningCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EMHLearningCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        qari1CollectionView.reloadData()
    }
    

    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
}

//MARK:-                               COLLECTIONVIEW DELEGETE

extension QariOne{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayDataToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EMHLearningCollectionViewCell", for: indexPath) as! EMHLearningCollectionViewCell
        
        // when the colletionview reload for the first time
        if indexPath.row == UserDefaults.standard.integer(forKey: UserDefaultsName)
        {
            cell.viewAboveImage.backgroundColor = UIColor.clear
        }
        
        // assign colour to all of the learning characters
        else if UserDefaults.standard.integer(forKey: UserDefaultsName) >= indexPath.row{
            
            cell.viewAboveImage.backgroundColor = UIColor(red: 51/255, green: 154/255, blue: 0/255, alpha: 0.5)

        }
        
        // remaining character
        else{
            cell.viewAboveImage.backgroundColor = UIColor.lightGray
        }
        
        cell.assignData(image: arrayDataToDisplay[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:  UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width
        return CGSize(width: width * 0.25, height: width  * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        //row == indexPath.row sure that only next cell will be clicked
        //row<=easyLearningImages.count ensure that the row will not be exceed 29 in this case

        if UserDefaults.standard.integer(forKey: UserDefaultsName) == indexPath.row && UserDefaults.standard.integer(forKey: UserDefaultsName)<=arrayDataToDisplay.count{
            sendToNextController(indexPath: indexPath)
        }

        //enable when the previos cell in clicked

        if UserDefaults.standard.integer(forKey: UserDefaultsName) > indexPath.row{
            sendToNextController(indexPath: indexPath)
        }



        }
    
    func sendToNextController(indexPath: IndexPath){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "showDetailLernerViewController") as! showDetailLernerViewController
        
        HomeViewController.imageToDisplay = arrayDataToDisplay[indexPath.row]
        HomeViewController.clickedIndex = indexPath.row
        HomeViewController.qariNumber = "(q1)"
        HomeViewController.userDefaultName = UserDefaultsName
        
        
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:true, completion:nil)
          
    }
        
    
}

