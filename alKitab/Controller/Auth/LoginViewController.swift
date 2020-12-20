//
//  LoginViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 11/11/2020.
//

import UIKit
import Firebase


class LoginViewController: UIViewController, UITextFieldDelegate  {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    @IBOutlet weak var emailIng: UIImageView!
    
    @IBOutlet weak var passwordBtn: UIButton!
    
    @IBOutlet weak var qariSwitcg: UISwitch!
    
    @IBOutlet weak var loginBtnView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let userID : String = Auth.auth().currentUser?.uid ?? "nil"
    
    let toast = ShowToast()
    
    var loginAsLearner:Bool = true
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        activityIndicator.isHidden = true
        
        emailTextField.delegate = self
        passwordTextFiled.delegate = self
        
        emailIng.image = #imageLiteral(resourceName: "email _black")
        passwordBtn.setImage(UIImage(named: "password_black.png"), for: UIControl.State.normal)
        
        qariSwitcg.setOn(false, animated: false)
        
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(touch)
        
        
        maketheBtnShadow()
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        self.view.frame.origin.y = 0
        passwordTextFiled.isSecureTextEntry = true
    }
    func maketheBtnShadow(){
        
        loginBtnView.layer.shadowColor = UIColor.black.cgColor
        loginBtnView.layer.shadowOpacity = 0.2
        loginBtnView.layer.shadowOffset = .zero
        loginBtnView.layer.shadowRadius = 5
        loginBtnView.layer.cornerRadius = 10
        loginBtn.layer.cornerRadius = 10
        
    }
    
    @IBAction func LockBtnClicked(_ sender: UIButton) {
        
        // when the lock is closed
        if passwordBtn.currentImage!.isEqual(UIImage(named: "password")) {
            passwordBtn.setImage(UIImage(named: "unlock.png"), for: UIControl.State.normal)
            passwordTextFiled.isSecureTextEntry = false
        }
        else if passwordBtn.currentImage!.isEqual(UIImage(named: "password_black")){
            passwordBtn.setImage(UIImage(named: "unlock_black.png"), for: UIControl.State.normal)
            passwordTextFiled.isSecureTextEntry = false
        }
        
        // when the lock is open
        
        else if passwordBtn.currentImage!.isEqual(UIImage(named: "unlock")){
            passwordBtn.setImage(UIImage(named: "password.png"), for: UIControl.State.normal)
            passwordTextFiled.isSecureTextEntry = true
        }
        else{
            passwordBtn.setImage(UIImage(named: "password_black.png"), for: UIControl.State.normal)
            passwordTextFiled.isSecureTextEntry = true
        }
        
    }
    
    @IBAction func qariSwitchClicked(_ sender: UISwitch) {
        
        if qariSwitcg.isOn{
            loginAsLearner = false
        }
        else{
            loginAsLearner = true
        }
        
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        if  emailTextField.text == "" || passwordTextFiled.text == "" {
            toast.PresentToast(controller: self, message: "Please fill all the TextField", seconds: 0.4)
            return
        }
        if !checkEmail(emailTextField.text!){
            toast.PresentToast(controller: self, message: "Your email is Invalid", seconds: 0.4)
            return
        }
        startIndicator()
        loginUser()
        
    }
    
    @IBAction func forgerPasswordBtnClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    @IBAction func registerNowBtnClicked(_ sender: Any) {
        print("clicked")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    
    
}


//MARK:-                                    TEXTFIELD DELEGTE

extension LoginViewController{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.emailTextField:
            self.passwordTextFiled.becomeFirstResponder()
        default:
            dismissKeyboard()
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            print("email")
            emailIng.image = #imageLiteral(resourceName: "email")
        default:
            passwordBtn.setImage(UIImage(named: "password.png"), for: UIControl.State.normal)
            print("password")
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            print("email")
            emailIng.image = #imageLiteral(resourceName: "email _black")
        default:
            passwordBtn.setImage(UIImage(named: "password_black.png"), for: UIControl.State.normal)
            print("password")
        }
    }
}



extension LoginViewController{
    
    func checkEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK:-                            MAKE THE USER LOGIN
    
    func loginUser() {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password:passwordTextFiled.text!, completion: { [self](user, error) in
            if let firebaseError = error {
                
                self.stopIndicator()
                // create the alert
                let alert = UIAlertController(title: "ERROR", message: firebaseError.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            if Auth.auth().currentUser! != nil && Auth.auth().currentUser!.isEmailVerified {
                
                
                // all set   redirect to home screen
                self.getUserData()
                self.stopIndicator()
                
                
                if loginAsLearner{
                    print("login as learner ")
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
                    HomeViewController.modalPresentationStyle = .fullScreen
                    self.present(HomeViewController, animated:false, completion:nil)
                }
                else{
                    print("login as Qari ")
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "SelectLevelViewController") as! SelectLevelViewController
                    HomeViewController.modalPresentationStyle = .fullScreen
                    self.present(HomeViewController, animated:false, completion:nil)
                }
            }
            else{
                
                self.stopIndicator()
                self.presentAlert(heading: "Email Verification", message: "your Email is not Varified")
            }
        })
    }
    
    
    //MARK:-                                   ACTIVITY INDICATOR FUCN
    
    
    func startIndicator(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    func stopIndicator()  {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    //MARK:-                                 SHOW ALERT
    
    func presentAlert(heading:String,message:String){
        // create the alert
        let alert = UIAlertController(title: heading, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Re-Send", style: UIAlertAction.Style.default,handler: { (alert: UIAlertAction!) in
            self.startIndicator()
            self.sendVerificationMail()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK:-                                        RESENT VERIFICATION EMAIL AGAIN
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    public func sendVerificationMail() {
        
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                // Notify the user that the mail has sent or couldn't because of an error.
                if error != nil{
                    print(error?.localizedDescription)
                    return
                }
                
                self.stopIndicator()
                
                //success alert
                
                let alert = UIAlertController(title: "E-mail Verification" , message:"A verification message sent tou your email" ,preferredStyle:UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
            })
        }
        else {
            print("user already varified")
        }
    }
    
    //MARK:-                        GET USER NAME
    
    func getUserData() {
        Firestore.firestore().collection("Users").whereField("id", isEqualTo: userID)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        UserDefaults.standard.set(document["full name"] ?? "", forKey: "fullName")
                    }
                }
            }
        
    }
    
    
    
}


