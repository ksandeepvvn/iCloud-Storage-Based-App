//
//  payment.swift
//  CloudBug
//
//  Created by admin on 18/07/16.
//  Copyright © 2016 TutsPlus. All rights reserved.
//

import UIKit

class payment: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    @IBOutlet weak var expireDateTextField: UITextField!

    @IBOutlet weak var cvcTextField: UITextField!

    @IBOutlet weak var amountTextField: UITextField!

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet var textFields: [UITextField]!
    
    // MARK: - Text field delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    
    // MARK: Actions
    
    @IBAction func donate(_ sender: AnyObject) {
        // Initiate the card
        let stripCard = STPCard()
        
        var expirationDate1: UInt!
        var expiartionDate2: UInt!
        
        // Split the expiration date to extract Month & Year
        if self.expireDateTextField.text!.isEmpty == false {
            let expirationDate = self.expireDateTextField.text!.components(separatedBy: "/")
            expirationDate1 =  UInt(expirationDate[0])!
            let expMonth = expirationDate1
            expiartionDate2 = UInt(expirationDate[1])!
            let expYear = expiartionDate2
            
            // Send the card info to Strip to get the token
            stripCard.number = self.cardNumberTextField.text
            stripCard.cvc = self.cvcTextField.text
            stripCard.expMonth = expMonth!
            stripCard.expYear = expYear!
        }
        
        var underlyingError: NSError?
        do {
            try stripCard.validateReturningError()
            underlyingError = nil
        }
        catch let error1 as NSError
        {
            underlyingError = error1
        }
        if underlyingError != nil {
            self.spinner.stopAnimating()
            self.handleError(underlyingError!)
            return
        }
        
        STPAPIClient.shared().createToken(with: stripCard, completion: { (token, error) -> Void in
            
            if error != nil {
                self.handleError(error! as NSError)
                return
            }
            
            self.postStripeToken(token!)
        })
    }
    
    func handleError(_ error: NSError) {
        print(error)
        UIAlertView(title: "Please Try Again",
                    message: error.localizedDescription,
                    delegate: nil,
                    cancelButtonTitle: "OK").show()
    }
    
    func postStripeToken(_ token: STPToken) {
        
        let amount = Int(self.amountTextField.text!)
        let URL = "http://localhost/donate/payment.php"
        let params: [String : AnyObject] = ["stripeToken": token.tokenId as AnyObject,
                                            "amount": amount! as AnyObject,
                                            "currency": "usd" as AnyObject,
                                            "description": self.emailTextField.text! as AnyObject]
        
        let manager = AFHTTPRequestOperationManager()
        manager.post(URL, parameters: params, success: { (operation, responseObject) -> Void in
            
            if let response = responseObject as? [String: String] {
                UIAlertView(title: response["status"],
                    message: response["message"],
                    delegate: nil,
                    cancelButtonTitle: "OK").show()
            }
            
        }) { (operation, error) -> Void in
            self.handleError(error!)
        }
    }
}

