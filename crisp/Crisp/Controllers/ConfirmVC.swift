//
//  ConfirmVC.swift
//  Crisp
//
//  Created by Rahim Siahpoosh on 2018-03-11.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit
import SimplePDF
import Firebase

class ConfirmVC: UIViewController {
    
    var ref: DatabaseReference!
    var uid: String!
    var key: String!
    var order: Order!
    var sum = 0

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        invoicePdf()
        
        uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference().child("Crisp").child(uid!).child("Customer").child("Order")
        key = ref.childByAutoId().key
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        print("We are going back")
    }
    
    
    @IBAction func confirmOrder(_ sender: Any) {
      self.addOrder()
    }
    


    func addOrder() {
        let dropEntryCode: String!
        if order.drop.entryCode == 0 {
            dropEntryCode = "Ingen portkod"
        } else {
            dropEntryCode = String(order.drop.entryCode)
        }
        
        let pickEntryCode: String!
        if order.pick.entryCode == 0 {
            pickEntryCode = "ingen portkod"
        } else {
            pickEntryCode = String(order.pick.entryCode)
        }
        
        let pickAndDropDateAddress = [
            "Pick up date" : "\(self.order.pick.date!)",
            "Pick up time" : "\(self.order.pick.time!)",
            "Pick up adress" : "\(self.order.pick.address!)",
            "Pick up entrycode" : "\(pickEntryCode!)",
            "Drop date" : "\(self.order.drop.date!)",
            "Drop time" : "\(self.order.drop.time!)",
            "Drop adress" : "\(self.order.drop.address!)",
            "Drop entrycode" : "\(dropEntryCode!)"]
        
        var newOrder = [String:Any]()
        newOrder["ID"] = "\(key!)"
        newOrder["PickAndDrop"] = pickAndDropDateAddress
        
        func appendInnewOrder(categoryName: String) {
            order.categories.forEach { (category) in
                if category.name == categoryName {
                    category.items.forEach({ (item) in
                        if item.quantity > 0 {
                            newOrder[categoryName] = ["\(item.name!), \(item.quantity!)"]
                        }
                    })
                    if category.comment != "" {
                        newOrder["\(categoryName)message"] = "\(category.comment)"
                    }
                }
            }
        }
        
        appendInnewOrder(categoryName: "home")
        appendInnewOrder(categoryName: "man")
        appendInnewOrder(categoryName: "woman")
        print(newOrder)
    }
    
    func invoicePdf() {
        
        let orderService = (UIApplication.shared.delegate as! AppDelegate).orderService
        let a4PapperSize = CGSize(width: webView.frame.width, height: webView.frame.height)
        let pdf = SimplePDF(pageSize: a4PapperSize)
        
        func generateThumbImage(logo:String) -> UIImage{
            
            let image: UIImage = UIImage(named: logo)!
            let thumbSize = CGSize(width: 100, height: 100)
            UIGraphicsBeginImageContext(thumbSize)
            image.draw(in: CGRect(x: 0, y: 0, width: thumbSize.width, height: thumbSize.height))
            let thumbImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return thumbImage!
        }
        
        func showItemsOnPdf(categoryName: String) {
            order.categories.forEach { (categories) in
                if categories.name == categoryName {
                    categories.items.forEach{ (items) in
                        if items.quantity > 0 {
                            pdf.addText("\(categories.name!) \(items.name!) \(items.quantity!)")
                            sum = items.quantity * items.price
                            order.sum = order.sum + sum
                            print("There is a sum \(order.sum!)")
                            print("There is value", items.quantity)
                        } else {
                            return
                        }
                    }
                    if categories.comment != "" {
                        pdf.addLineSpace(4)
                        pdf.addText("Meddelande \(categoryName)", font: UIFont.boldSystemFont(ofSize: 14), textColor: UIColor.black)
                        print("There is a comment \(categories.comment)")
                        pdf.addText("\(categories.comment)")
                    } else {
                        return
                    }
                    pdf.addLineSpace(10)
                }
            }
        }
        
        let logo = generateThumbImage(logo: "cloth-towel-2")
        pdf.setContentAlignment(.center)
        pdf.addImage(logo)
        pdf.addLineSpace(10)
        pdf.addLineSeparator()
        
        pdf.setContentAlignment(.left)
        pdf.addLineSpace(10)
        
        if order.pick.date != "" || order.pick.time != "" || order.pick.address != "" || order.pick.entryCode > 0{
            let pickEntryCode: String?
            if order.pick.entryCode > 0 {
                pickEntryCode = String(order.pick.entryCode)
            } else {
                pickEntryCode = "No entrycode"
            }
            pdf.addText("Upphämtnings datum: \(order.pick.date!)")
            pdf.addText("Upphämtnings tid: \(order.pick.time!)")
            pdf.addText("Upphämtnings adress: \(order.pick.address!)")
            pdf.addText("Upphämtning portkod \(pickEntryCode!)")
        }

        pdf.addLineSpace(10)
        
        if order.drop.date != "" || order.drop.time != "" || order.drop.address != "" || order.drop.entryCode > 0{
            let dropEntryCode: String?
            if order.drop.entryCode > 0 {
                dropEntryCode = String(order.drop.entryCode)
            } else {
                dropEntryCode = "No entrycode"
            }

            pdf.addText("Avhämtnings datum: \(order.drop.date!)")
            pdf.addText("Avhämtnings tid: \(order.drop.time!)")
            pdf.addText("Avhämtnings adress: \(order.drop.address!)")
            pdf.addText("Inlämning portkod \(dropEntryCode!)")
        }
        
        pdf.addLineSpace(10)
        pdf.addLineSeparator()
        pdf.addLineSpace(10)
        
        pdf.addText("Order")
        pdf.addLineSpace(5)
        
        showItemsOnPdf(categoryName: "man")
        showItemsOnPdf(categoryName: "woman")
        showItemsOnPdf(categoryName: "home")
        
        let width = webView.frame.size.width/2
        
        pdf.addLineSpace(10)
        
        pdf.addLineSeparator()
        pdf.addLineSpace(10)
//        print("\(order.categories[1].items[0].price)")
        pdf.addText("Summa: \(order.sum!) kr")
        
        let pdfData = pdf.generatePDFdata()
        
        webView.load(pdfData, mimeType: "application/pdf", textEncodingName: "", baseURL: NSURL() as URL)
        
        
        
    }

}
