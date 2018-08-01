//
//  HomePopUpVC.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-08.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class HomePopUpVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet var addButton: [UIButton] = []
    @IBOutlet var fields: [UITextField] = []
    @IBOutlet var subButton: [UIButton] = []
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var sum: UILabel!
    
    var nrCarpets = 0
    var nrCurtains = 0
    var nrSheets = 0
    var nrDuvets = 0
    var nrPillowcase = 0
    var nrSoffClothes = 0
    
    var order: Order!
    var carpets: Item!
    var curtains: Item!
    var sheets: Item!
    var duvets: Item!
    var pillowcases: Item!
    var soffclothes: Item!
    var comments: String!
    var price = 0
    
    func orderHome() {
        
        sum.text = "\(order.sum!) kr"
        carpets = order?.categories[0].items.filter({ (item) -> Bool in
            item.name == "carpets"
        }).first

        curtains = order?.categories[0].items.filter({ (item) -> Bool in
            item.name == "curtains"
        }).first

        sheets = order?.categories[0].items.filter({ (item) -> Bool in
            item.name == "sheets"
        }).first

        duvets = order?.categories[0].items.filter({ (item) -> Bool in
            item.name == "duvets"
         }).first

        pillowcases = order?.categories[0].items.filter({ (item) -> Bool in
            item.name == "pillowcases"
        }).first

        soffclothes = order?.categories[0].items.filter({ (item) -> Bool in
            item.name == "soffclothes"
        }).first
        comments = order.categories[0].comment
        
        self.fields[0].text = String(carpets.quantity)
        carpets.price = 800
        self.fields[1].text = String(curtains.quantity)
        curtains.price = 60
        self.fields[2].text = String(sheets.quantity)
        sheets.price = 200
        self.fields[3].text = String(duvets.quantity)
        duvets.price = 50
        self.fields[4].text = String(pillowcases.quantity)
        pillowcases.price = 50
        self.fields[5].text = String(soffclothes.quantity)
        soffclothes.price = 200
        self.commentsTextView.text = comments
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderHome()
        
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
        case addButton[0]:
            if carpets.quantity == carpets.quantity {
                carpets.quantity = carpets.quantity + 1
                fields[0].text = String(carpets.quantity)
                addTotalSum(item: carpets)
                print("Carpet added")
            }
            
        case subButton[0]:
            if carpets.quantity == carpets.quantity {
                if carpets.quantity >= 1 {
                    carpets.quantity = carpets.quantity - 1
                    fields[0].text = String(carpets.quantity)
                    subTotalSum(item: carpets)
                    print("Carpet subbed")
                } 
            }
            
        case addButton[1]:
            if curtains.quantity == curtains.quantity {
                curtains.quantity = curtains.quantity + 1
                fields[1].text = String(curtains.quantity)
                addTotalSum(item: curtains)
                print("Curtains added")
            }
            
        case subButton[1]:
            if curtains.quantity == curtains.quantity {
                if curtains.quantity >= 1 {
                    curtains.quantity = curtains.quantity - 1
                    fields[1].text = String(curtains.quantity)
                    subTotalSum(item: curtains)
                    print("Curtains subbed")
                }
            }
            
        case addButton[2]:
            if sheets.quantity == sheets.quantity {
                sheets.quantity = sheets.quantity + 1
                fields[2].text = String(sheets.quantity)
                addTotalSum(item: sheets)
                print("Sheets added")
            }
            
        case subButton[2]:
            if sheets.quantity == sheets.quantity {
               if sheets.quantity >= 1 {
                    sheets.quantity = sheets.quantity - 1
                    fields[2].text = String(sheets.quantity)
                subTotalSum(item: sheets)
                    print("Sheets subbed")
               } else {
                print("No sheets subbed")
                }
            }
            
        case addButton[3]:
            if duvets.quantity == duvets.quantity {
                duvets.quantity = duvets.quantity + 1
                fields[3].text = String(duvets.quantity)
                addTotalSum(item: duvets)
                print("Duvets added")
            }
            
        case subButton[3]:
            if duvets.quantity == duvets.quantity {
                if duvets.quantity >= 1 {
                    duvets.quantity = duvets.quantity - 1
                    fields[3].text = String(duvets.quantity)
                    subTotalSum(item: duvets)
                    print("Duvets subbed")
                }
            }
            
        case addButton[4]:
            if pillowcases.quantity == pillowcases.quantity {
                pillowcases.quantity = pillowcases.quantity + 1
                fields[4].text = String(pillowcases.quantity)
                addTotalSum(item: pillowcases)
                print("Pillowcase added")
            }
            
        case subButton[4]:
            if pillowcases.quantity == pillowcases.quantity {
                if pillowcases.quantity >= 1 {
                    pillowcases.quantity = pillowcases.quantity - 1
                    fields[4].text = String(pillowcases.quantity)
                    subTotalSum(item: pillowcases)
                    print("Pillowcase subbed")
                }
            }
            
        case addButton[5]:
            if soffclothes.quantity == soffclothes.quantity {
                soffclothes.quantity = soffclothes.quantity + 1
                fields[5].text = String(soffclothes.quantity)
                addTotalSum(item: soffclothes)
                print("Soffclothes added")
            } else {
                print("No Soffclother added")
            }
            
        case subButton[5]:
            if soffclothes.quantity == soffclothes.quantity {
                if soffclothes.quantity >= 1 {
                    soffclothes.quantity = soffclothes.quantity - 1
                    fields[5].text = String(soffclothes.quantity)
                    subTotalSum(item: soffclothes)
                    print("Soffclothes subbed")
                }
            }
            
        default:
            break;
        }
    }
    
    @IBAction func addDryClean(_ sender: Any) {
        order.categories.forEach { (category) in
            if category.name == "home" {
                category.items.forEach({ (item) in
                    if item.quantity > 0 {
                        order.categories[0].comment = commentsTextView.text
                    }
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
