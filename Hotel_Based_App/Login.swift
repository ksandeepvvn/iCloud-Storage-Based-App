

import UIKit
import CloudKit

class Login: UIViewController {

    @IBOutlet weak var userName_textField: UITextField!
    
    @IBOutlet weak var password_textField: UITextField!
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Login.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(_ sender: AnyObject) {
        
        if ((userName_textField.text?.isEmpty) == true)
        {
            alertMessage("Please Enter Valid Name")
        }
        if ((password_textField.text?.isEmpty) == true)
        {
            alertMessage("Please Enter Valid Password")
        }
        let container = CKContainer.default()
        let publicDatabase = container.publicCloudDatabase
        
        let query = CKQuery(recordType: "Login", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
//           query.sortDescriptors = [NSSortDescriptor(key: "UserName", ascending: true)]

        
        publicDatabase.perform(query, inZoneWith: nil) { results, error in
            if error == nil { // There is no error
                for users in results! {
                    let user = login()
                    user.userName = users["UserName"] as! String
                    print(user.userName)
                    user.password = users["Password"] as! String
                    
                    DispatchQueue.main.async{
                        
                        let userName = self.userName_textField.text
                        let password = self.password_textField.text
                    if (userName == user.userName)
                    {
                       print("User Name is Matching")
                        if(password == user.password)
                        {
                        
                        self.alertsMessage("Please Enter Correct User Name")
                        }
                        else{
                            
                            self.alertsMessage("Please Enter Correct Password")
                        }
                        }
                        else
                    {
                        self.alertsMessage("User Name Is Not Valid")
                        
                        }
//                
                    }
                }
            }
            else
            {
                print(error)
            }
        }
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }

    func alertMessage(_ message: String)
    {
        let alert = UIAlertView(title: "InValid", message: "User Name Is Not Valid", delegate: self, cancelButtonTitle: "OK")
        alert.show()

    }
    
    func alertsMessage(_ message: String)
    {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            let home: MasterViewController = self.storyboard? .instantiateViewController(withIdentifier: "MasterViewController") as! MasterViewController
            self.navigationController?.pushViewController(home, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")

        }))
        
        present(alert, animated: true, completion: nil)
    }
    @IBAction func siginingUp(_ sender: AnyObject) {
        //let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Registrations")
      //  self.presentViewController(viewController, animated: true, completion: nil)
    }
}
