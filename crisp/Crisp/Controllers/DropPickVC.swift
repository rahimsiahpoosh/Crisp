//
//  DropPickVC.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-08.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class DropPickVC: UIViewController, UITextFieldDelegate {
    
    var order: Order!
    var buttondate: String?
    
    
    @IBOutlet weak var datePickUp: ButtonRadius!
    @IBOutlet weak var timePickUp: ButtonRadius!
    @IBOutlet weak var dateDropOff: ButtonRadius!
    @IBOutlet weak var timeDropOff: ButtonRadius!
    
    @IBOutlet weak var addressPickUpTextField: UITextField!
    @IBOutlet weak var entryCodePickUpTextField: UITextField!
    
    @IBOutlet weak var addressDropUpTextField: UITextField!
    @IBOutlet weak var entryCodeDropUpTextField: UITextField!
    
    var testTrue : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addDoneButtonOnKeyboard()
        order.pick = TimeAddress()
        order.drop = TimeAddress()

        if order.pick.time != "" {
            print(order.pick.time)
        } else {
            print("There is no pick time")
        }

    }
    
    
    @IBAction func timeBtn(_ sender: Any) {
        
        addressDropUpTextField.resignFirstResponder()
        entryCodeDropUpTextField.resignFirstResponder()
        }
    
    func buttonchange(buttonText: String) {

    }
    
    // Start Editing The Text Field. This is where the keybord shows.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -200, up: true)
        testTrue = false
    }
    
    // Finish Editing The Text Field Keybord is hidden
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -200, up: false)
        testTrue = true
        
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
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(DropPickVC.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.addressPickUpTextField.inputAccessoryView = doneToolbar
        self.addressDropUpTextField.inputAccessoryView = doneToolbar
        self.entryCodePickUpTextField.inputAccessoryView = doneToolbar
        self.entryCodeDropUpTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        
        self.addressPickUpTextField.resignFirstResponder()
        self.addressDropUpTextField.resignFirstResponder()
        self.entryCodePickUpTextField.resignFirstResponder()
        self.entryCodeDropUpTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickUpDateVC" {
            let destinationController = segue.destination as! PickUpDateVC
            destinationController.order = order
//            date.setTitle(order.pick.date, for: .normal)
        }
        if segue.identifier == "PickUpTimeVC" {
            let destinationController = segue.destination as! PickUpTimeVC
            destinationController.order = order
        }
        if segue.identifier == "DropDateVC" {
            let destinationController = segue.destination as! DropDateVC
            destinationController.order = order
        }
        if segue.identifier == "DropTimeVC" {
            let destinationController = segue.destination as! DropTimeVC
            destinationController.order = order
        }
        if segue.identifier == "ConfirmVC" {
            let destinationController = segue.destination as! ConfirmVC
            destinationController.order = order
        }
    }
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if sender.source is PickUpDateVC {
            if let senderVC = sender.source as? PickUpDateVC {
                    datePickUp.setTitle(senderVC.order.pick.date, for: .normal)
                    print("No date set")
            }
        }
        if sender.source is PickUpTimeVC {
            if let senderVC = sender.source as? PickUpTimeVC {
                if order.pick.time != "" {
                    timePickUp.setTitle(senderVC.order.pick.time, for: .normal)
                } else {
                    timePickUp.setTitle("Glöm inte att välj tid", for: .normal)
                }
                
            }
        }
        if sender.source is DropDateVC {
            if let senderVC = sender.source as? DropDateVC {
                dateDropOff.setTitle(senderVC.order.drop.date, for: .normal)
            }
        }
        if sender.source is DropTimeVC {
            if let senderVC = sender.source as? DropTimeVC {
                if order.drop.time != "" {
                    timeDropOff.setTitle(senderVC.order.drop.time, for: .normal)
                } else {
                    timeDropOff.setTitle("Glöm inte att välja tid", for: .normal)
                }
                
            }
        }
    }
    
    func isStringAnInt(pickEntryCode: String, dropEntryCode: String) {
        
        if Int(pickEntryCode) != nil {
            order.pick.entryCode = Int(pickEntryCode)!
            print("PickEntryCode can be casted")
        } else {
            order.pick.entryCode = 0
            print("cant pass a value because the string can't be casted")
        }
        
        if Int(dropEntryCode) != nil {
            order.drop.entryCode = Int(dropEntryCode)!
            print("DropEntryCode can be casted")
        } else {
            order.drop.entryCode = 0
            print("cant pass a value because the string can't be casted")
        }
        
    }
    
    @IBAction func back(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmDropPick(_ sender: Any) {
        
        
        let orderService = (UIApplication.shared.delegate as! AppDelegate).orderService
        let errorMsg = orderService.validate(PickUpDate: order.pick.date, DropDate: order.drop.date, PickTime: order.pick.time
            , DropTime: order.drop.time, PickAddress: addressPickUpTextField.text!, DropAddress: addressDropUpTextField.text!)
        if errorMsg != "" {
            let alert = UIAlertController(title: "Alert", message: errorMsg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:
                "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            order.pick.address = addressPickUpTextField.text
            order.drop.address = addressDropUpTextField.text
            isStringAnInt(pickEntryCode: entryCodePickUpTextField.text!, dropEntryCode: entryCodeDropUpTextField.text!)
            performSegue(withIdentifier: "ConfirmVC", sender: nil)
       }
    }
}
