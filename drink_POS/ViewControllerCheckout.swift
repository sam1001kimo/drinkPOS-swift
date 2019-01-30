//
//  ViewControllerCheckout.swift
//  drink_POS
//
//  Created by Sam on 2019/1/25.
//  Copyright © 2019 S10415. All rights reserved.
//

import UIKit

class ViewControllerCheckout: UIViewController {

    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var btnNext: UIBarButtonItem!
    @IBAction func btnNext_Click(_ sender: Any) {
        appDelegate.購買明細.removeAllObjects()
        appDelegate.小計.removeAllObjects()
        let stroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = stroyBoard.instantiateViewController(withIdentifier: "Main1")
        self.present(nextViewController,animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var strMsg:String = ""
        strMsg += "                             III飲料店\n"
        strMsg += "---------------------------------------\n"
        for i in 0..<appDelegate.購買明細.count{
            
            strMsg += "\(String(format:"%@",appDelegate.購買明細[i] as! String))\n \(String(format: "%@", "                                    " ))小計:\(String(format: "%5d", appDelegate.小計[i] as! Int))元\n"
        }
        strMsg += "---------------------------------------\n"
        var price:Int = 0
        for price1 in self.appDelegate.小計 {
            price += price1 as! Int
        }
        strMsg += "總價：$\(price)元"
        self.myTextView.text = strMsg
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
