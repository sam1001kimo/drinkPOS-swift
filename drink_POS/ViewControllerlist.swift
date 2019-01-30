//
//  ViewControllerlist.swift
//  drink_POS
//
//  Created by Sam on 2019/1/25.
//  Copyright © 2019 S10415. All rights reserved.
//

import UIKit

class ViewControllerlist: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var lblprice1: UILabel!
    @IBOutlet weak var btnCheckout: UIBarButtonItem!
    @IBAction func btnCheckout_Click(_ sender: Any) {
        if appDelegate.購買明細.count == 0{
            let myAlertController = UIAlertController(title: "尚未購買", message: "您尚未購買任何品項", preferredStyle: UIAlertController.Style.alert)
            //加入ok鈕
            let okAction = UIAlertAction(title: "確認", style: UIAlertAction.Style.destructive, handler: {
                (action) -> Void in
            })
            myAlertController.addAction(okAction)
            self.present(myAlertController,animated: true,completion: nil)
        }else{
            let stroyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = stroyBoard.instantiateViewController(withIdentifier: "checkout")
            self.present(nextViewController,animated: true, completion: nil)
        }
    }
    //----tableview protocol---
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return appDelegate.購買明細.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "購買清單"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID:String = "cell"   //原先定義在cell identifier的名稱，現在要拿來取用
        var cell:UITableViewCell? =  tableView.dequeueReusableCell(withIdentifier:cellID)
        //dequeueReusableCell是重複利用
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)  //cell是nil時建立新的
        }
        
        cell?.textLabel?.text = appDelegate.購買明細[indexPath.row] as? String
        cell?.detailTextLabel?.text = "小計:\(appDelegate.小計[indexPath.row])"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            appDelegate.購買明細.removeObject(at: indexPath.row)
            appDelegate.小計.removeObject(at: indexPath.row)
            tableView.reloadData()
            var price:Int = 0
            for price1 in self.appDelegate.小計 {
                price += price1 as! Int
            }
            self.lblprice1.text = "\(price)"
            
        }
    }
    
    //---end tableview protocol----
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        var price:Int = 0
        for price1 in self.appDelegate.小計 {
            price += price1 as! Int
        }
        self.lblprice1.text = "\(price)"
        
        
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
