//
//  DropDateVC.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-09.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class DropDateVC: UIViewController {
    
    var order: Order!
    var strDate: String!
    var aDayAheadFromPickDate = 0
    var dateFormatter = DateFormatter()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if order.pick.date == "" {
            print("There is an emptyString",order.pick.date)
            formatter()
        } else if order.pick.date != nil {
            print("There is a String", order.pick.date)
            testCompare()
            formatterAdd()
        }
    }
    
    func formatter() {
        
        let minute:TimeInterval = 60.0
        let hour:TimeInterval = 60.0 * minute
        let day:TimeInterval = 24 * hour
        let startDateDrop: TimeInterval = 2 * day
        let daysToAdd = 2
        var dateComponent = DateComponents()
        dateComponent.day = daysToAdd
        let today = Date()
        print("check")
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: today)
        print(futureDate)
        datePicker.minimumDate = futureDate
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.datePicker.date = NSDate.init(timeIntervalSinceNow: startDateDrop ) as Date
    
    }
    
    func formatterAdd() {
        
        let minute:TimeInterval = 60.0
        let hour:TimeInterval = 60.0 * minute
        let aheadDayDouble = Double(aDayAheadFromPickDate)
        let aheadDayTime: TimeInterval = aheadDayDouble
        let day:TimeInterval = 24 * hour
        let intervalTime = aheadDayTime * day
        print("IntervalTime", intervalTime)
        var dateComponent = DateComponents()
        dateComponent.day = aDayAheadFromPickDate
        let today = Date()
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: today)
        datePicker.minimumDate = futureDate
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.datePicker.date = NSDate.init(timeIntervalSinceNow: intervalTime ) as Date
        print("DatePickerAdd\(self.datePicker.date)")
        
        
        
    }
    
    func testCompare() {
        let previousDate = order.pick.date
        print("prev", previousDate)
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let previousDateFormated : Date? = dateFormatter.date(from: previousDate!)
        print("PREVIOUSDATEFORMATED \(previousDateFormated)")
        let difference = currentDate.timeIntervalSince(previousDateFormated!)
        print("difference between currentDate and previousDate \(difference)")
        let differenceInDays = Int(difference/(60 * 60 * 24 ))
        print("Diff in days \(differenceInDays)")
        var diffInDaysPositive = abs(differenceInDays)
        print("diff in days positive \(diffInDaysPositive)")
        diffInDaysPositive += 2
        print("Added with on ", diffInDaysPositive)
        aDayAheadFromPickDate = diffInDaysPositive
    
        
    }
    
    func compareDates() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let firstDate = formatter.date(from: "10/08/2017")
        let secondDate = formatter.date(from: "10/08/2017")
        
        if firstDate?.compare(secondDate!) == .orderedSame {
            print("Both dates are same")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromDropUpDateVC" {
            let destinationController = segue.destination as! DropPickVC
            destinationController.order = order
        }
    }
    
    @IBAction func addDate(_ sender: Any) {
        strDate = dateFormatter.string(from: datePicker.date)
        order.drop.date = strDate
        print("Date selected for pickup", order.drop.date)
    }
}
