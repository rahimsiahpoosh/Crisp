//
//  WomanPopUpVC.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-08.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class WomanPopUpVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet var addButton: [UIButton] = []
    @IBOutlet var fields: [UITextField] = []
    @IBOutlet var subButton: [UIButton] = []
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var sum: UILabel!
    
    var order: Order! 
    var shirts: Item!
    var shirtsPackages: Item!
    var suits: Item!
    var suitsJackets: Item!
    var pants: Item!
    var skirts: Item!
    var dress: Item!
    var comments: String!
    var price = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sum.text = "\(order.sum!) kr"
        shirts = order?.categories[2].items.filter({ (item) -> Bool in
            item.name == "shirts"
        }).first!
        
        shirtsPackages = order.categories[2].items.filter({ (item) -> Bool in
            item.name == "suits"
        }).first!
        
        shirtsPackages = order.categories[2].items.filter({ (item) -> Bool in
            item.name == "shirt 5 pack"
        }).first!
        suits = order.categories[2].items.filter({ (item) -> Bool in
            item.name == "suits"
        }).first!
        suitsJackets = order.categories[2].items.filter({ (item) -> Bool in
            item.name == "suitjackets"
        }).first!
        
        pants = order.categories[2].items.filter({ (item) -> Bool in
            item.name == "pants"
        }).first!
        skirts = order.categories[2].items.filter({ (item) -> Bool in
            item.name == "skirts"
        }).first!
        dress = order.categories[2].items.filter({ (item) -> Bool in
           item.name == "dress"
        }).first!
        
        self.fields[0].text = String(shirts.quantity)
        shirts.price = 25
        self.fields[1].text = String(shirtsPackages.quantity)
        shirtsPackages.price = 100
        self.fields[2].text = String(suits.quantity)
        suits.price = 200
        self.fields[3].text = String(suitsJackets.quantity)
        suitsJackets.price = 140
        self.fields[4].text = String(pants.quantity)
        pants.price = 130
        self.fields[5].text = String(skirts.quantity)
        skirts.price = 130
        self.fields[6].text = String(dress.quantity)
        dress.price = 170
        self.commentsTextView.text = order.categories[2].comment
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
    
    @IBAction func orderAddSub(sender: UIButton) {
        switch sender {
        case self.addButton[0]:
            self.shirts.quantity = shirts.quantity + 1
            self.fields[0].text = String(shirts.quantity)
            addTotalSum(item: shirts)
            print("shirt")
            
        case self.subButton[0]:
            if shirts.quantity == shirts.quantity {
                if shirts.quantity >= 1 {
                    shirts.quantity = shirts.quantity - 1
                    fields[0].text = String(shirts.quantity)
                    subTotalSum(item: shirts)
                }
            }
            
        case self.addButton[1]:
            self.shirtsPackages.quantity  = shirtsPackages.quantity + 1
            self.fields[1].text = String(shirtsPackages.quantity)
            addTotalSum(item: shirtsPackages)
            
        case self.subButton[1]:
            if shirtsPackages.quantity == shirtsPackages.quantity {
                if shirtsPackages.quantity >= 1 {
                    shirtsPackages.quantity = shirtsPackages.quantity - 1
                    fields[1].text = String(shirtsPackages.quantity)
                    subTotalSum(item: shirtsPackages)
                }
            }
            
        case self.addButton[2]:
            self.suits.quantity = suits.quantity + 1
            if suits.quantity == suits.quantity {
                self.fields[2].text = String(suits.quantity)
                addTotalSum(item: suits)
            }
            
        case self.subButton[2]:
            if suits.quantity == suits.quantity {
                if suits.quantity >= 1 {
                    suits.quantity = suits.quantity - 1
                    fields[2].text = String(suits.quantity)
                    subTotalSum(item: suits)
                }
            }
            
        case self.addButton[3]:
            self.suitsJackets.quantity = suitsJackets.quantity + 1
            if suitsJackets.quantity == suitsJackets.quantity {
                self.fields[3].text = String(suitsJackets.quantity)
                addTotalSum(item: suitsJackets)
            }
            
        case self.subButton[3]:
            if suitsJackets.quantity == suitsJackets.quantity {
                if suitsJackets.quantity >= 1 {
                    suitsJackets.quantity = suitsJackets.quantity - 1
                    fields[3].text = String(suitsJackets.quantity)
                    subTotalSum(item: suitsJackets)
                }
            }
            
        case self.addButton[4]:
            self.pants.quantity = pants.quantity + 1
            if pants.quantity == pants.quantity {
                self.fields[4].text = String(pants.quantity)
                addTotalSum(item: pants)
            }
            
        case self.subButton[4]:
            if pants.quantity == pants.quantity {
                if pants.quantity >= 1 {
                    pants.quantity = pants.quantity - 1
                    fields[4].text = String(pants.quantity)
                    subTotalSum(item: pants)
                }
            }
            
        case self.addButton[5]:
            self.skirts.quantity = skirts.quantity + 1
            if skirts.quantity == skirts.quantity {
                self.fields[5].text = String(skirts.quantity)
                addTotalSum(item: skirts)
            }
            
        case self.subButton[5]:
            if skirts.quantity == skirts.quantity {
                if skirts.quantity >= 1 {
                    skirts.quantity = skirts.quantity - 1
                    fields[5].text = String(skirts.quantity)
                    subTotalSum(item: skirts)
                }
            }
        case self.addButton[6]:
            self.dress.quantity = dress.quantity + 1
            if dress.quantity == dress.quantity {
                self.fields[6].text = String(dress.quantity)
                addTotalSum(item: dress)
            } else {
                print("No dress")
            }
        
        case self.subButton[6]:
            if dress.quantity == dress.quantity {
                if dress.quantity >= 1 {
                    dress.quantity = dress.quantity - 1
                    fields[6].text = String(dress.quantity)
                    subTotalSum(item: dress)
                    print("One less dress")
                } else {
                    print("No change has been made")
                }
            }
        default:
            break
       }
    }
    @IBAction func addDryClean(_ sender: Any) {
        //        Add to orderService
        order.categories.forEach { (category) in
            if price > 0 {
                order.sum = price
                print(order.sum)
            }
            if category.name == "woman" {
                category.items.forEach({ (item) in
                    if item.quantity > 0 {
                        order.categories[2].comment = commentsTextView.text
                    }
                })
            }
        }
        print(order.categories[2].comment)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromWomanPop" {
        }
    }
}






