//
//  PickUpDateVC.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-08.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class PickUpDateVC: UIViewController {
    
    var order: Order!
    var strDate: String!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if order.pick.date != "" {
            print(order.pick.date)
            let dateString = order.pick.date
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.date(from: dateString!)
            datePicker.setDate(date!, animated: false)
        } else {
            print("There is no pick date")
            formatter()
        }
    }
    
    func formatter() {
        let minute:TimeInterval = 60.0
        let hour:TimeInterval = 60.0 * minute
        let day:TimeInterval = 24 * hour
        let daysToAdd = 1
        
        var dateComponent = DateComponents()
        dateComponent.day = daysToAdd
        let today = Date()
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: today)
        datePicker.minimumDate = futureDate
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.datePicker.date = NSDate.init(timeIntervalSinceNow: day ) as Date
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromPickUpDateVC"{
            let destinationController = segue.destination as! DropPickVC
            destinationController.order = order
        }
    }
    
    @IBAction func pickerDateSelectedChanged(_ sender: Any) {
        
    }
    
    @IBAction func addDate(_ sender: Any) {
        strDate = dateFormatter.string(from: datePicker.date)
        order.pick = TimeAddress(date: strDate)
        print("Date selected through button == ", order.pick.date)
    }
}
