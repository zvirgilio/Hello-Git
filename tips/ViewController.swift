//
//  ViewController.swift
//  tips
//
//  Created by Zachary Virgilio on 12/12/15.
//  Copyright © 2015 Zachary Virgilio. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var tipRateLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    

    // Initialize variables to store the users location and current country
    let locationManager = CLLocationManager()
    var currentCountry = ""
    
    // Initialize a formatter to format currency
    var formatter = NSNumberFormatter()

    // Check if tipping alert has been seen
    var hasSeenAlert: Bool = true
    
    
    // Settings View Controller Delegate methods
    func controller(controller: SettingsViewController, passedTipRate: Double) {
        // Update passedTipRate
        tipRate = passedTipRate
    }
    
    var tipRate: Double!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set up the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CFloat(UIDevice.currentDevice().systemVersion)! >= 8.0 {
            self.locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
        
        
        /*TO DO: Finish getting location info, use it to format the string of price, then access info about tipping in the current country
        */
        
        
        formatter.numberStyle = .CurrencyStyle
        let locID = "es_"+self.currentCountry
        formatter.locale = NSLocale(localeIdentifier: locID)
        
        tipRate = 0.20
        tipLabel.text = formatter.stringFromNumber(0.00)
        tipRateLabel.text = "\(100*tipRate)%"
        totalLabel.text = formatter.stringFromNumber(0.00)

        
        billField.placeholder = "Bill Amount"
    }

    
    
    // Open keyboard on app load
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        billField.becomeFirstResponder()
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
        
        formatter.numberStyle = .CurrencyStyle
        let locID = "es_"+self.currentCountry
        formatter.locale = NSLocale(localeIdentifier: locID)
        
        tipLabel.text = formatter.stringFromNumber(tip)
        tipRateLabel.text = "\(100*tipRate)%"
        totalLabel.text = formatter.stringFromNumber(total)
    }
    
    
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        billField.placeholder = nil;
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
    
    
    
    // Console Error if location update fails
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    
    
    // Retrieve the current location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLoc: CLLocation = locations[locations.endIndex-1]
        
        // Reverse geocode the location to retreive the country string
        CLGeocoder().reverseGeocodeLocation(currentLoc, completionHandler: {(placemarks, error)->Void in
            var placemark: CLPlacemark!
            
            if error == nil && placemarks!.count > 0 {
                placemark = placemarks![0] as CLPlacemark
                
                var countryString : String = ""
            
                if placemark.country != nil {
                    countryString = placemark.ISOcountryCode!
                }
                // Check if an alrt on tipping should be given
                print(countryString)
                self.shouldAlert(countryString)
                
                // Update the country string
                self.currentCountry = countryString
                self.updateTip()
                
            }
        })
    }
    
    
    
    // Initialize and call an alert that tipping may not be appropriate in your location
    func tipMayNotBeAppropriate() {
        // Initialize an alert that tipping may not be customary in your location
        let tipAlert = UIAlertController(title: "Attention", message:  "Tipping may not be customary in your location", preferredStyle:  .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            print("cancel")
        }
    
        //Take the user to a webpage with information about tipping in England
        let moreInfoAction = UIAlertAction(title: "Learn more", style: .Default) { (action) in
            print("Learn more")
            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.tripadvisor.com/Travel-g186216-s606/United-Kingdom:Tipping.And.Etiquette.html")!)
        }
        
        tipAlert.addAction(cancelAction)
        tipAlert.addAction(moreInfoAction)
        
        self.presentViewController(tipAlert, animated: true, completion: nil)
    }
    
    
    
    // Decide if the alert on tipping should be called, call this function before currentCountry is updated
    func shouldAlert(newLoc: String) {
        //Check if the new country is different that the previous country
        if newLoc != self.currentCountry {
            self.hasSeenAlert = false
        }
        // Call the alert for this country if it hasn't been called yet and is applicable
        if !self.hasSeenAlert{
            if newLoc == "GB" {
                self.tipMayNotBeAppropriate()
                self.hasSeenAlert = true
            }
        }
    }
    
    

}


extension ViewController: SettingsViewControllerDelegate {
    func updateTipRate(data: Double) {
        self.tipRate = data
    }
}