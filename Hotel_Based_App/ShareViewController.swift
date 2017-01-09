

import UIKit
import MapKit
import HealthKit
import Social
import MessageUI

class ShareViewController: UIViewController,UINavigationControllerDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate{

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var facebook: UIButton!
    
    @IBOutlet weak var twitter: UIButton!
    
    @IBOutlet weak var gmail: UIButton!
    
    @IBOutlet weak var iMessage: UIButton!
    
    var objRechability = Reachability.reachabilityForInternetConnection()
    
    var body: String! = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = body
    }

    @IBAction func Facebook(_ sender: AnyObject) {
        
        if objRechability!.isReachable()
        {
            shareFacebook()
        }
        else
        {
            Util .invokeAlertMethod("Warning", strBody: "Internet connection not available.", delegate: self)
        }
    }

    @IBAction func Twitter(_ sender: AnyObject) {
        
        if objRechability!.isReachable()
        {
            shareTwitter()
        }
        else
        {
            Util .invokeAlertMethod("Warning", strBody: "Internet connection not available.", delegate: self)
        }
        

        
    }
    
    
    @IBAction func gMail(_ sender: AnyObject) {
        if objRechability!.isReachable()
        {
            shareMail()
        }
        else
        {
            Util .invokeAlertMethod("Warning", strBody: "Internet connection not available.", delegate: self)
        }

        
    }

func shareFacebook()
{
    let fvc: SLComposeViewController=SLComposeViewController(forServiceType: SLServiceTypeFacebook)
    fvc.completionHandler =
        {
            result -> Void in
            let getResult = result as SLComposeViewControllerResult;
            switch(getResult.rawValue)
            {
            case SLComposeViewControllerResult.cancelled.rawValue:
                Util .invokeAlertMethod("Warning", strBody: "Post Cancalled", delegate: self)
            case SLComposeViewControllerResult.done.rawValue:
                Util .invokeAlertMethod("Warning", strBody: "Post Successfull.", delegate: self)
            default:
                Util .invokeAlertMethod("Warning", strBody: "Error Occured.", delegate: self)
            }
            self.dismiss(animated: true, completion: nil)
    }
    self.present(fvc, animated: true, completion: nil)
    fvc.setInitialText(body)
    //        fvc.addImage(ivImage.image)
    fvc.add(URL(string: "www.google.com"))
}

func shareTwitter()
{
    let tvc: SLComposeViewController=SLComposeViewController(forServiceType: SLServiceTypeTwitter)
    tvc.completionHandler =
        {
            result -> Void in
            let getResult = result as SLComposeViewControllerResult;
            switch(getResult.rawValue)
            {
            case SLComposeViewControllerResult.cancelled.rawValue:
                Util .invokeAlertMethod("Warning", strBody: "Post Cancalled", delegate: self)
            case SLComposeViewControllerResult.done.rawValue:
                Util .invokeAlertMethod("Warning", strBody: "Post Successfull.", delegate: self)
            default:
                Util .invokeAlertMethod("Warning", strBody: "Error Occured.", delegate: self)
            }
            self.dismiss(animated: true, completion: nil)
    }
    self.present(tvc, animated: true, completion: nil)
    tvc.setInitialText(body)
    //        tvc.addImage(ivImage.image)
    tvc.add(URL(string: "www.google.com"))
}

func shareiMessage()
{
    let controller: MFMessageComposeViewController=MFMessageComposeViewController()
    if(MFMessageComposeViewController .canSendText())
    {
        controller.body = body
        controller.addAttachmentData(UIImageJPEGRepresentation(UIImage(named: "images.jpg")!, 1)!, typeIdentifier: "image/jpg", filename: "images.jpg")
        controller.delegate=self
        controller.messageComposeDelegate=self
        self.present(controller, animated: true, completion: nil)
    }
    else
    {
        let alert = UIAlertController(title: "Error", message: "Text messaging is not available", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
{
    switch result.rawValue
    {
    case MessageComposeResult.cancelled.rawValue:
        Util .invokeAlertMethod("Warning", strBody: "Message cancelled", delegate: self)
    case MessageComposeResult.failed.rawValue:
        Util .invokeAlertMethod("Warning", strBody: "Message failed", delegate: self)
    case MessageComposeResult.sent.rawValue:
        Util .invokeAlertMethod("Success", strBody: "Message sent", delegate: self)
    default:
        Util .invokeAlertMethod("Warning", strBody: "error", delegate: self)
    }
    self.dismiss(animated: false, completion: nil)
}

func shareMail()
{
    let mailClass:AnyClass?=NSClassFromString("MFMailComposeViewController")
    if(mailClass != nil)
    {
        if((mailClass?.canSendMail()) != nil)
        {
            displayComposerSheet()
        }
        else
        {
            launchMailAppOnDevice()
        }
    }
    else
    {
        launchMailAppOnDevice()
    }
}
func launchMailAppOnDevice()
{
    let recipients:NSString = "sandeep.kamarajugadda@travelboutiqueonline.com"
    var email:NSString="\(recipients) \(body)" as NSString
    email=email.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
    UIApplication.shared.openURL(URL(string: email as String)!)
}
func displayComposerSheet()
{
    let picker: MFMailComposeViewController=MFMailComposeViewController()
    picker.mailComposeDelegate=self;
    picker .setSubject("Test")
    picker.setToRecipients(["sandeep.kamarajugadda@travelboutiqueonline.com"])
    picker.setMessageBody(self.textView.text, isHTML: true)
    
    // If Any Image Need To be added
//    let data: NSData = UIImagePNGRepresentation(UIImage(named: "Images")!)!
//    
//    picker.addAttachmentData(data, mimeType: "image/png", fileName: "Images")
    
    self.present(picker, animated: true, completion: nil)
}
func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?)
{
    switch result.rawValue
    {
    case MFMailComposeResult.cancelled.rawValue:
        Util .invokeAlertMethod("Warning", strBody: "Mail cancelled", delegate: self)
    case MFMailComposeResult.saved.rawValue:
        Util .invokeAlertMethod("Warning", strBody: "Mail saved", delegate: self)
    case MFMailComposeResult.sent.rawValue:
        Util .invokeAlertMethod("Success", strBody: "Mail sent", delegate: self)
    case MFMailComposeResult.failed.rawValue:
        Util .invokeAlertMethod("Warning", strBody: "Mail sent failure", delegate: self)
    default:
        Util .invokeAlertMethod("Warning", strBody: "error", delegate: self)
    }
    self.dismiss(animated: false, completion: nil)
}
    @IBAction func iMessage(_ sender: AnyObject) {
        shareiMessage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
