//
//  CreateAccountVC.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-07.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateAccountVC: UIViewController, UITextFieldDelegate {
    
    var ref: DatabaseReference!

    @IBOutlet weak var firstNameTextField: TextField!
    @IBOutlet weak var sirNameTextField: TextField!
    @IBOutlet weak var addressTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ref = Database.database().reference().child("Crisp")
        
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        if (firstNameTextField.text?.isEmpty)! && (sirNameTextField.text?.isEmpty)! && (addressTextField.text?.isEmpty)! && (emailTextField.text?.isEmpty)! && (passwordTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "ALERT", message: "Fyll i fälten, förnamn, Efternamn, Email och lösen.", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        if firstNameTextField.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Var god och fyll i förnamnet", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if sirNameTextField.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Var god och fyll i efternamnet", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if (addressTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Alert", message: "Var god och fyll i address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if (emailTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Alert", message: "Var god och fyll i email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: emailTextField.text!)
        
        if isEmailAddressValid == true{
            print("Email address is valid")
        } else {
            print("Email address is not valid")
            let alert = UIAlertController(title: "Alert", message: "Din email är inte validerad", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if (passwordTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Alert", message: "Var god och fyll i email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if passwordTextField.text!.characters.count <= 5 {
            let alert = UIAlertController(title: "Alert", message: "Minst 6 tecken", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        createAccount()
    }
    
    func createAccount() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                print(error)
            }else {
                let uid = user?.uid
                let personalInfo = ["firstname": self.firstNameTextField.text! as String,
                                    "lastname": self.sirNameTextField.text! as String,
                                    "address": self.addressTextField.text! as String]
                print(uid)
                self.ref.child(uid!).child("Customer").setValue(personalInfo)
                print("There should be a member")
            }
        }
    }
    
    // Start Editing The Text Field. This is where the keybord shows.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -75, up: true)
    }

    // Finish Editing The Text Field Keybord is hidden
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -75, up: false)

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }


}
