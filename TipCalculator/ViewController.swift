//
//  ViewController.swift
//  TipCalculator
//
//  Created by Joao on 12/13/20.
//  Copyright © 2020 Joao. All rights reserved.
//

//TODO: On settings page create round up or round down option

import UIKit
import QuartzCore

class ViewController: UIViewController {

    //Outlets from Main.Storyboard
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var numberPoepleField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var peopleStepper: UIStepper!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var perPerson: UILabel!
    
    //Defaults used to get all the default info from settings
    let defaults = UserDefaults.standard
    
    //Variables for default tip % and control numbers
    var tipPercentage = 0.15
    let tipPercentages = [0.15, 0.18, 0.2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //prompts user to type on bill field as soon as it opens
        self.billField.becomeFirstResponder()
        
        //Rounding corners of views
        topView.layer.cornerRadius = 10; middleView.layer.cornerRadius = 10
        topView.layer.masksToBounds = true; middleView.layer.masksToBounds = true
        
        //navigationController?.navigationBar.barTintColor = UIColor(red: 0.004, green: 0.043, blue: 0.447, alpha: 1.0)
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    
        //navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //This is the setup from the default tip that has to be updated
        tipPercentage = (defaults.double(forKey: "tipDefault"))/100
        tipSlider.setValue(Float(tipPercentage), animated: true)
        percentageLabel.text = String(Int(tipPercentage * 100))
        percentageLabel.text?.append("%")
        if tipPercentage == 0.15 {tipControl.selectedSegmentIndex = 0}
        else if tipPercentage == 0.18 {tipControl.selectedSegmentIndex = 1}
        else if tipPercentage == 0.20 {tipControl.selectedSegmentIndex = 2}
        calculateTip(5)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onTap(_ sender: Any) { view.endEditing(true) }
    
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
    
    @IBAction func onStepper(_ sender: Any) {
        //Updates text field if ++ or -- [1 to 20]
        numberPoepleField.text = String(Int(peopleStepper.value))
        calculateTip(6)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        //Sets up formatter for currency
        let formatter = NumberFormatter()
        let localeCode : String = defaults.string(forKey: "localeCode")!
        
        //Get bill $ & numbr of people
        
        var bill = Double(billField.text!) ?? 0
        var people = Int(numberPoepleField.text!) ?? 0
        
        //Makes sure bill & people are within boundaries
        if bill < 0 {bill = 0; billField.text = String(bill)}
        if people <= 0 {people = 1; numberPoepleField.text = String(people)}
        
        //Clculate tip and total
        let tip = bill * tipPercentage as NSNumber
        let total = ((bill + (bill * tipPercentage))) as NSNumber
        let perPersonTotal = ((bill + (bill * tipPercentage))/Double(people)) as NSNumber
        
        //Creates new formatter and sets it to currency mode
        //TODO: Add default currency in settings page
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: localeCode)
        
        //Update tip and total
        tipLabel.text = formatter.string(from: tip)
        totalLabel.text = formatter.string(from: total)
        perPerson.text = formatter.string(from: perPersonTotal)
        
    }
}

