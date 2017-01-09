  //case1
  //        aRecord = CKRecord(recordType: "RoomType", recordID: self.recordID)
  //        let container = CKContainer.defaultContainer()
  //        let publicDatabase = container.publicCloudDatabase
  //
  //
  //        publicDatabase.fetchRecordWithID(recordID, completionHandler: { record, error in
  //            if let fetchError = error {
  //                print("An Error Occured in \(fetchError)")
  //            }
  //            else{
  //                record!.setObject("Honey", forKey: "Title")
  //            }
  //})
  //        publicDatabase.saveRecord(aRecord, completionHandler: { record, error in
  //            if let saveError = error {
  //                print("An Error Occured in \(saveError)")
  //            }
  //            else
  //            {
  //                print("Record Saved")
  //            }
  //})
  //        let ckRecordsArray = [CKRecord]()
  //        let ops: CKModifyRecordsOperation  = CKModifyRecordsOperation(recordsToSave: ckRecordsArray, recordIDsToDelete: nil)
  //        ops.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
  //        publicDatabase.addOperation(ops)
  //
  //        let saveRecordOperation = CKModifyRecordsOperation()
  //        saveRecordOperation.recordsToSave = ckRecordsArray
  //        saveRecordOperation.savePolicy = .IfServerRecordUnchanged
  //
  //        saveRecordOperation.modifyRecordsCompletionBlock = { savedRecords, deletedRecordsIDs, error in
  //            if error != nil {
  //                print("Error saving records: \(error!.localizedDescription)")
  //            } else {
  //                print("Successfully updated all the records")
  //            }
  //        }
  //        publicDatabase.addOperation(saveRecordOperation)
  //    }
  
  
  //
  //        let query = CKQuery(recordType: "RoomType", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
  //        publicDatabase.performQuery(query, inZoneWithID: nil) { results, error in
  //            if error == nil
  //            {
  //                print(results)
  //                for entry in results! {
  //
  //                    let entries = Room()
  //                    entries.title = entry["Title"] as! String
  //                    entries.AC = entry["AC"] as! String
  //                    entries.Delux = entry["Deluxe"] as! String
  //                    entries.DoubleDeluxe = entry["Luxury"] as! String
  //                    entries.date = entry["Date"] as! String
  //                    self.recordID2 = entry["recordID"] as! CKRecordID
  //                        let finalAcRoomBooked: Int
  //                        print("Please Post Here")
  //                        finalAcRoomBooked = Int(entries.AC)! - Int(self.acRoomBooked)!
  //                        print(finalAcRoomBooked)
  //
  //
  //                        print("Operations Need to be performed on this record \(self.recordID)")
  //
  //                        let postRecord = CKRecord(recordType: "RoomType", recordID: self.recordID)
  //                        postRecord.setObject("NewHotel", forKey: "Title")
  //                        postRecord.setObject("10", forKey: "AC")
  //                        postRecord.setObject("13", forKey: "Deluxe")
  //                        postRecord.setObject("25-10-2016", forKey: "Date")
  //                        postRecord.setObject("25", forKey: "Luxury")
  //                        let saveRecordOperation = CKModifyRecordsOperation()
  //                        saveRecordOperation.recordsToSave = [postRecord]
  //                        saveRecordOperation.savePolicy = .IfServerRecordUnchanged
  //                        saveRecordOperation.perRecordCompletionBlock = {(postRecord: CKRecord?,  error:NSError?) -> Void in
  //
  //                            print("perRecordCompletionBlock \(postRecord)")
  //
  //                    publicDatabase.saveRecord(postRecord!, completionHandler: { postRecord, error in
  //                        if error != nil
  //                        {
  //                            print("An Error Occured \(error)")
  //
  //                        } else{
  //                            print("Saved Successfully")
  //                        } })
  //                }
  //
  //                }}}}
  //
  //        let container = CKContainer.defaultContainer()
  //        let publicData = container.publicCloudDatabase
  //
  //
  //        let record = CKRecord(recordType: "Reservation")
  //        record.setValue(name.text, forKey: "Name")
  //        record.setValue(familyName.text, forKey: "FamilyName")
  //        record.setValue(contactNumber.text, forKey: "phoneNumber")
  //        record.setValue(address.text, forKey: "address")
  //
  //
  //        publicData.saveRecord(record, completionHandler: { record, error in
  //            if error != nil {
  //
  //                let alert = UIAlertView(title: "Error", message: "Please Try Again", delegate: self, cancelButtonTitle: "OK")
  //                alert.show()
  //                print(error)
  //            }
  //            else{
  //                print("Sucessfully Posted")
  //            }
  //        })
  //
  //        let alert = UIAlertView(title: "Sucess", message: "Your Details Have Been Updated", delegate: self, cancelButtonTitle: "OK")
  //        alert.show()
  //        self.dismissViewControllerAnimated(true, completion: nil)
  
  //    func dismissKeyboard() {
  //        view.endEditing(true)
  //    }
  
  // NS Predicate similar for Where Clause
  
  // let predName = NSPredicate(format: "UserName CONTAINS %@", "Smith")
  //        let customTypes = [2, 3]
  //        let time = 86400
  //        let fromDateDay: Double = (NSDate().timeIntervalSinceReferenceDate - time)
  //        let predDate = NSPredicate(format: "date >= %f", fromDateDay)
  //        let predBlocked = NSPredicate(format: "blocked != %d", 1)
  //        pred = NSCompoundPredicate(andPredicateWithSubpredicates: [customTypes, predDate, predBlocked, predName])
  
  //NSPredicate(format: "recordID IN %@ OR (recordID IN %@ AND user = %@)", followIDs, postIDs, userRef)
  
  
  
/// Share Details threw Message Uisng Mesage UI
  
  
//  @IBAction func sendMessage(sender: AnyObject) {
//    var messageVC = MFMessageComposeViewController()
//    
//    messageVC.body = "Enter a message";
//    messageVC.recipients = ["Enter tel-nr"]
//    messageVC.messageComposeDelegate = self;
//    
//    self.presentViewController(messageVC, animated: false, completion: nil)
//  }
//  func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
//    switch (result.value) {
//    case MessageComposeResultCancelled.value:
//        println("Message was cancelled")
//        self.dismissViewControllerAnimated(true, completion: nil)
//    case MessageComposeResultFailed.value:
//        println("Message failed")
//        self.dismissViewControllerAnimated(true, completion: nil)
//    case MessageComposeResultSent.value:
//        println("Message was sent")
//        self.dismissViewControllerAnimated(true, completion: nil)
//    default:
//        break;
//    }
//  }
  
  // End Of Sharing Message Using Message Ui