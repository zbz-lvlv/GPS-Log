//
//  TabBarViewController.swift
//  GPS Log
//
//  Created by Zhang Bozheng on 15/11/17.
//  Copyright © 2017 Zhang Bozheng. All rights reserved.
//

import UIKit
import CoreLocation

//This is the main class
class TabBarViewController: UITabBarController, CLLocationManagerDelegate {
    
    var dateTimeProvider: DateTimeProvider!
    var locationProvider: LocationProvider!
    var altitudeProvider: AltitudeProvider!
    var sunProvider: SunProvider!
    
    var locationManager = CLLocationManager()
    
    var location = Location()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = Constants.BACKGROUND_COLOR
        
        dateTimeProvider = DateTimeProvider(tabBarViewControllerIn: self)
        locationProvider = LocationProvider(tabBarViewControllerIn: self)
        altitudeProvider = AltitudeProvider(tabBarViewControllerIn: self)
        sunProvider = SunProvider(tabBarViewControllerIn: self)
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.startUpdatingHeading()
    }
    
    func addViewController(title: String, viewController: UIViewController){
        
        let icon = UITabBarItem(title: title, image: UIImage(named: "first.png"), selectedImage: UIImage(named: "first.png"))
        viewController.tabBarItem = icon
        self.addChildViewController(viewController)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location.latitude = (locations.last?.coordinate.latitude)!
        location.longitude = (locations.last?.coordinate.longitude)!
        location.altitude = (locations.last?.altitude)! - Geoid.getOffset(lat: location.latitude, longi: location.longitude)
        location.altitudeNoGeoid = (locations.last?.altitude)!
        location.speed = (locations.last?.speed)! * 3.6 //in km/h
        
        CLGeocoder().reverseGeocodeLocation((locations.last)!, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                else{
                    let pm = placemarks! as [CLPlacemark]
                    
                    if pm.count > 0 {
                        let pm = placemarks![0]
                        if pm.locality != nil {
                            self.location.locality = pm.locality!
                        }
                    }
                }
        })
    
        locationProvider.locationCallback(location: location)
        altitudeProvider.locationCallback(location: location)
        sunProvider.locationCallback(location: location)
    
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        location.heading = newHeading.trueHeading;
    
        locationProvider.locationCallback(location: location)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

struct Location{
    
    var latitude = 0.0
    var longitude = 0.0
    var altitude = 0.0
    var altitudeNoGeoid = 0.0
    var heading = 0.0
    var speed = 0.0
    var locality = ""
    
}
