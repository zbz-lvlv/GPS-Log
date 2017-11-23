//
//  DateTimeProvider.swift
//  GPS Log
//
//  Created by Zhang Bozheng on 15/11/17.
//  Copyright © 2017 Zhang Bozheng. All rights reserved.
//

import Foundation
import UIKit

class DateTimeProvider{
    
    var tabBarViewController: TabBarViewController!
    var dateTimeViewController: DataViewController!
    var timer: Timer!
    
    var index = 0
    
    init(tabBarViewControllerIn: TabBarViewController){
        
        tabBarViewController = tabBarViewControllerIn
        dateTimeViewController = DataViewController();
        
        tabBarViewController.addViewController(title: "Date Time", viewController: dateTimeViewController)
        
        //start populating the fields
        initView(viewName: "LocalDate")
        dateTimeViewController.setLabel(viewName: "LocalDate", side: Side.Description, value: "Local Date:")
        dateTimeViewController.setLabel(viewName: "LocalDate", side: Side.Value, value: getLocalDateString())
        
        initView(viewName: "LocalTime")
        dateTimeViewController.setLabel(viewName: "LocalTime", side: Side.Description, value: "Local Time:")
        dateTimeViewController.setLabel(viewName: "LocalTime", side: Side.Value, value: getLocalTimeString())
        
        initView(viewName: "UTCDate")
        dateTimeViewController.setLabel(viewName: "UTCDate", side: Side.Description, value: "UTC Date:")
        dateTimeViewController.setLabel(viewName: "UTCDate", side: Side.Value, value: getUTCDateString())
        
        initView(viewName: "UTCTime")
        dateTimeViewController.setLabel(viewName: "UTCTime", side: Side.Description, value: "UTC Time:")
        dateTimeViewController.setLabel(viewName: "UTCTime", side: Side.Value, value: getUTCTimeString())
        
        dateTimeViewController.addCanvas(imageName: "clock.png")
        dateTimeViewController.addPointer(pointerType: PointerType.Long, pointerTypeString: "long_pointer.png")
        dateTimeViewController.addPointer(pointerType: PointerType.Medium, pointerTypeString: "medium_pointer.png")
        dateTimeViewController.addPointer(pointerType: PointerType.Short, pointerTypeString: "short_pointer.png")
        
        //Update canvas
        let localTime = getLocalTime()
        dateTimeViewController.updatePointer(pointerType: PointerType.Long, angleInRadians: Double(localTime.second) / 60.0 * 2 * Double.pi)
        dateTimeViewController.updatePointer(pointerType: PointerType.Medium, angleInRadians: (Double(localTime.minute) / 60.0 + Double(localTime.second) / 3600.0) * 2 * Double.pi)
        dateTimeViewController.updatePointer(pointerType: PointerType.Short, angleInRadians: (Double(localTime.hour) / 12.0 + Double(localTime.minute) / 720.0) * 2 * Double.pi)
        
        //start update
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    }
    
    func initView(viewName: String){
        
        let dataView = DataView(index: index, name: viewName)
        dateTimeViewController.addView(view: dataView)
        
        index += 1;
        
    }
    
    @objc func update(){
        
        //Update values
        dateTimeViewController.setLabel(viewName: "LocalDate", side: Side.Value, value: getLocalDateString())
        dateTimeViewController.setLabel(viewName: "LocalTime", side: Side.Value, value: getLocalTimeString())
        dateTimeViewController.setLabel(viewName: "UTCDate", side: Side.Value, value: getUTCDateString())
        dateTimeViewController.setLabel(viewName: "UTCTime", side: Side.Value, value: getUTCTimeString())
        
        //Update canvas
        let localTime = getLocalTime()
        dateTimeViewController.updatePointer(pointerType: PointerType.Long, angleInRadians: Double(localTime.second) / 60.0 * 2 * Double.pi)
        dateTimeViewController.updatePointer(pointerType: PointerType.Medium, angleInRadians: (Double(localTime.minute) / 60.0 + Double(localTime.second) / 3600.0) * 2 * Double.pi)
        dateTimeViewController.updatePointer(pointerType: PointerType.Short, angleInRadians: (Double(localTime.hour) / 12.0 + Double(localTime.minute) / 720.0) * 2 * Double.pi)
        
    }
 
    func getLocalDateString() -> String{
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.dateFormat = "dd MMMM yyyy"
        
        return RFC3339DateFormatter.string(from: Date())
        
    }
    
    func getLocalTimeString() -> String{
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.dateFormat = "HH:mm:ss"
        
        return RFC3339DateFormatter.string(from: Date())
        
    }
    
    func getLocalTime() -> Time{
        
        let currentTime = Date()
        var myTime = Time()
        
        myTime.hour = Calendar.current.component(.hour, from: currentTime)
        
        //Clock is analog. cannot have 24-hour clock
        if(myTime.hour >= 12){
            myTime.hour -= 12;
        }
        
        myTime.minute = Calendar.current.component(.minute, from: currentTime)
        myTime.second = Calendar.current.component(.second, from: currentTime)
        
        return myTime
        
    }
    
    func getUTCDateString() -> String{
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        RFC3339DateFormatter.dateFormat = "dd MMMM yyyy"
        
        return RFC3339DateFormatter.string(from: Date())
        
    }
    
    func getUTCTimeString() -> String{
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        RFC3339DateFormatter.dateFormat = "HH:mm:ss"
        
        return RFC3339DateFormatter.string(from: Date())
        
    }
    
}

struct Time {
    var hour = 0;
    var minute = 0;
    var second = 0;
}
