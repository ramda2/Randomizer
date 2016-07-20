import UIKit

class ProfileSelectorViewController: UIViewController {
    
    @IBOutlet weak var profilePicker: UIPickerView!
    var pickerDataSource = ["Choose...", "Enemy", "Best Friend", "Boyfriend", "Girlfriend"]
    var gender: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //declare profile picker's source of information
        self.profilePicker.dataSource = self;
        self.profilePicker.delegate = self;
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        Get the new view controller using segue.destinationViewController.
        //        Pass the selected object to the new view controller.
        if segue.identifier == "chooseProfile" {
            let destinationVC = segue.destinationViewController as! ProfileViewController
            destinationVC.genderSelection = gender
        }
    }
    
    //declare back bar button
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
    }
}

extension ProfileSelectorViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // numberOfComponentsInPickerView method used for the number of columns in the picker element.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    //numberOfRowsInComponent method used for the number of rows of data in the UIPickerView element so we return the array count.
    func pickerView(profilePicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    // pickerView:titleForRow:forComponent: method used for the data for a specific row and specific component.
    func pickerView(profilePicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(profilePicker: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //debugging purposes
        if(row == 0){ }
        if(row == 1) { print("\(pickerDataSource[row]) clicked") }
        if(row == 2) { print("\(pickerDataSource[row]) clicked") }
        //filter between genders when retrieving profiles
        if(row == 3)
        {
            gender = "male"
            print("\(pickerDataSource[row]) clicked")
        }
        if(row == 4)
        {
            gender = "female"
            print("\(pickerDataSource[row]) clicked")
        }
        self.performSegueWithIdentifier("chooseProfile", sender: self)
    }
    
    //change text color within picker view
    func pickerView(profilePicker: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!
        
        attributedString = NSAttributedString(string: pickerDataSource[row], attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        
        return attributedString
    }
}

/*
 MARK: - Navigation
 
 In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 Get the new view controller using segue.destinationViewController.
 Pass the selected object to the new view controller.
 }
 */


