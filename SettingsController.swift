//
//  SettingsController.swift
//  TipCalculator
//
//  Created by Joao on 12/15/20.
//  Copyright © 2020 Joao. All rights reserved.
//

import UIKit

class SettingsController: UIViewController{

    @IBOutlet weak var tipField: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tipField.text = String(Int(defaults.double(forKey: "tipDefault")))
        tipField.text?.append("%")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        print("hello1")
        view.endEditing(true)
    }
    
    @IBAction func saveDefault(_ sender: Any){
        print(tipField.text!)
        print(" ")
        
        defaults.set(tipField.text!, forKey: "tipDefault")
        
        defaults.synchronize()
        
        tipField.text = String(Int(defaults.double(forKey: "tipDefault")))
        tipField.text?.append("%")
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
