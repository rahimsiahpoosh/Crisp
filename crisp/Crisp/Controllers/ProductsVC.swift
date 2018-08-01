//
//  ProductsVC.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-07.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit
import Firebase

class ProductsVC: UIViewController {

    var customer = Customer()
    var ref: DatabaseReference!
    var uid: String!
    var order = Order()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference().child("Crisp").child(uid).child("Customer")
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    @IBAction func womanTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "womanPop", sender: nil)
    }
    
    @IBAction func houseTapGestureRecognizer(_ sender: Any) {
        performSegue(withIdentifier: "homePop", sender: nil)
    }
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logOutProductVC", sender: nil)
        }
        catch {
            print("error")
        }
    }
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "manPop" {
            let destinationController = segue.destination as! ManPopUpVC
            destinationController.order = order
        }
        if segue.identifier == "womanPop" {
            let destinationController = segue.destination as! WomanPopUpVC
            destinationController.order = order
        }
        if segue.identifier == "homePop" {
            let destinationController = segue.destination as! HomePopUpVC
            destinationController.order = order
        }
        if segue.identifier == "DropPick" {
            let destinationController = segue.destination as! DropPickVC
            destinationController.order = order
        }
    }
    
    func printTestMan() {
        
        order.categories.forEach { (category) in
            if category.name != nil && category.comment != "" {
                print(category.comment)
            } else {
                print("There is no comments")
            }
        }
    }
    
    @IBAction func confirmChoosenItemBtn(_ sender: Any) {
        if order.categories.isEmpty == false {
            
            order.categories.forEach { (categories) in
                print("Test", categories.name)
                categories.items.forEach{ (items) in
                    if items.quantity > 0 {
                        print("There is value", items.quantity)
                        performSegue(withIdentifier: "DropPick", sender: nil)
                    } else {
                        print("There is no value")
                    }
                }
            }
        }
            let alert = UIAlertController(title: "Alert", message: "Det finns inga plagg i din tvättkorg. Kapish!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }
    @IBAction func printOrder(_ sender: Any) {
        printTestMan()
    }
}
