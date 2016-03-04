//
//  MapViewController.swift
//  DropZone
//
//  Created by Deion Long on 2/27/16.
//  Copyright © 2016 Deion Long. All rights reserved.
//

import UIKit
import MapKit
import Parse


class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    @IBAction func centerToUserLocation(sender: AnyObject) {
        let latitude = self.locationManager.location!.coordinate.latitude
        let longitude = self.locationManager.location!.coordinate.longitude
        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.mapView.setRegion(region, animated: false)
    }
    @IBOutlet weak var mapView: MKMapView!
    
    //let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont(name: "HelveticaNeue", size: 20);
        let titleDict: NSDictionary = [NSFontAttributeName: font!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        loadData()
        mapView.delegate = self
    }
    func loadData() {
        let findPost:PFQuery = PFQuery(className: "Post")
        findPost.findObjectsInBackgroundWithBlock { (objects, error: NSError?) -> Void in
            if (error == nil){
                if let objects = objects {
                    for object in objects{
                        let setTitle = object.objectForKey("orgName") as! String
                        let setLocationName = object.objectForKey("orgLocation") as! String
                        let setDiscipline = object["discipline"] as! String
                        let latitude: CLLocationDegrees = object["latitude"] as! CLLocationDegrees
                        let longitude: CLLocationDegrees = object["longitude"] as! CLLocationDegrees
                        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        let dropzone = Dropzone(title: setTitle, locationName: setLocationName, discipline: setDiscipline, coordinate: location)
                        self.mapView.addAnnotation(dropzone)
                    }
                    
                }
            }
            
            
        }
    }
    
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
}
