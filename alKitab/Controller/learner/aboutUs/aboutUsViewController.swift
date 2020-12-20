
import UIKit

class aboutUsViewController: UIViewController {
    
    @IBOutlet weak var inayatImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var inayatImageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var saifImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var saifImageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var wajeehImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var wajeehImageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var awaisImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var awaisImageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var hamzatImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var hamzatImageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inayatImage: UIImageView!
    @IBOutlet weak var saifImage: UIImageView!
    
    @IBOutlet weak var wajeehImage: UIImageView!
    @IBOutlet weak var awaisImage: UIImageView!
    @IBOutlet weak var hamzaImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(view.frame.width)
        // Do any additional setup after loading the view.
        assignConstarintToSupervoiser(height: inayatImageHeightConstraint, width: inayatImageWidthConstraint)
        assignConstarintToSupervoiser(height: saifImageHeightConstraint, width: saifImageWidthConstraint)
        
        assignConstarintToDeveloper(height: wajeehImageHeightConstraint, width: wajeehImageWidthConstraint)
        assignConstarintToDeveloper(height: awaisImageHeightConstraint, width: awaisImageWidthConstraint)
        assignConstarintToDeveloper(height: hamzatImageHeightConstraint, width: hamzatImageWidthConstraint)
        
        
        
        makeTheImageRoundSupervoiser(image: inayatImage)
        makeTheImageRoundSupervoiser(image: saifImage)

        makeTheImageRoundDeveloper(image: wajeehImage)
        makeTheImageRoundDeveloper(image: awaisImage)
        makeTheImageRoundDeveloper(image: hamzaImage)
    }
    
    
    
    
}


extension aboutUsViewController{
    @IBAction func homeClicked(_ sender: Any) {
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    @IBAction func learnCLicked(_ sender: Any) {
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "LearningMainViewController") as! LearningMainViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    @IBAction func evaluateClicked(_ sender: Any) {
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "evaluationViewController") as! evaluationViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    @IBAction func extraClicked(_ sender: Any) {
        // move to home controller
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "extrasViewController") as! extrasViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    @IBAction func aboutClicked(_ sender: Any) {
        
    }
    
}


extension aboutUsViewController{
    
    func assignConstarintToSupervoiser(height:NSLayoutConstraint , width:NSLayoutConstraint){
        height.constant = view.frame.height * 0.15
        width.constant = view.frame.height * 0.15
    }
    func assignConstarintToDeveloper(height:NSLayoutConstraint , width:NSLayoutConstraint){
        height.constant = view.frame.height * 0.12
        width.constant = view.frame.height * 0.12
    }
    func makeTheImageRoundSupervoiser(image:UIImageView){
        image.layer.masksToBounds = false
        if view.frame.width <= 414{
            image.layer.cornerRadius = view.frame.width / 8
        }
        else{
            image.layer.cornerRadius = view.frame.width / 6.5
        }
        image.clipsToBounds = true
    }
    
    func makeTheImageRoundDeveloper(image:UIImageView){
        image.layer.masksToBounds = false
        if view.frame.width <= 414{
            image.layer.cornerRadius = view.frame.width / 10
        }
        else{
            image.layer.cornerRadius = view.frame.width / 8
        }
        image.clipsToBounds = true
    }
    
}
