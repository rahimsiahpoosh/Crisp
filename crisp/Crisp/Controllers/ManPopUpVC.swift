//
//  ManPopUpVC.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-07.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class ManPopUpVC: UIViewController, UITextFieldDelegate , UITextViewDelegate{


    @IBOutlet weak var popupView: UIView!
   
    @IBOutlet weak var nrShirtsTextField: UITextField!
    @IBOutlet weak var nrShirtsPackageTextField: UITextField!
    @IBOutlet weak var nrSuitsTextField: UITextField!
    @IBOutlet weak var nrSuitJacketsTextField: UITextField!
    @IBOutlet weak var nrPantsTextField: UITextField!
    @IBOutlet weak var nrSmokingTextField: UITextField!
    @IBOutlet weak var nrSmokingShirtTextField: UITextField!
    
    
    @IBOutlet weak var sum: UILabel!
    
    @IBOutlet weak var commentsTextView: UITextView!
    
    var order: Order!
    var shirts: Item!
    var shirtsPackages: Item!
    var suits: Item!
    var suitsJackets: Item!
    var pants: Item!
    var smokings: Item!
    var smokingsShirts: Item!
    var price = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("It there is a \(order.categories[1].comment)")
        sum.text = "\(order.sum!) kr"
        shirts = order.categories[1].items.filter({ (item) -> Bool in
            item.name == "shirts"
        }).first!
        shirtsPackages = order.categories[1].items.filter({ (item) -> Bool in
            item.name == "shirt 5 pack"
        }).first!
        suits = order.categories[1].items.filter({ (item) -> Bool in
            item.name == "suits"
        }).first!
        suitsJackets = order.categories[1].items.filter({ (item) -> Bool in
            item.name == "suitjackets"
        }).first!
        
        pants = order.categories[1].items.filter({ (item) -> Bool in
            item.name == "pants"
        }).first!
        
        smokings = order.categories[1].items.filter({ (item) -> Bool in
            item.name == "smokings"
        }).first!
        smokingsShirts = order.categories[1].items.filter({ (item) -> Bool in
            item.name == "smokings shirts"
        }).first!
        
        self.nrShirtsTextField.text = String(shirts.quantity)
        shirts.price = 25
        self.nrShirtsPackageTextField.text = String(shirtsPackages.quantity)
        shirtsPackages.price = 100
        self.nrSuitsTextField.text = String(suits.quantity)
        suits.price = 200
        self.nrSuitJacketsTextField.text = String(suitsJackets.quantity)
        suitsJackets.price = 140
        self.nrPantsTextField.text = String(pants.quantity)
        pants.price = 130
        self.nrSmokingTextField.text = String(smokings.quantity)
        smokings.price = 250
        self.nrSmokingShirtTextField.text = String(smokingsShirts.quantity)
        smokingsShirts.price = 30
        self.commentsTextView.text = order.categories[1].comment
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Start Editing The Text Field. This is where the keybord shows.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -200, up: true)
    }
    
    // Finish Editing The Text Field Keybord is hidden
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -200, up: false)
        
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.view.frame.origin.y-=200
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.frame.origin.y+=200
    }
    
    func addTotalSum(item: Item) {
        if item.quantity >= 0 {
            order.sum = order.sum + item.price
            sum.text = "\(order.sum!) kr"
        }
    }
    
    func subTotalSum(item: Item) {
        if item.quantity >= 0 {
            order.sum = order.sum - item.price
            sum.text = "\(order.sum!) kr"
        }
    }
 
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addShirt(_ sender: Any) {
        self.shirts.quantity = shirts.quantity + 1
        self.nrShirtsTextField.text = String(shirts.quantity)
        addTotalSum(item: shirts)
    }
    
    @IBAction func subShirt(_ sender: Any) {
        if self.shirts.quantity >= 1 {
        self.shirts.quantity = shirts.quantity - 1
        self.nrShirtsTextField.text = String(shirts.quantity)
        subTotalSum(item: shirts)
        }
    }
    
    @IBAction func addShirtPackage(_ sender: Any) {
        self.shirtsPackages.quantity = shirtsPackages.quantity + 1
        self.nrShirtsPackageTextField.text = String(shirtsPackages.quantity)
        addTotalSum(item: shirtsPackages)
    }
    
    @IBAction func subShirtPackage(_ sender: Any) {
        if self.shirtsPackages.quantity >= 1 {
            self.shirtsPackages.quantity = shirtsPackages.quantity - 1
            self.nrShirtsPackageTextField.text = String(shirtsPackages.quantity)
            self.nrShirtsTextField.text = String(shirts.quantity)
            subTotalSum(item: shirtsPackages)
        }
    }
    
    @IBAction func addSuits(_ sender: Any) {
        self.suits.quantity = suits.quantity + 1
        self.nrSuitsTextField.text = String(suits.quantity)
        addTotalSum(item: suits)
    }
    
    @IBAction func subSuits(_ sender: Any) {
        if self.suits.quantity >= 1 {
        self.suits.quantity = suits.quantity - 1
        self.nrSuitsTextField.text = String(suits.quantity)
        subTotalSum(item: suits)
        }
    }
    
    @IBAction func addSuitsJackets(_ sender: Any) {
        self.suitsJackets.quantity = suitsJackets.quantity + 1
        self.nrSuitJacketsTextField.text = String(suitsJackets.quantity)
        addTotalSum(item: suitsJackets)
    }
    
    @IBAction func subSuitsJackets(_ sender: Any) {
        if self.suitsJackets.quantity >= 1 {
            self.suitsJackets.quantity = suitsJackets.quantity - 1
            self.nrSuitJacketsTextField.text = String(suitsJackets.quantity)
            subTotalSum(item: suitsJackets)
        }
    }
    
    @IBAction func addPants(_ sender: Any) {
        self.pants.quantity = pants.quantity + 1
        self.nrPantsTextField.text = String(pants.quantity)
        addTotalSum(item: pants)
    }
    
    @IBAction func subPants(_ sender: Any) {
        if self.pants.quantity >= 1 {
            pants.quantity = pants.quantity - 1
            nrPantsTextField.text = String(pants.quantity)
            subTotalSum(item: pants)
        }
    }
    
    @IBAction func addSmoking(_ sender: Any) {
        self.smokings.quantity = smokings.quantity + 1
        self.nrSmokingTextField.text = String(smokings.quantity)
        addTotalSum(item: smokings)
    }
    
    
    @IBAction func subSmoking(_ sender: Any) {
        if self.smokings.quantity >= 1 {
            smokings.quantity = smokings.quantity - 1
            nrSmokingTextField.text = String(smokings.quantity)
            subTotalSum(item: smokings)
        }
    }
    
    @IBAction func addSmokingShirt(_ sender: Any) {
        self.smokingsShirts.quantity = smokingsShirts.quantity + 1
        self.nrSmokingShirtTextField.text = String(smokingsShirts.quantity)
        addTotalSum(item: smokingsShirts)
        
    }
    
    @IBAction func subSmokingShirt(_ sender: Any) {
        if self.smokingsShirts.quantity >= 1 {
            smokingsShirts.quantity = smokingsShirts.quantity - 1
            self.nrSmokingShirtTextField.text = String(smokingsShirts.quantity)
            subTotalSum(item: smokingsShirts)
            
        }
    }
    
    @IBAction func addDryClean(_ sender: Any) {
        //        Add to orderService
        order.categories.forEach { (category) in
            if price > 0 {
                order.sum = price
            } else {
                print("There is no sum")
            }
            if category.name == "man" {
                print("Categoryname \(category.name)")
                category.items.forEach({ (item) in
                    if item.quantity > 0 {
                        order.categories[1].comment = commentsTextView.text
                        print("There is text \(order.categories[1].comment)")
                    }
                })
            }
        }
    }
    
    @IBAction func passinData(_ sender: Any) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "unwindFromManPop" {
            
        }
    }
}
