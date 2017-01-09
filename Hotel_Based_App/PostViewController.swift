

import UIKit
import CloudKit
import MobileCoreServices



class login
{
    var userName: String = ""
    var password: String = ""
}
class PostViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var titleInput: UITextField!
    @IBOutlet var descriptionInput: UITextView!
    @IBOutlet weak var images: UIImageView!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var currency: UITextField!
    
    var photoUrl: URL?
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectPhoto(_ sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
        self.present(imagePicker, animated: true, completion:nil)
        print("Image Saved Wonderfull")
        
    }
    
    @IBAction func postPressed(_ sender: AnyObject) {
        let bug = Friends()
        if (photoUrl == nil) {
            print("Need To Upload Image as Mandatory")
            return
        }
        
        let asset = CKAsset(fileURL: photoUrl!)
        
        let container = CKContainer.default()
        let publicData = container.publicCloudDatabase

        let record = CKRecord(recordType: "Friends")
        record.setValue(titleInput.text, forKey: "Title")
        record.setValue(descriptionInput.text, forKey: "Description")
        record.setValue(asset, forKey: "Image")
        record.setValue(location.text, forKey: "Location")
        record.setValue(currency.text, forKey: "Price")
        publicData.save(record, completionHandler: { record, error in
            if error != nil {
                print(error)
            }
            else{
                print("Sucessfully Posted")
            }
        })
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        images.image = image
        photoUrl = saveImageToFile(image)
    }


    func saveImageToFile(_ image: UIImage) -> URL
    {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let docsDir: AnyObject = dirPaths[0] as AnyObject
        
        let filePath = docsDir.appendingPathComponent("currentImage.png")
        
        try? UIImageJPEGRepresentation(image, 0.5)!.write(to: URL(fileURLWithPath: filePath), options: [.atomic])
        
        return URL(fileURLWithPath: filePath)
    }
}
