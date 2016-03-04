//
//  VCMapView.swift
//  DropZone
//
//  Created by Deion Long on 2/27/16.
//  Copyright © 2016 Deion Long. All rights reserved.
//

import Foundation

import MapKit

extension MapViewController: MKMapViewDelegate {
    
    // 1
    func mapView(mapView: MKMapView,
        viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView! {
            if let annotation = annotation as? Dropzone {
                let identifier = "pin"
                var view: MKPinAnnotationView
                if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                    as? MKPinAnnotationView { // 2
                        dequeuedView.annotation = annotation
                        view = dequeuedView
                } else {
                    // 3
                    view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    view.canShowCallout = true
                    view.animatesDrop = true
                    view.calloutOffset = CGPoint(x: -5, y: 5)
                    view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
                }
                
                view.pinColor = annotation.pinColor()
                
                return view
            }
            return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Dropzone
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
    
}