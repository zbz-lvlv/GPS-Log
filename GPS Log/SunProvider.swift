//
//  SunProvider.swift
//  GPS Log
//
//  Created by Zhang Bozheng on 15/11/17.
//  Copyright © 2017 Zhang Bozheng. All rights reserved.
//

import Foundation

class SunProvider{
    
    var tabBarViewController: TabBarViewController!
    var sunViewController: DataViewController!
    
    var index = 0
    
    var location: Location!
    
    init(tabBarViewControllerIn: TabBarViewController){
    
        tabBarViewController = tabBarViewControllerIn
        sunViewController = DataViewController()
        
        tabBarViewController.addViewController(title: "Sun", viewController: sunViewController)
        
        initView(viewName: "Sunrise")
        sunViewController.setLabel(viewName: "Sunrise", side: Side.Description, value: "Sunrise::")
        
        initView(viewName: "SolarNoon")
        sunViewController.setLabel(viewName: "SolarNoon", side: Side.Description, value: "Solar Noon:")
        
        initView(viewName: "Sunset")
        sunViewController.setLabel(viewName: "Sunset", side: Side.Description, value: "Sunset:")
        
        initView(viewName: "DayLength")
        sunViewController.setLabel(viewName: "DayLength", side: Side.Description, value: "Day Length:")
        
        initView(viewName: "Elevation")
        sunViewController.setLabel(viewName: "Elevation", side: Side.Description, value: "Sun Elevation:")
        
        initView(viewName: "Azimuth")
        sunViewController.setLabel(viewName: "Azimuth", side: Side.Description, value: "Sun Azimuth:")
        
        initView(viewName: "Season")
        sunViewController.setLabel(viewName: "Season", side: Side.Description, value: "Season:")
        
        sunViewController.addCanvas(imageName: "clock.png")
        sunViewController.addPointer(pointerType: PointerType.Long, pointerTypeString: "long_pointer.png")
        
    }
    
    func locationCallback(location: Location){
        
        self.location = location
        
        update()
        
    }
    
    func update(){
        
        if(location != nil){
            
            let sunValues = calculateSun(lat: location.latitude, long: location.longitude, timezone: Double(TimeZone.current.secondsFromGMT()) / 3600.0)
            
            sunViewController.setLabel(viewName: "Sunrise", side: Side.Value, value: timeToString(time: convertTimeToProperForm(timeIn: sunValues[0])))
            sunViewController.setLabel(viewName: "SolarNoon", side: Side.Value, value: timeToString(time: convertTimeToProperForm(timeIn: sunValues[1])))
            sunViewController.setLabel(viewName: "Sunset", side: Side.Value, value: timeToString(time: convertTimeToProperForm(timeIn: sunValues[2])))
            sunViewController.setLabel(viewName: "DayLength", side: Side.Value, value: dayLengthToString(time: convertTimeToProperForm(timeIn: sunValues[3] / 1440)))
            sunViewController.setLabel(viewName: "Elevation", side: Side.Value, value: angleToString(angle: sunValues[4]))
            sunViewController.setLabel(viewName: "Azimuth", side: Side.Value, value: angleToString(angle: sunValues[5]))
            sunViewController.setLabel(viewName: "Season", side: Side.Value, value: getSeason())
            
            //Update canvas
            sunViewController.updatePointer(pointerType: PointerType.Long, angleInRadians: (-sunValues[4] + 90) * Double.pi / 180)
            
        }
        
    }
    
    func timeToString(time: Time) -> String{
        
        return String(format: "%02d", time.hour) + ":" + String(format: "%02d", time.minute) + ":" + String(format: "%02d", time.second)
        
    }
    
    func dayLengthToString(time: Time) -> String{
        
        return String(format: "%02d", time.hour) + "hr " + String(format: "%02d", time.minute) + "min " + String(format: "%02d", time.second) + "s"
        
    }
    
    func angleToString(angle: Double) -> String{
        
        return String(format: "%.1f", angle) + "°"
        
    }
    
    func getSeason() -> String{
        
        let month = Calendar.current.component(.month, from: Date())
        
        if(month == 3 || month == 4 || month == 5){
            return "Spring"
        }
        else if(month == 6 || month == 7 || month == 8){
            return "Summer"
        }
        else if(month == 9 || month == 10 || month == 11){
            return "Autumn"
        }
        return "Winter"
        
    }
    
    func calculateSun(lat: Double, long: Double, timezone: Double) -> [Double]{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let first = "1899-12-31"
        let firstDate = dateFormatter.date(from: first)!
        let lastDate = Date()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: lastDate)
        
        let hour = Int(components.hour!)
        let minute = Int(components.minute!)
        let second = Int(components.second!)
        
