//
//  ForgetPasswordViewController.swift
//  alKitab
//
//  Created by Hamza Butt on 11/11/2020.
//

import UIKit
import ACFloatingTextfield_Swift
import Firebase

class ForgetPasswordViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailIng: UIImageView!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var forgetPasswordBtnView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let toast = ShowToast()
    
    let userID : String = Auth.auth().currentUser?.uid ?? "nil"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopIndicator()
        
        emailTextField.delegate = self
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(touch)
        
        maketheBtnShadow()
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
        self.view.frame.origin.y = 0
    }
    
    func maketheBtnShadow(){
        
        forgetPasswordBtnView.layer.shadowColor = UIColor.black.cgColor
        forgetPasswordBtnView.layer.shadowOpacity = 0.2
        forgetPasswordBtnView.layer.shadowOffset = .zero
        forgetPasswordBtnView.layer.shadowRadius = 5
        forgetPasswordBtnView.layer.cornerRadius = 10
        forgetPasswordBtn.layer.cornerRadius = 10
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func forgetPasswordBtnClicked(_ sender: Any) {
        if emailTextField.text == ""{
            toast.PresentToast(controller: self, message: "Please Enter the email", seconds: 0.4)
            return
        }
        if !checkEmail(emailTextField.text!){
            toast.PresentToast(controller: self, message: "Your email is Invalid", seconds: 0.4)
            return
        }
        // all set
        startIndicator()
        emailReset()
    }
    
    
}

//MARK:-                        TEXTFIELD DELEGETE

extension ForgetPasswordViewController{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailIng.image = #imageLiteral(resourceName: "email")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailIng.image = #imageLiteral(resourceName: "email _black")
    }
}


extension ForgetPasswordViewController{
    
    //MARK:-                          CHECK EMAIL
    
    func checkEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK:-                        RESET THE EMAIL
    
    func emailReset() {
        
        // send reset email
        
        Auth.auth().sendPasswordReset(withEmail: self.emailTextField.text!) { [self] (error) in
            if error != nil{
                
                self.stopIndicator()
                
                // show warning alert
                let alert = UIAlertController(title: "ERROR", message:error?.localizedDescription,preferredStyle:UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default,handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            }
            
            else{
                
                self.stopIndicator()
                
                // show success alert
                let alert = UIAlertController(title: "SUCCESS", message:"Check your email",preferredStyle:UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default,handler: { (alert: UIAlertAction!) in
                    self.dismiss(animated: false, completion: nil)
                }))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    //MARK:-                       ACTIVITY INDICATOR
    
    func startIndicator(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    func stopIndicator()  {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
}


