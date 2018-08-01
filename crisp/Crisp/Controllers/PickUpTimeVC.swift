//
//  PickUpTimeVC.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-08.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class PickUpTimeVC: UIViewController {
    
    var order: Order!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if order.pick.time != "" {
            label.text = order.pick.time
            print(label.text!)
        } else {
            print("there is no pickupdate set")
        }
    }
    
    @IBAction func radio0608(_ sender: Any) {
        label.text = "06-08"
        if let label = label {
            order.pick.time = label.text
            print("Shono har bestämt tid", order.pick.time)
        } else {
            print("no label")
        }
    }
    
    @IBAction func radio0810(_ sender: Any) {
        label.text = "08-10"
        if let label = label {
            order.pick.time = label.text
            print(order.pick.time)
        }
    }
    
    
    @IBAction func radio1012(_ sender: Any) {
        label.text = "10-12"
        if let label = label {
            order.pick.time = label.text
            print(order.pick.time)
        }
    }
    
    @IBAction func radio1214(_ sender: Any) {
        label.text = "12-14"
        if let label = label {
            order.pick.time = label.text
            print(order.pick.time)
        }
    }
    
    @IBAction func radio1416(_ sender: Any) {
        label.text = "14-16"
        if let label = label {
            order.pick.time = label.text
            print(order.pick.time)
        }
    }
    
    @IBAction func radio1618(_ sender: Any) {
        label.text = "16-18"
        if let label = label {
            order.pick.time = label.text
            print(order.pick.time)
        }
    }
    
    @IBAction func radio1820(_ sender: Any) {
        label.text = "18-20"
        if let label = label {
            order.pick.time = label.text
            print(order.pick.time)
        }
    }
    
    @IBAction func radio1922(_ sender: Any) {
        label.text = "19-22"
        if let label = label {
            order.pick.time = label.text
            print(order.pick.time)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromPickUpTimeVC" {
            let destinationController = segue.destination as! DropPickVC
            destinationController.order = order
        }
    }
    
    @IBAction func addTime(_ sender: Any) {
        
    }
}
