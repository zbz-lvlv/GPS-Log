//
//  AltitudeProvider.swift
//  GPS Log
//
//  Created by Zhang Bozheng on 15/11/17.
//  Copyright © 2017 Zhang Bozheng. All rights reserved.
//

import Foundation
import CoreMotion

class AltitudeProvider{
    
    var tabBarViewController: TabBarViewController!
    var altitudeViewController: DataViewController!
    
    var altimeter = CMAltimeter()
    var airPressure = 0.0
    var pressureAltitude = 0.0
    static var seaLevelPressure = 1013.25
    static var temperature = 293.15
    
    var location: Location!
    
    var index = 0
    
    var weatherTimer: Timer!
    var firstUpdate = true
    
    init(tabBarViewControllerIn: TabBarViewController){
        
        tabBarViewController = tabBarViewControllerIn
        altitudeViewController = DataViewController();
        
        tabBarViewController.addViewController(title: "Altitude", viewController: altitudeViewController)
        
        initView(viewName: "GPSAlt")
        altitudeViewController.setLabel(viewName: "GPSAlt", side: Side.Description, value: "GPS Altitude:")
        
        initView(viewName: "GPSAltNoGeoid")
        altitudeViewController.setLabel(viewName: "GPSAltNoGeoid", side: Side.Description, value: "GPS Alt No Geoid:")
        
        initView(viewName: "BaroPres")
        altitudeViewController.setLabel(viewName: "BaroPres", side: Side.Description, value: "Air Pressure:")
        
        initView(viewName: "BaroAlt")
        altitudeViewController.setLabel(viewName: "BaroAlt", side: Side.Description, value: "Barometric Altitude:")
        
        altitudeViewController.addCanvas(imageName: "altimeter.png")
        altitudeViewController.addPointer(pointerType: PointerType.Long, pointerTypeString: "long_pointer.png") //10m per separation
        altitudeViewController.addPointer(pointerType: PointerType.Medium, pointerTypeString: "medium_pointer.png") //100m per separation
        altitudeViewController.addPointer(pointerType: PointerType.Short, pointerTypeString: "short_pointer.png") //1000m per separation
        
        initBarometer()
        
    }
    
    func locationCallback(location: Location){
        
        self.location = location
        
        update()
        
    }
    
    func update(){
        
        if(location != nil){
            
            if(firstUpdate){
                updateWeather()
                weatherTimer = Timer.scheduledTimer(timeInterval: 900, target: self, selector: #selector(updateWeather), userInfo: nil, repeats: true)
                firstUpdate = false
            }
        
            altitudeViewController.setLabel(viewName: "GPSAlt", side: Side.Value, value: altitudeToString(altitude: location.altitude))
            altitudeViewController.setLabel(viewName: "GPSAltNoGeoid", side: Side.Value, value: altitudeToString(altitude: location.altitudeNoGeoid))
            altitudeViewController.setLabel(viewName: "BaroPres", side: Side.Value, value: airPressureToString(airPressure: airPressure))
            altitudeViewController.setLabel(viewName: "BaroAlt", side: Side.Value, value: altitudeToString(altitude: pressureAltitude))
            
            //Update canvas
            altitudeViewController.updatePointer(pointerType: PointerType.Long, angleInRadians: location.altitude / 100 * 2 * Double.pi)
            altitudeViewController.updatePointer(pointerType: PointerType.Medium, angleInRadians: location.altitude / 1000 * 2 * Double.pi)
            altitudeViewController.updatePointer(pointerType: PointerType.Short, angleInRadians: location.altitude / 10000 * 2 * Double.pi)
            
        }
    }
    
    func initBarometer() {
        
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { data, error in
                if (error == nil) {
                    
                    self.airPressure = Double((data?.pressure)!) * 10.0;
                    self.pressureAltitude = ((pow(AltitudeProvider.seaLevelPressure / self.airPressure, 1/5.257) - 1) * AltitudeProvider.temperature) / 0.00649;
                    self.update()
                    
                }
            })
        }
        
    }
    
    @objc func updateWeather(){
        getWeatherData(urlString: "http://api.openweathermap.org/data/2.5/weather?lat=" + String(location.latitude) + "&lon=" + String(location.longitude) + "&appid=5068460cb48e429baee81e3575b0202f");
    }
    
    func getWeatherData(urlString: String){
        let url = NSURL(string: urlString)
        let task = URLSession.shared.dataTask(with: url! as URL){ (data, response, error) in
            DispatchQueue.main.async(execute: { () -> Void in
                if((data?.count)! > 0){
                    self.parseData(weatherData: data! as NSData)
                }
            })
        }
        
        task.resume()
    }
    
    func parseData(weatherData: NSData){
        
        do {
            if let json = try JSONSerialization.jsonObject(with: weatherData as Data, options: []) as? NSDictionary {
                if let main = json["main"] as? NSDictionary{
                    if let pressure = main["pressure"] as? Double{
                        AltitudeProvider.seaLevelPressure = pressure;
                    }
                    if let temperature = main["temp"] as? Double{
                        AltitudeProvider.temperature = temperature;
                    }
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    func altitudeToString(altitude: Double) -> String {
        return String(format: "%.1f", altitude) + "m"
    }
    
    func airPressureToString(airPressure: Double) -> String{
        return String(format: "%.2f", airPressure) + "mb"
    }
    
    func initView(viewName: String){
        
        let dataView = DataView(index: index, name: viewName)
        altitudeViewController.addView(view: dataView)
        
        index += 1;
        
    }
    
}
