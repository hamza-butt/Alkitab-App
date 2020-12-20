//
//  SignUpViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 11/11/2020.
//

import UIKit
import Firebase
import ACFloatingTextfield_Swift


class SignUpViewController: UIViewController ,UITextFieldDelegate{
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var emailIng: UIImageView!
    @IBOutlet weak var confirmPasswordBtn: UIButton!
    
    
    @IBOutlet weak var loginBtnView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let toast = ShowToast()
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        emailIng.image = #imageLiteral(resourceName: "email _black")
        confirmPasswordBtn.setImage(UIImage(named: "password_black.png"), for: UIControl.State.normal)
        
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(touch)
        
        maketheBtnShadow()
        
        
        
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        self.view.frame.origin.y = 0
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
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
        if confirmPasswordBtn.currentImage!.isEqual(UIImage(named: "password")) {
            confirmPasswordBtn.setImage(UIImage(named: "unlock.png"), for: UIControl.State.normal)
            passwordTextField.isSecureTextEntry = false
            confirmPasswordTextField.isSecureTextEntry = false
        }
        else if confirmPasswordBtn.currentImage!.isEqual(UIImage(named: "password_black")){
            confirmPasswordBtn.setImage(UIImage(named: "unlock_black.png"), for: UIControl.State.normal)
            passwordTextField.isSecureTextEntry = false
            confirmPasswordTextField.isSecureTextEntry = false
            
        }
        
        // when the lock is open
        
        else if confirmPasswordBtn.currentImage!.isEqual(UIImage(named: "unlock")){
            confirmPasswordBtn.setImage(UIImage(named: "password.png"), for: UIControl.State.normal)
            passwordTextField.isSecureTextEntry = true
            confirmPasswordTextField.isSecureTextEntry = true
            
        }
        else{
            confirmPasswordBtn.setImage(UIImage(named: "password_black.png"), for: UIControl.State.normal)
            passwordTextField.isSecureTextEntry = true
            confirmPasswordTextField.isSecureTextEntry = true
            
        }
        
    }
    
    
    //MARK:-                    SIGN BTN CLICKED
    
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        
        if nameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextField.text == ""{
            toast.PresentToast(controller: self, message: "Please fill all the TextField", seconds: 0.4)
            return
        }
        if !checkName(testStr: nameTextField.text!){
            toast.PresentToast(controller: self, message: "Your Name is Invalid", seconds: 0.4)
            return
        }
        if !checkEmail(emailTextField.text!){
            toast.PresentToast(controller: self, message: "Your email is Invalid", seconds: 0.4)
            return
        }
        if passwordTextField.text != confirmPasswordTextField.text{
            toast.PresentToast(controller: self, message: "Password and Confirm password are not same", seconds: 0.4)
            return
        }
        //all set
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        createAccount()
        
        
    }
    
    //MARK:-                    LOGIN BTN CLICKED
    
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        HomeViewController.modalPresentationStyle = .fullScreen
        self.present(HomeViewController, animated:false, completion:nil)
    }
    
    
}

//MARK:-                            TEXTFIELD DELEGETE AND FUNCTIONS

extension SignUpViewController{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.nameTextField:
            self.emailTextField.becomeFirstResponder()
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.confirmPasswordTextField.becomeFirstResponder()
        default:
            dismissKeyboard()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            emailIng.image = #imageLiteral(resourceName: "email")
        case self.confirmPasswordTextField:
            self.view.frame.origin.y = -70
        default:
            confirmPasswordBtn.setImage(UIImage(named: "password.png"), for: UIControl.State.normal)
            
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.emailTextField:
            emailIng.image = #imageLiteral(resourceName: "email _black")
        case self.confirmPasswordTextField:
            self.view.frame.origin.y = 0
        default:
            confirmPasswordBtn.setImage(UIImage(named: "password_black.png"), for: UIControl.State.normal)
            
        }
    }
    
    
    // checking the textfields
    func checkName(testStr:String) -> Bool {
        guard testStr.count > 7, testStr.count < 18 else { return false }
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
    func checkEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}


//MARK:-                    FIREBASE SIGNUP FUNCTIONS

extension SignUpViewController{
    
    func createAccount() {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { user, error in
            
            if error != nil {
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                
                // show alert
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription,preferredStyle:UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in
                    self.dismiss(animated: true, completion: nil)
                }))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                return
                
            }
            
            self.sendVerificationMail()
            
        })
    }
    
    
    //MARK:-                    SEND VERIFICATION CODE
    
    
    public func sendVerificationMail() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { [self] (error) in
                // Notify the user that the mail has sent or couldn't because of an error.
                if error != nil{
                    print(error?.localizedDescription)
                    return
                }
                
                // all set    saving data to the firestore
                
                self.addDocument(id: self.authUser?.uid ?? "nill", fullName: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!,  collectionName: "Users")
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                
                self.presentAlert(heading: "E-mail Verification", message: "A verification message sent tou your email")
                
                
            })
        }
        else {
            // Either the user is not available, or the user is already verified.
            print("user already varified")
        }
    }
    
    //MARK:-                   ADD DOCUMENTS
    
    
    func addDocument(id:String , fullName:String , email:String , password:String , collectionName:String){
        
        var ref: DocumentReference? = nil
        ref = Firestore.firestore().collection(collectionName).addDocument(data: [
            "id":  id,
            "full name": fullName,
            "email": email,
            "password": password,
            
            "ChapterOneQariOne":0,
            "ChapterOneQariTwo":0,
            "ChapterTwoQariOne":0,
            "ChapterTwoQariTwo":0,
            "ChapterThreeQariOne":0,
            "ChapterThreeQariTwo":0,
            "ChapterFourQariOne":0,
            "ChapterFourQariTwo":0,
            "ChapterFiveQariOne":0,
            "ChapterFiveQariTwo":0,
            "ChapterSixQariOne":0,
            "ChapterSixQariTwo":0,
            "ChapterSevenQariOne":0,
            "ChapterSevenQariTwo":0,
            "ChapterEightQariOne":0,
            "ChapterEightQariTwo":0,
            "ChapterNineQariOne":0,
            "ChapterNineQariTwo":0,
            "ChapterTenQariOne":0,
            "ChapterTenQariTwo":0,
            "ChapterElevenQariOne":0,
            "ChapterElevenQariTwo":0,
            "ChapterTwelveQariOne":0,
            "ChapterTwelveQariTwo":0,
            "ChapterThirteenQariOne":0,
            "ChapterThirteenQariTwo":0,
            "ChapterFourteenQariOne":0,
            "ChapterFourteenQariTwo":0,
            "ChapterFifteenQariOne":0,
            "ChapterFifteenQariTwo":0,
            "ChapterSixteenQariOne":0,
            "ChapterSixteenQariTwo":0,
            "ChapterSeventeenQariOne":0,
            "ChapterSeventeenQariTwo":0
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err.localizedDescription)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    
    //MARK:-                    SHOW ALERT
    
    
    func presentAlert(heading:String,message:String){
        // show alert
        let alert = UIAlertController(title: heading , message:message ,preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in
            self.dismiss(animated: true) {
                
                // sent to login screen
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let HomeViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                HomeViewController.modalPresentationStyle = .fullScreen
                self.present(HomeViewController, animated:false, completion:nil)
            }
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
}


