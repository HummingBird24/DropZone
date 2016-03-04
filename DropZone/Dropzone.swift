//
//  Dropzone.swift
//  DropZone
//
//  Created by Deion Long on 2/27/16.
//  Copyright © 2016 Deion Long. All rights reserved.
//

import Foundation
import Contacts
import AddressBook
import MapKit

class Dropzone: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    // annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [String(kABPersonAddressStreetKey): self.subtitle as! AnyObject]
        let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.title
        
        return mapItem
    }
    
    
    
    // pinColor for disciplines: Food, Shelter, Clothing, and Other
    func pinColor() -> MKPinAnnotationColor  {
        switch discipline {
        case "Food", "Shelter":
            return .Red
        case "Clothing":
            return .Purple
        default:
            return .Green
        }
    }
    
}