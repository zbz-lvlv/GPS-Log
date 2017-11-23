//
//  LocationProvider.swift
//  GPS Log
//
//  Created by Zhang Bozheng on 15/11/17.
//  Copyright © 2017 Zhang Bozheng. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationProvider{
    
    var tabBarViewController: TabBarViewController!
    var locationViewController: DataViewController!
    
    var index = 0
    
    var location: Location!
    
    //var locationManager = CLLocationManager()
    
    init(tabBarViewControllerIn: TabBarViewController){
        
        tabBarViewController = tabBarViewControllerIn
        locationViewController = DataViewController();
        
        tabBarViewController.addViewController(title: "Location", viewController: locationViewController)
        
        initView(viewName: "Latitude")
        locationViewController.setLabel(viewName: "Latitude", side: Side.Description, value: "Latitude:")
        
        initView(viewName: "Longitude")
        locationViewController.setLabel(viewName: "Longitude", side: Side.Description, value: "Longitude:")
        
        initView(viewName: "Heading")
        locationViewController.setLabel(viewName: "Heading", side: Side.Description, value: "Heading:")
        
        initView(viewName: "Speed")
        locationViewController.setLabel(viewName: "Speed", side: Side.Description, value: "Speed:")
        
        initView(viewName: "Locality")
        locationViewController.setLabel(viewName: "Locality", side: Side.Description, value: "Locality:")
        
        locationViewController.addCanvas(imageName: "clock.png")
        locationViewController.addPointer(pointerType: PointerType.Medium, pointerTypeString: "medium_pointer.png")
        
    }
    
    func locationCallback(location: Location){
        
        self.location = location
        
        update()
        
    }
    
    func update(){
        
        if(location != nil){
            
            locationViewController.setLabel(viewName: "Latitude", side: Side.Value, value: latitudeToString(latitude: location.latitude))
            locationViewController.setLabel(viewName: "Longitude", side: Side.Value, value: longitudeToString(longitude: location.longitude))
            locationViewController.setLabel(viewName: "Heading", side: Side.Value, value: headingToString(heading: location.heading))
            locationViewController.setLabel(viewName: "Speed", side: Side.Value, value: speedToString(speed: location.speed))
            locationViewController.setLabel(viewName: "Locality", side: Side.Value, value: location.locality)
            
            locationViewController.updatePointer(pointerType: PointerType.Medium, angleInRadians: (360.0 - location.heading) * Double.pi / 180.0)
            
        }
    }
    
    func latitudeToString(latitude: Double) -> String{
        if(latitude >= 0)
        {
            return String(format: "%.5f", latitude) + "N"
        }
        return String(format: "%.5f", -latitude) + "S"
    }
    
    func longitudeToString(longitude: Double) -> String{
        if(longitude >= 0){
            return String(format: "%.5f", longitude) + "E"
        }
        return String(format: "%.5f", -longitude) + "W"
    }
    
    func headingToString(heading: Double) -> String{
        return String(format: "%.1f", heading) + "°"
    }
    
    func speedToString(speed: Double) -> String{
        return String(format: "%.1f", speed) + "km/h"
    }
    
    func initView(viewName: String){
        
        let dataView = DataView(index: index, name: viewName)
        locationViewController.addView(view: dataView)
        
        index += 1;
        
    }
    
}
