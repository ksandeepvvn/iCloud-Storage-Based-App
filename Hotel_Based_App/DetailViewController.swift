

import UIKit
import CloudKit
import MobileCoreServices


class Room
{
    var AC: String = ""
    var Delux: String = ""
    var DoubleDeluxe: String = ""
    var title: String = ""
    var date: String = ""
    var id: String = ""
}

var hotelNames: String = ""
var acRoom: String = ""
var deluxeRoom: String = ""
var luxuryRoom: String = ""
var record: CKRecordID!
var newDate: Date!

class DetailViewController: UIViewController ,  UITextFieldDelegate {
    let acRoomBooked = hotelRegistrationForm()
    let deluxeRoomBooked = hotelRegistrationForm()
    let luxuryRoomBooked = hotelRegistrationForm()
    let date = hotelRegistrationForm()
    let recordId = hotelRegistrationForm()
    
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var imagess: UIImageView!
    @IBOutlet weak var luxury: UITextField!
    @IBOutlet weak var AC: UITextField!
    @IBOutlet weak var Delux: UITextField!
    @IBOutlet weak var dateAvailable: UILabel!
    @IBOutlet weak var acInput: UITextField!
    @IBOutlet weak var deluxInput: UITextField!
    @IBOutlet weak var luxuryInput: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    

    var detailItem: Friends? {
        didSet {
            self.configureView()
        }
    }
    
    var nextAvialableDates: Friends? {
        didSet{
          self.configureView()
        }
    }
    var titles: Friends? {
        didSet{
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: Friends = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
                print("Description", detail.description)
            }
        }
        if let date: Friends = self.nextAvialableDates {
            if let hotel = self.hotelName
            {
                hotel.text = date.title
                hotel.adjustsFontSizeToFitWidth
            }
            print("Hotel Name", date.title)
            hotelNames = date.title
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        acInput.delegate = self
        acInput.keyboardType = .numberPad
        luxuryInput.delegate = self
        luxuryInput.keyboardType = .numberPad
        deluxInput.delegate = self
        deluxInput.keyboardType = .numberPad
        
        
         self.configureView()
         self.alertIndicatorMessage("Please Wait...")
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(DetailViewController.imageTapped(_:)))
        imagess.isUserInteractionEnabled = true
        imagess.addGestureRecognizer(tapGestureRecognizer)
        
        
        let publicData = CKContainer.default().publicCloudDatabase
        let predName = NSPredicate(format: "Title == %@", hotelNames)
        let query = CKQuery(recordType: "RoomType", predicate: predName)
        publicData.perform(query, inZoneWith: nil) { results, error in
            
            DispatchQueue.main.async(execute: {
                
                if error == nil { // There is no error
                    print(results)
                    
                    for entry in results! {
                        let entries = Room()
                        entries.title = entry["Title"] as! String
                        entries.AC = entry["AC"] as! String
                        entries.Delux = entry["Deluxe"] as! String
                        entries.DoubleDeluxe = entry["Luxury"] as! String
                        entries.date = entry["Date"] as! String
                        record = entry["recordID"] as! CKRecordID
                        
                        print(record)
                        self.AC.text = entries.AC
                        self.Delux.text = entries.Delux
                        self.luxury.text = entries.DoubleDeluxe
                        self.dateAvailable.text = entries.date
                        acRoom = self.acInput.text!
                        
                    }
                   self.dismiss(animated: false, completion: nil)
                }
                else {
                    print(error)
                  self.dismiss(animated: false, completion: nil)
                }
                })
        }
    }
    
    
    
    @IBAction func oneClickListener(_ sender: UIStepper) {
        
    self.luxuryInput.text = Int(sender.value).description
    }
    
    @IBAction func oneClickListener1(_ sender: UIStepper) {
        
        self.acInput.text = Int(sender.value).description
    }
    
    @IBOutlet weak var oneClickListener2: UIStepper!
    
    @IBAction func oneClickListener2(_ sender: UIStepper) {
        
        self.deluxInput.text = Int(sender.value).description
    }

    
    @IBAction func bookNow(_ sender: AnyObject) {
        
        if acInput.text == "" && deluxInput.text == "" && luxuryInput.text == ""
        {
            alertMessage("Input Required")
        }

        let roomType_obj: hotelRegistrationForm = self.storyboard? .instantiateViewController(withIdentifier: "hotelRegistrationForm") as! hotelRegistrationForm
 
            roomType_obj.acRoomBooked = acInput.text!
            roomType_obj.deluxeRoomBooked = deluxInput.text!
            roomType_obj.luxuryRoomBooked = luxuryInput.text!
            roomType_obj.date = dateAvailable.text!
            roomType_obj.recordID = record
        self.navigationController?.pushViewController(roomType_obj, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
func imageTapped(_ sender: UITapGestureRecognizer) {
    let imageView = sender.view as! UIImageView
    let newImageView = UIImageView(image: imageView.image)
 newImageView.frame = self.view.frame
        imagess.frame = self.view.frame
        imagess.backgroundColor = .black()
        imagess.contentMode = .scaleAspectFit
    let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.dismissFullscreenImage(_:)))
    imagess.addGestureRecognizer(tap)
    self.view.addSubview(imagess)
    }
    

    
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
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
        let delay = 5.0 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    
    func alertMessage (_ message: String){
        let alert = UIAlertController(title: "Select Atlease One Room", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
           self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
           self.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }


 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.characters.indices) == nil
    }
}

