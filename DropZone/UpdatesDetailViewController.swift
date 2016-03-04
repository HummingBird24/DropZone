//
//  UpdatesDetailViewController.swift
//  DropZone
//
//  Created by Deion Long on 2/27/16.
//  Copyright © 2016 Deion Long. All rights reserved.
//

import UIKit
import Parse

class UpdatesDetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UITextView!
    @IBOutlet weak var detailAdressLabel: UILabel!
    @IBOutlet weak var detailTimeLabel: UILabel!
    var detailItem: PFObject! {
        didSet{
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail: PFObject! = self.detailItem! {
            if let ddl = self.detailDescriptionLabel{
                ddl.text = detail["description"] as? String
            }
            if let dal = self.detailAdressLabel{
                let orgLoc = detail.objectForKey("orgLocation") as? String
                dal.text = orgLoc?.capitalizedString
            }
            if let dtl = self.detailTimeLabel{
                let dateFormatter:NSDateFormatter = NSDateFormatter()
                dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
                dateFormatter.dateFormat = "MM/dd/yy h:mm a"
                
                dtl.text = dateFormatter.stringFromDate(detail.objectForKey("sTime") as! NSDate) as? String
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
