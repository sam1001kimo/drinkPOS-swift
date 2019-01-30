//
//  ViewController.swift
//  drink_POS
//
//  Created by S10415 on 2019/1/25.
//  Copyright © 2019年 S10415. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource{
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var mySegmentICE: UISegmentedControl!
    @IBOutlet weak var mySegmentSweet: UISegmentedControl!
    @IBOutlet weak var mySegmentOthers: UISegmentedControl!
    @IBOutlet weak var lblPrice1: UILabel!
    @IBOutlet weak var btnReset: UIBarButtonItem!
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    
    var pickreturn:String = "紅茶"
    var ice:String = ""
    var sweet:String = ""
    var others:String = ""
    var price:Int = 0
    var count:Int = 0
    var checkout:Int = 0
    //------TextField--------
    
    @IBAction func myTextField_EditBegin(_ sender: Any) {
        self.myStepper.isEnabled = false
    }
    
    @IBAction func myTextField_EditEnd(_ sender: Any) {
        let tftext:String? = self.myTextField.text
        if tftext != ""{
            self.myStepper.value = Double(tftext!)!
            setcount(Int(Double(tftext!)!))
            if self.pickreturn == "紅茶"{
                setprice(20)
            }
            setcheckout(price*count)
            self.lblPrice1.text = "\(checkout)"
        }else{
            setcheckout(0)
            lblPrice1.text = "\(checkout)"
        }
        self.myStepper.isEnabled = true
    }
    @IBAction func myTextField_EndEdit(_ sender: Any) {
        
       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //手指接觸螢幕當下
        self.myTextField.resignFirstResponder()
    }
    
    
    func setcount(_ Int:Int){
        self.count = Int
    }
    //------End TextField------
    
    //-----Stepper------

    @IBAction func myStepper_ValueChanged(_ sender: Any) {
        let tftext:String? = self.myTextField.text
        var tfvalue:Double
        if tftext != "" {
            tfvalue = Double(tftext!)!
            if self.myStepper.value >= tfvalue{
                tfvalue += 1
                self.myStepper.value = tfvalue
            }else{
                tfvalue -= 1
                self.myStepper.value = tfvalue
            }
        }else{
            tfvalue = 1
            self.myStepper.value = tfvalue
        }
        
        let stepperValue:Double = self.myStepper.value
        self.myTextField.text = "\(Int(stepperValue))"
        setcount(Int(stepperValue))
        
        if self.pickreturn == "紅茶"{
            setprice(20)
        }
        setcheckout(price*count)
        self.lblPrice1.text = "\(checkout)"
    }
    
    //----End Stepper-----
    
    //----ICE-----
    
    @IBAction func mySegmentICE_ValueChanged(_ sender: Any) {
        if self.mySegmentICE.selectedSegmentIndex != 0{
            ice = appDelegate.冰塊[self.mySegmentICE.selectedSegmentIndex] as! String
        }else{
            ice = ""
        }
        setICE(ice)
    }
    func setICE(_ String:String){
        self.ice = String
    }
    //---End ICE----
    
    //---Sweet-----
    
    @IBAction func mySegmentSweet_ValueChanged(_ sender: Any) {
        if self.mySegmentSweet.selectedSegmentIndex != 0{
            sweet = appDelegate.甜度[self.mySegmentSweet.selectedSegmentIndex] as! String
        }else{
            sweet = ""
        }
        setsweet(sweet)
    }
    func setsweet(_ String:String){
        self.sweet = String
    }
    //---End Sweet---
    
    //---others----
    
    @IBAction func mySegmentOthers_ValueChanged(_ sender: Any) {
        if self.mySegmentOthers.selectedSegmentIndex != 0{
            others = appDelegate.加料[self.mySegmentOthers.selectedSegmentIndex] as! String
   
        }else{
            others = ""
            
        }
        setothers(others)
    }
    func setothers(_ String:String){
        self.others = String
    }
    //---End others----
    
    @IBAction func btnReset_Click(_ sender: Any) {
        Reset()
    }
    func Reset(){
        self.myPickerView.selectRow(0, inComponent: 0, animated: true)
        self.mySegmentICE.selectedSegmentIndex = 0
        self.mySegmentSweet.selectedSegmentIndex = 0
        self.mySegmentOthers.selectedSegmentIndex = 0
        self.myTextField.text = ""
        self.myStepper.value = 1
        self.lblPrice1.text = "價錢"
        setpickreturn("紅茶")
        setcount(0)
        setICE("")
        setsweet("")
        setothers("")
        setcheckout(0)
    }
    
    @IBAction func btnAdd_Click(_ sender: Any) {
        var str:String = ""
        
        if self.myTextField.text != ""{
            str = "\(pickreturn)\(price) 杯數:\(count) \(ice) \(sweet) \(others)"
            appDelegate.購買明細.add(str)
            appDelegate.小計.add(checkout)
            Reset()
            self.navigationItem.prompt = "加入成功"
            self.perform(#selector(clearPrompt),with:nil,afterDelay:5.0)
        }else{
            self.navigationItem.prompt = "數量未填"
            self.perform(#selector(clearPrompt),with:nil,afterDelay:5.0)
        }
    }
    
    //----PickView Protocol-------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //有幾個滾輪就幾個component
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //針對不同的pickerview給予不同的滾輪數，對應集合
        var intRowNum:Int = 0
        if component == 0{
            intRowNum = appDelegate.飲料品項.count
        }
        return intRowNum
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //也可以是Image
        //決定滾輪上的文字，對應集合的內容
        var strRow:String = ""
        if component == 0{
            strRow = appDelegate.飲料品項[row] as! String
        }
        return strRow
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickreturn = appDelegate.飲料品項[row] as! String
        self.setpickreturn(self.pickreturn)
        self.setprice(appDelegate.價錢[appDelegate.飲料品項.index(of: self.pickreturn)] as! Int)
        if count != 0{
            setcheckout(price*count)
            lblPrice1.text = "\(checkout)"
        }else{
            setcheckout(0)
            lblPrice1.text = "\(checkout)"
        }
    }
    
    func setpickreturn(_ String:String){
        self.pickreturn = String
    }
    func setprice(_ Int:Int){
        self.price = Int
    }
    func setcheckout(_ Int:Int){
        self.checkout = Int
    }
    
    //-----end PickView Protocol-----
    
    
    
    @objc func clearPrompt(){
        self.navigationItem.prompt = nil  //或是 ＝ ""用空字串會變成空白行在那
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        appDelegate.飲料品項 = ["紅茶","綠茶","烏龍茶","奶茶","花茶"]
        appDelegate.價錢 = [20,20,25,30,30]
        appDelegate.冰塊 = ["去冰","微冰","少冰","正常冰"]
        appDelegate.甜度 = ["無糖","微糖","少糖","正常甜"]
        appDelegate.加料 = ["無","珍珠","椰果"]
        
        
        
    }


}

