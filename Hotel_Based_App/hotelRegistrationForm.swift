

import UIKit
import CloudKit
import MessageUI
import EventKit


class hotelRegistrationForm: UIViewController {

    
    var test:Bool = false
    var  acRoomBooked: String = " "
    var deluxeRoomBooked: String = " "
    var luxuryRoomBooked: String = " "
    var date: String = " "
    var recordID: CKRecordID!
    var recordID2: CKRecordID!
    var aRecord: CKRecord!
     var finalAcRoomBooked: Int = 0
    var body: String = ""
    
    @IBOutlet var address: UITextField!
    
    @IBOutlet var contactNumber: UITextField!
    
    @IBOutlet var familyName: UITextField!
    
    @IBOutlet var name: UITextField!
    
    @IBOutlet weak var ac: UITextField!
    
    @IBOutlet weak var deluxe: UITextField!

    @IBOutlet weak var date_Selected: UILabel!
    
    @IBOutlet weak var luxury: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ac.text = acRoomBooked
        deluxe.text = deluxeRoomBooked
        luxury.text = luxuryRoomBooked
        date_Selected.text = date
     
        
        let container = CKContainer.default()
        let publicDatabase = container.publicCloudDatabase
        let query = CKQuery(recordType: "RoomType", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
                publicDatabase.perform(query, inZoneWith: nil) { results, error in
                    if error == nil
                    {
                        print(results)
                        for entry in results! {

                            let entries = Room()
                            entries.title = entry["Title"] as! String
                            entries.AC = entry["AC"] as! String
                            entries.Delux = entry["Deluxe"] as! String
                            entries.DoubleDeluxe = entry["Luxury"] as! String
                            entries.date = entry["Date"] as! String
                            self.recordID2 = entry["recordID"] as! CKRecordID
                            
                            if self.recordID == self.recordID2
                            {
                                print("Please Post Here")
                                if self.ac.text == ""
                                {
                                   self.finalAcRoomBooked = Int(entries.AC)! - 0
                                }
                                else
                                {
                                self.finalAcRoomBooked = Int(entries.AC)! - Int(self.acRoomBooked)!
                                }
                                print(self.finalAcRoomBooked)
                                print("Operations Need to be performed on this record \(self.recordID)")
                            }
                        }
                    }
                }
            }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func proceedToPayment(_ sender: AnyObject) {
//        self.sendEmail()
//        let container = CKContainer.defaultContainer()
//        let publicDatabase = container.publicCloudDatabase
//        publicDatabase.fetchRecordWithID(recordID, completionHandler: { (record, error) in
//    if error != nil {
//                print("Error fetching record: \(error!.localizedDescription)")
//                        }
//    else {
//                record!.setObject(String(self.finalAcRoomBooked), forKey: "AC")
//                publicDatabase.saveRecord(record!, completionHandler: { (savedRecord, saveError) in
//    if saveError != nil {
//                        print("Error saving record: \(saveError!.localizedDescription)")
//                                }
//    else {
//                        print("Successfully updated record!")
//                        
//                        //Dismiss Of Activity Indicator
//                       self.dismissViewControllerAnimated(false, completion: nil)
//                        // End Of Activity Indicator
////                        self.alertMessage("Your Request has been Succesfully Updated")
//                        
//                    }
//                })
//            }
//        })
        let pay: payment = self.storyboard?.instantiateViewController(withIdentifier: "payment") as! payment
        self.navigationController?.pushViewController(pay, animated: true)
    }
    
    func alertIndicatorMessage (_ message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func alertMessage (_ message: String){
       let alert = UIAlertController(title: "Success", message: message, preferredStyle: UIAlertControllerStyle.alert)
       alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        let home: MasterViewController = self.storyboard? .instantiateViewController(withIdentifier: "MasterViewController") as! MasterViewController
        self.navigationController?.pushViewController(home, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        present(alert, animated: true, completion: nil)
    }

    @IBAction func subscribe(_ sender: AnyObject) {

        let publicDatabase = CKContainer.default().publicCloudDatabase
        let friendsSubscription = CKSubscription(recordType: "Friends",predicate: NSPredicate(format: "TRUEPREDICATE"), options: .firesOnRecordCreation)
        let notification = CKNotificationInfo()
        notification.alertBody = "New Notifacation Updated"
        notification.shouldBadge = false
        friendsSubscription.notificationInfo = notification
        publicDatabase.save(friendsSubscription, completionHandler: {recordReturned, error in
            if error != nil
            {
                OperationQueue.main.addOperation {
                    self.alertMessageforSubscription((error?.localizedDescription)!)
                   
                }
            }
            else
            {
                OperationQueue.main.addOperation
                    {
                        self.alertMessageforSubscription("Subscription Record Was Inserted Properly")
                }
            }
}) 
}
    
    
    @IBAction func Share(_ sender: AnyObject) {
        
                                    let home: ShareViewController = self.storyboard? .instantiateViewController(withIdentifier: "ShareViewController") as! ShareViewController
                                    self.navigationController?.pushViewController(home, animated: true)
                                                                }
    
    
    func alertMessageforSubscription(_ message: String)
        
        
    {
                        let alert = UIAlertController(title: "Success", message: message, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
    
                        let home: MasterViewController = self.storyboard? .instantiateViewController(withIdentifier: "MasterViewController") as! MasterViewController
                        self.navigationController?.pushViewController(home, animated: true)
                            
    }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
    }))
        present(alert, animated: true, completion: nil)
    }
    func sendEmail() {
        body = "Your Room Booked On \(self.date) \n Number of Rooms Booked \(self.acRoomBooked) \n Thank you For Booking With Us Raj Villas \n Booked BY: \(self.name.text) \n Family Name: \(self.familyName.text) \n Contact Number \(self.contactNumber.text)"
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.setToRecipients(["sandeep.kamarajugadda@travelboutiqueonline.com"])
        mailComposerVC.setSubject("Hotel Room Booked")
        mailComposerVC.setMessageBody(body, isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    func mailComposeController(_ controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismiss(animated: true, completion: nil) 
    }
    
    func PostEvent()
    {
        
    }
}
