

import UIKit
import CloudKit

class Friends{
    var title: String = ""
    var description: String = ""
    var location: String = ""
    var currency: String = ""
    var discount: String = ""
    var available: String = ""
}

class MasterViewController: UITableViewController {

    var objects = [Friends]()    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        alertIndicatorMessage("Please Wait...")
       
        
        
        let container = CKContainer.default()
        let publicData = container.publicCloudDatabase
        
        
        let query = CKQuery(recordType: "Friends", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        
        publicData.perform(query, inZoneWith: nil) { results, error in
            if error == nil
            {
            for bug in results! {
                    let newBug = Friends()
                    newBug.title = bug["Title"] as! String
                    newBug.description = bug["Description"] as! String
                    newBug.location = bug["Location"] as! String
                    newBug.currency = bug["Price"] as! String
                    newBug.discount = bug["Discount"] as! String
                    newBug.available = bug["Date"] as! String
                    self.objects.append(newBug)
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.tableView.reloadData()
                    })
                }
            }
            else {
                print(error)
            }
        }
    }
    
    func receiveBug(_ sender: Notification) {
        let info = (sender as NSNotification).userInfo!
        let bug = info["Friends"] as! Friends
        objects.append(bug)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: AnyObject) {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[(indexPath as NSIndexPath).row]
            (segue.destination as! DetailViewController).detailItem = object
                (segue.destination as! DetailViewController).nextAvialableDates = object
                (segue.destination as! DetailViewController).titles = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[(indexPath as NSIndexPath).row]
        
//        (cell.contentView.viewWithTag(10) as UILabel).text = object["firstName"] as? String
       (cell.contentView.viewWithTag(1) as! UILabel).text = object.title
        (cell.contentView.viewWithTag(2) as! UILabel).text = object.location
        (cell.contentView.viewWithTag(3) as! UILabel).text = object.currency
        (cell.contentView.viewWithTag(4) as! UILabel).text = object.discount
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
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
}

