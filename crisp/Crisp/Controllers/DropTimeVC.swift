//
//  DropTimeVC.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-09.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class DropTimeVC: UIViewController {
    
    var order: Order!

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if order.drop.time != "" {
            label.text = order.drop.time
            print(label.text!)
        } else {
            print("there is no pickupdate set")
        }
    }
    
        @IBAction func radio0608(_ sender: Any) {
            label.text = "06-08"
            if let label = label {
                order.drop.time = label.text
                print(order.drop.time)
            }
        }
    
        @IBAction func radio0810(_ sender: Any) {
            label.text = "08-10"
            order.drop.time = label.text
        }
    
    
        @IBAction func radio1012(_ sender: Any) {
            label.text = "10-12"
            if let label = label {
                order.drop.time = label.text
            }
        }
    
        @IBAction func radio1214(_ sender: Any) {
            label.text = "12-14"
            if let label = label {
                order.drop.time = label.text
            }
        }
    
        @IBAction func radio1416(_ sender: Any) {
            label.text = "14-16"
            if let label = label {
                order.drop.time = label.text
            }
        }
    
        @IBAction func radio1618(_ sender: Any) {
            label.text = "16-18"
            if let label = label {
            order.drop.time = label.text
            }
        }
    
        @IBAction func radio1820(_ sender: Any) {
            label.text = "18-20"
            if let label = label {
            order.drop.time = label.text
            }
        }
    
        @IBAction func radio1922(_ sender: Any) {
            label.text = "19-22"
            order.drop.time = label.text
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromDropUpTimeVC" {
            let destinationController = segue.destination as! DropPickVC
                destinationController.order = order
        }
    }
    
    @IBAction func addTime(_ sender: Any) {
            print("Drop time is set", order.drop.time)
    }
}
