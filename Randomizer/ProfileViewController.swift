//
//  ProfileSelectorViewController.swift
//  Randomizer
//
//  Created by ANGELIE RAMDIAL on 7/9/16.
//  Copyright © 2016 ANGELIE RAMDIAL. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator
import SwiftyJSON

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    var genderSelection: String?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //convert profile image shape to circle after load
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.clipsToBounds = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //create spinner to inform user that data will appear
    func createSpinner(targetView: UIView) -> UIActivityIndicatorView {
        let loadingSpinner = UIActivityIndicatorView()
        loadingSpinner.activityIndicatorViewStyle = .WhiteLarge
        loadingSpinner.color = UIColor.blueColor()
        let spinnerSize = loadingSpinner.frame.width // we only need the width because it's square
        let x = (self.view.frame.width - spinnerSize) / 2
        let y = (self.view.frame.height - spinnerSize) / 2
        loadingSpinner.frame = CGRectMake(x, y, spinnerSize, spinnerSize)
        targetView.addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
        return loadingSpinner
    }
    
    func fetchRandomProfile(gender: String?, callbackFunc: (JSON) -> ()) {
        // create an activityIndicator object
        let loadingSpinner = self.createSpinner(self.view)
        var params = [:]
        let apiToContact = "https://randomuser.me/api/"
        // This code will call the
        if gender != nil {
            params = ["gender" : gender!]
        }
        //retrieving JSON information from API URL
        Alamofire.request(.GET, apiToContact, parameters: params as? [String : AnyObject]).validate().responseJSON() { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    //print(value)
                    callbackFunc(JSON(value))
                    
                }
            case .Failure(let error):
                print(error)
            }
            //terminate spinner
            loadingSpinner.stopAnimating()
            self.view.willRemoveSubview(loadingSpinner)
        }
    }
    
    //toggle effect works when user shakes device
    //*****************************************************************************
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent!) {
        if(event.subtype == UIEventSubtype.MotionShake) {
            //randomly pull the same gender when toggled
            self.replaceRandomProfile(genderSelection)
        }
    }
    //*****************************************************************************
    
    override func viewDidLoad() {
        //callback method retrieves json after API request has been reached
        super.viewDidLoad()
        self.profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2.0
        self.profileImageView.clipsToBounds = true
        
        self.replaceRandomProfile(genderSelection)
    }
    
    func replaceRandomProfile(gender: String?) {
        fetchRandomProfile(gender) { (json) in
            //retrieve image URL from json & contact info
            let imageLink = json["results"][0]["picture"]["large"].stringValue
            let firstName = json["results"][0]["name"]["first"].stringValue.capitalizedString
            let lastName = json["results"][0]["name"]["last"].stringValue.capitalizedString
            let name = "\(firstName) \(lastName)"
            let cellPhone = json["results"][0]["cell"].stringValue
            let city = json["results"][0]["location"]["city"].stringValue.capitalizedString
            let region = json["results"][0]["location"]["state"].stringValue.capitalizedString
            let age = (arc4random_uniform(50) + 20)
            
            
            //NSURL class takes the URL location/file path we pass as the parameter we are going to examine
            let url = NSURL(string: imageLink)
            
            //store the URL data into class property data of type NSDATA
            if let data = NSData(contentsOfURL:url!) {
                //set the profile image to downloaded data from URL
                self.profileImageView?.image = UIImage(data: data)
                self.nameTextField.text = name
                self.ageTextField.text = "\(age)"
                self.phoneTextField.text = cellPhone
                self.cityTextField.text = city
                self.regionTextField.text = region
            }
        }
    }
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

