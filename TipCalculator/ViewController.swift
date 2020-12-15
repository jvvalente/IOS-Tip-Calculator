//
//  ViewController.swift
//  TipCalculator
//
//  Created by Joao on 12/13/20.
//  Copyright © 2020 Joao. All rights reserved.
//

//TODO: On settings page create round up or round down option
//TODO: Add # of people to divide evenly

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var numberPoepleField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var percentageLabel: UILabel!
    
    var tipPercentage = 0.15
    let tipPercentages = [0.15, 0.18, 0.2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        print("Hello")
        
        view.endEditing(true)
    }
    
    @IBAction func tipValueChanged(_ sender: UISlider) {
        //Updates the slider
        percentageLabel.text = String(format: "%.0f",tipSlider.value * 100)
        percentageLabel.text?.append("%")
        tipPercentage = Double(tipSlider.value)
        
        //Has to recalculate every time slider changes
        calculateTip(1)
    }
    
    @IBAction func onControlChanged(_ sender: Any) {
        
        //When tip control is changed it will update everything
        tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        tipSlider.setValue(Float(tipPercentages[tipControl.selectedSegmentIndex]), animated: true)
        percentageLabel.text = String(Int(tipPercentages[tipControl.selectedSegmentIndex] * 100))
        percentageLabel.text?.append("%")
        calculateTip(2)
        
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        //Get bill $ & numbr of people
        let bill = Double(billField.text!) ?? 0
        var people = Int(numberPoepleField.text!) ?? 0
        
        if people <= 0 {people = 1}
        
        //Clculate tip and total
        let tip = bill * tipPercentage
        let total = (bill + tip)/Double(people)
        
        //Update tip and total
        tipLabel.text = String(format: "$%.2f", tip)
        if people == 1{ totalLabel.text = String(format: "$%.2f", total) }
        else{ totalLabel.text = String(format: "$%.2f / person", total)}
        
    }
}

