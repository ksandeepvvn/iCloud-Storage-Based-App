
import UIKit

class Util: NSObject
{
    class func invokeAlertMethod(_ strTitle: String, strBody: String, delegate: AnyObject?) {
        let alert: UIAlertView = UIAlertView()
        alert.message = strBody
        alert.title = strTitle
        alert.delegate = delegate
        alert.addButton(withTitle: "Ok")
        alert.show()
    }
   
}
