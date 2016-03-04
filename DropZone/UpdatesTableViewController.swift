//
//  UpdatesTableViewController.swift
//  DropZone
//
//  Created by Deion Long on 2/27/16.
//  Copyright © 2016 Deion Long. All rights reserved.
//

import UIKit
import Parse

class UpdatesTableViewController: UITableViewController, CLLocationManagerDelegate {
    @IBAction func refreshButton(sender: AnyObject) {
        self.loadData()
    }
    let locationManager = CLLocationManager()
    var newsFeedData:NSMutableArray = NSMutableArray()
    var newsFeedData2:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        let font = UIFont(name: "HelveticaNeue", size: 20);
        let titleDict: NSDictionary = [NSFontAttributeName: font!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        super.viewDidLoad()
    }

    func loadData() {
        newsFeedData.removeAllObjects()
        newsFeedData2.removeAllObjects()
        let now = NSDate()
        let startOfDay = NSCalendar.currentCalendar().startOfDayForDate(now)
        let tomorrow = startOfDay.dateByAddingTimeInterval(57600)
        let findPost:PFQuery = PFQuery(className: "Post")
        findPost.addAscendingOrder("sTime")
        findPost.whereKey("sTime", lessThan: tomorrow)
        findPost.findObjectsInBackgroundWithBlock { (objects, error: NSError?) -> Void in
            if (error == nil){
                if let objects = objects {
                    for object in objects{
                        self.newsFeedData.addObject(object)
                    }
                    self.tableView.reloadData()
                }
            }
        }
        let findPost2:PFQuery = PFQuery(className: "Post")
        findPost2.addAscendingOrder("sTime")
        findPost2.whereKey("sTime", greaterThanOrEqualTo: tomorrow)
        findPost2.findObjectsInBackgroundWithBlock { (objects, error: NSError?) -> Void in
            if (error == nil){
                if let objects = objects {
                    for object in objects{
                        self.newsFeedData2.addObject(object)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return newsFeedData.count
        }
        if section == 1 {
            return newsFeedData2.count
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Today"
        }
        if(section == 1){
            return "Later On"
        }
        return "hi"
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UpdatesTableViewCell
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateFormatter.dateFormat = "MM/dd/yy hh:mma"
       
        
        cell.nameLabel.alpha = 0
        cell.timeLabel.alpha = 0
        cell.distanceLabel.alpha = 0
    
        if(indexPath.section == 0){
        let post = self.newsFeedData.objectAtIndex(indexPath.row) as! PFObject
        let latitude = locationManager.location!.coordinate.latitude
        let longitude = locationManager.location!.coordinate.longitude
        let location: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        let latitude2: CLLocationDegrees = post["latitude"] as! CLLocationDegrees
        let longtitude2: CLLocationDegrees = post["longitude"] as! CLLocationDegrees
        let location2: CLLocation = CLLocation(latitude: latitude2, longitude: longtitude2)
        let distanceInMeters = location.distanceFromLocation(location2)
        let distanceInMiles = (distanceInMeters*0.000621371)
        if(distanceInMiles < 1){
            let distanceInFeet = String(format:"%.0f feet", distanceInMeters*3.28084)
            cell.distanceLabel.text = distanceInFeet
        }
        else{
            let b = String(format:"%.0f miles", distanceInMiles)
            cell.distanceLabel.text = b
        }
        let discipline = post["discipline"] as! String
        if(discipline.lowercaseString == "food"){
            cell.iconImage.image = UIImage(named: "Vegetarian Food-20.png")
        }
        else if(discipline.lowercaseString == "clothing"){
            cell.iconImage.image = UIImage(named:"Clothes-20.png")
        }
        else if(discipline.lowercaseString == "shelter"){
            cell.iconImage.image = UIImage(named: "Home-20.png")
        }
        else{
            cell.iconImage.image = UIImage(named: "Handshake-20.png")
        }
        cell.timeLabel.text = dateFormatter.stringFromDate(post.objectForKey("sTime")! as! NSDate)
        let orgName = post.objectForKey("orgName") as? String
        cell.nameLabel.text = orgName?.capitalizedString
        } else {
            let post = self.newsFeedData2.objectAtIndex(indexPath.row) as! PFObject
            let latitude = locationManager.location!.coordinate.latitude
            let longitude = locationManager.location!.coordinate.longitude
            let location: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
            let latitude2: CLLocationDegrees = post["latitude"] as! CLLocationDegrees
            let longtitude2: CLLocationDegrees = post["longitude"] as! CLLocationDegrees
            let location2: CLLocation = CLLocation(latitude: latitude2, longitude: longtitude2)
            let distanceInMeters = location.distanceFromLocation(location2)
            let distanceInMiles = (distanceInMeters*0.000621371)
            if(distanceInMiles < 1){
                let distanceInFeet = String(format:"%.0f feet", distanceInMeters*3.28084)
                cell.distanceLabel.text = distanceInFeet
            }
            else{
                let b = String(format:"%.0f miles", distanceInMiles)
                cell.distanceLabel.text = b
            }
            let discipline = post["discipline"] as! String
            if(discipline.lowercaseString == "food"){
                cell.iconImage.image = UIImage(named: "Vegetarian Food-20.png")
            }
            else if(discipline.lowercaseString == "clothing"){
                cell.iconImage.image = UIImage(named:"Clothes-20.png")
            }
            else if(discipline.lowercaseString == "shelter"){
                cell.iconImage.image = UIImage(named: "Home-20.png")
            }
            else{
                cell.iconImage.image = UIImage(named: "Handshake-20.png")
            }
            cell.timeLabel.text = dateFormatter.stringFromDate(post.objectForKey("sTime")! as! NSDate)
            let orgName = post.objectForKey("orgName") as? String
            cell.nameLabel.text = orgName?.capitalizedString
        }
        
        
        UIView.animateWithDuration(0.5, animations: {
                cell.timeLabel.alpha = 1
                cell.nameLabel.alpha = 1
                cell.distanceLabel.alpha = 1
        })
        
        return cell
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" {
            if let selectedIndex = self.tableView.indexPathForCell(sender as! UpdatesTableViewCell) {
                if(selectedIndex.section == 0){
                let object = self.newsFeedData.objectAtIndex(selectedIndex.row)
                (segue.destinationViewController as! UpdatesDetailViewController).detailItem = object as! PFObject
                } else {
                    let object = self.newsFeedData2.objectAtIndex(selectedIndex.row)
                    (segue.destinationViewController as! UpdatesDetailViewController).detailItem = object as! PFObject
                }

            }
            
        }
    }

}
