//
//  SettingsViewController.swift
//  tips
//
//  Created by Zachary Virgilio on 12/12/15.
//  Copyright © 2015 Zachary Virgilio. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func updateTipRate(data: Double)
    
}

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tipRatePicker: UIPickerView!

    var delegate: SettingsViewControllerDelegate?
    
    var tipRatePickerData: [String] = [String]()
    var newTipRate = 0.2
    
    // Array of double tip rates
    let tipRates = [0.10, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.20, 0.22, 0.24, 0.26, 0.28, 0.30]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Connect Data
        self.tipRatePicker.delegate = self
        self.tipRatePicker.dataSource = self
        
        // Input data to the Array
        tipRatePickerData = ["10%","11%", "12%","13%", "14%","15%", "16%","17%", "18%","19%", "20%", "22%", "24%", "26%", "28%", "30%"]
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    //The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipRatePickerData.count
    }

    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipRatePickerData[row]
    }
    
    //Capture picker view data selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //TO DO: check if this works
            newTipRate = tipRates[tipRatePicker.selectedRowInComponent(0)]
        
            self.delegate?.updateTipRate(newTipRate)
    }
    // Store new user data on exit
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(newTipRate, forKey: "updatethiskeyplease")
        defaults.synchronize()
    }

}
