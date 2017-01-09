

import UIKit
import CloudKit

class Registrations: UIViewController {

    @IBOutlet weak var emailID: UITextField!
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var familyName: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Registrations.dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(_ sender: AnyObject) {
         if ((self.emailID.text?.isEmpty) == true)
         {
            let alert = UIAlertView(title: "Error", message: "Please Enter Valid EmailID", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
       
        if ((self.userName.text?.isEmpty) == true)
        {
            let alert = UIAlertView(title: "Error", message: "Please Enter UserName", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        if ((self.password.text?.isEmpty) == true)
        {
            let alert = UIAlertView(title: "Error", message: "Please Enter Password", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        if ((self.familyName.text?.isEmpty) == true)
        {
            let alert = UIAlertView(title: "Error", message: "Please Enter Family Name", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        if ((self.name.text?.isEmpty) == true)
        {
            let alert = UIAlertView(title: "Error", message: "Please Enter Your Name", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }



        let container = CKContainer.default()
        let publicData = container.publicCloudDatabase
        
        let record = CKRecord(recordType: "Login")
                record.setValue(self.userName.text, forKeyPath: "UserName")
                record.setValue(self.emailID.text, forKeyPath: "Email")
                record.setValue(self.password.text, forKeyPath: "Password")
                record.setValue(self.familyName.text, forKeyPath: "FamilyName")
                record.setValue(self.name.text, forKeyPath: "Name")
        publicData.save(record, completionHandler: {record, error in
            if error != nil
            {
                print(error)
            }
            else{
                DispatchQueue.main.async{
                let alert = UIAlertView(title: "Success", message: "Successfully Registerd", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
            }
        })
    }
    @IBAction func Back(_ sender: AnyObject) {
           self.dismiss(animated: true, completion: nil)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }

}
