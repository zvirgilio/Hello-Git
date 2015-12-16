//
//  ViewController.swift
//  tips
//
//  Created by Zachary Virgilio on 12/12/15.
//  Copyright © 2015 Zachary Virgilio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var tipRateLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    // Settings View Controller Delegate methods
    func controller(controller: SettingsViewController, passedTipRate: Double) {
        // Update passedTipRate
        tipRate = passedTipRate
    }
    
    var tipRate: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        // For users with no stored data
        tipRateLabel.text = "20.0%"
        tipRate = 0.20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Update the tip and total caclulations
    @IBAction func updateTip() {
        let tipPercentage = tipRate
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        
        tipLabel.text = "$\(tip)"
        tipRateLabel.text = "$\(100*tipRate)%"
        totalLabel.text = "$\(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateTip()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "settingsSegue"){
            (segue.destinationViewController as! SettingsViewController).delegate = self
            }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        self.tipRate = defaults.doubleForKey("updatethiskeyplease")
        updateTip()
    }
   
}


extension ViewController: SettingsViewControllerDelegate {
    func updateTipRate(data: Double) {
        self.tipRate = data
    }
}