        let D = Double(lastDate.interval(ofComponent: .day, fromDate: firstDate))
        let E: Double = Double(3600 * hour + 60 * minute + second) / 86400.0
        let F = D + 2415018.5 + E - timezone / 24
        let G = (F - 2451545) / 36525 //Julian century
        let I = (280.46646 + G * (36000.76983 + G * 0.0003032)).truncatingRemainder(dividingBy: 360) //Geom Mean Long Sun (deg)
        let J = 357.52911 + G * (35999.05029 - 0.0001537 * G) //Geom mean anom sun (deg)
        let K = 0.016708634 - G * (0.000042037 + 0.0000001267 * G) //Eccent earth orbit
        let L = sin(J * 0.0174533) * (1.914602 - G * (0.004817 + 0.000014 * G)) + sin(2 * J * 0.0174533) * (0.019993 - 0.000101 * G) + sin(3 * J * 0.0174533) * 0.000289 //Sun equation of center
        let M = I + L //Sun true long (deg)
        let N = J + L //Sun true anom (deg)
        let O = (1.000001018 * (1 - K * K)) / (1 + K * cos(N * 0.0174533)) //Sun rad vector (AUs)
        let P = M - 0.00569 - 0.00478 * sin((125.04 - 1934.136 * G) * 0.0174533) //Sun app long (deg)
        let Q = 23 + (26 + ((21.448 - G * (46.815 + G * (0.00059 - G * 0.001813)))) / 60) / 60 //Mean obliq ecliptic (deg)
        let R = Q + 0.00256 * cos((125.04 - 1934.136 * G) * 0.0174533) //Obliq corr (deg)
        let S = (atan2(cos(P * 0.0174533), cos(Q * 0.0174533) * sin(P * 0.0174533))) * 57.2958 //Sun rate of ascent(deg)
        let T = (asin(sin(R * 0.0174533) * sin(P * 0.0174533))) * 57.2958 //Sun declination (deg)
        let U = tan(R / 2 * 0.0174533) * tan(R / 2 * 0.0174533) //var y
        let V = 4 * (U * sin(2 * I * 0.0174533) - 2 * K * sin(J * 0.0174533) + 4 * K * U * sin(J * 0.0174533) * cos(2 * I * 0.0174533) - 0.5 * U * U * sin(4 * I * 0.0174533) - 1.25 * K * K * sin(2 * J * 0.0174533)) * 57.2958 //Equation of time (minutes)
        let W = (acos(cos(90.833 * 0.0174533) / (cos(lat * 0.0174533) * cos(T * 0.0174533)) - tan(lat * 0.0174533) * tan(T * 0.0173433))) * 57.2958 //HA Sunrise (deg)
        let X = (720 - 4 * long - V + timezone * 60) / 1440 //Solar noon
        let Y = X - W * 4 / 1440 //Sunrise
        let Z = X + W * 4 / 1440 //Sunset
        let AA = 8 * W //Day length (minutes)
        let AB = (E * 1440 + V + 4 * long - 60 * timezone).truncatingRemainder(dividingBy: 1440) //True solar time
        var AC = 0.0 //Hour angle(deg)
        if(AB / 4 < 0){
            AC = AB / 4 + 180
        }
        else{
            AC = AB / 4 - 180
        }
        let AD = (acos(sin(lat * 0.0174533) * sin(T * 0.0174533) + cos(lat * 0.0174533) * cos(T * 0.0174533) * cos(AC * 0.0174533))) * 57.2958 //Solar zenith angle(deg)
        let AE = 90 - AD //Solar elevation angle(deg)
        var AH = 0.0 //Solar azimuth angle (clockwise from North)
        if(AC > 0){
            AH = ((acos(((sin(lat * 0.0174533) * cos(AD * 0.0174533)) - sin(T * 0.0174533)) / (cos(lat * 0.0174533) * sin(AD * 0.0174533)))) * 57.2958 + 180).truncatingRemainder(dividingBy: 360)
        }
        else{
            AH = (540 - (acos(((sin(lat * 0.0174533) * cos(AD * 0.0174533)) - sin(T * 0.0174533)) / (cos(lat * 0.0174533) * sin(AD * 0.0174533)))) * 57.2958).truncatingRemainder(dividingBy: 360)
        }
        
        return[Y, X, Z, AA, AE, AH]
        
    }
    
    func convertTimeToProperForm(timeIn: Double) -> Time{
        
        let time = timeIn * 86400 //convert to seconds
        let hour = Int(time / 3600)
        let minute = Int((time - Double(hour) * 3600) / 60)
        let second = Int(time - Double(hour) * 3600 - Double(minute) * 60)
        
        var timeRtn = Time()
        timeRtn.hour = hour
        timeRtn.minute = minute
        timeRtn.second = second
        
        return timeRtn
        
    }
    
    func initView(viewName: String){
        
        let dataView = DataView(index: index, name: viewName)
        sunViewController.addView(view: dataView)
        
        index += 1;
        
    }
    
}

extension Date {
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
}

