//
//  SettingsController.swift
//  TipCalculator
//
//  Created by Joao on 12/15/20.
//  Copyright © 2020 Joao. All rights reserved.
//

import UIKit

class SettingsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var tipField: UITextField!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    let defaults = UserDefaults.standard
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Set up for currency picker
        self.currencyPicker.delegate = self
        self.currencyPicker.dataSource = self
        
        pickerData = ["USD", "AUD", "GBP", "EUR", "JPY"]
        
        //Deleted "CHF" --  need to add auto text size for it
        
        //Formatter to convert it into percentage
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        let percentage = (defaults.double(forKey: "tipDefault")/100) as NSNumber
        tipField.text = formatter.string(from: percentage)
        
        //Saves default currency from picker
        currencyPicker.selectRow(defaults.integer(forKey: "defaultRow") ,inComponent: 0,animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Set up for currency picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {return 1}
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return pickerData.count}
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return pickerData[row]}

    //Closes keyboard
    @IBAction func onTap(_ sender: Any) {view.endEditing(true)}
    
    //Changes picker view's font color to white
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerData[row], attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        //Also saves defaults
        //Deleted "en_HK" -- need auto size or it
        let localeCodes = ["en_US_POSIX", "en_AU", "en_GB", "fr_FR", "ja_JP"]
        defaults.set(localeCodes[row], forKey: "localeCode")
        defaults.set(row, forKey: "defaultRow")
        defaults.synchronize()
        
    }
    
    @IBAction func saveDefault(_ sender: Any){
        //Saves default tip
        defaults.set(tipField.text!, forKey: "tipDefault")
        defaults.synchronize()
        
        //Formatter to convert it into percentage
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        
        let percentage = (defaults.double(forKey: "tipDefault")/100) as NSNumber
        
        tipField.text = formatter.string(from: percentage)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
