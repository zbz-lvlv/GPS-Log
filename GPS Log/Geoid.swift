//
//  Geoid.swift
//  Latitude and Longitude
//
//  Created by ZBZ on 14/10/14.
//  Copyright (c) 2014 ___ZHANG_BOZHENG___. All rights reserved.
//

import Foundation

class Geoid{
    
    class func getOffset(lat: Double, longi: Double) -> Double{
    
        //Northern 60-90
        if(longi > -180 && longi < -150 && lat < 90 && lat > 60){
        return 0;
        }
        if(longi > -150 && longi < -120 && lat < 90 && lat > 60){
        return 0;
        }
        if(longi > -120 && longi < -90 && lat < 90 && lat > 60){
        return -10;
        }
        if(longi > -90 && longi < -60 && lat < 90 && lat > 60){
        return -5;
        }
        if(longi > -60 && longi < -30 && lat < 90 && lat > 60){
        return 35;
        }
        if(longi > -30 && longi < 0 && lat < 90 && lat > 60){
        return 40;
        }
        if(longi > 0 && longi < 30 && lat < 90 && lat > 60){
        return 30;
        }
        if(longi > 30 && longi < 60 && lat < 90 && lat > 60){
        return 5;
        }
        if(longi > 60 && longi < 90 && lat < 90 && lat > 60){
        return -5;
        }
        if(longi > 90 && longi < 120 && lat < 90 && lat > 60){
        return -5;
        }
        if(longi > 120 && longi < 150 && lat < 90 && lat > 60){
        return 0;
        }
        if(longi > 150 && longi < 180 && lat < 90 && lat > 60){
        return 5;
        }
        
        //Northern 40-60
        if(longi > -180 && longi < -160 && lat < 60 && lat > 40){
        return -5;
        }
        if(longi > -160 && longi < -140 && lat < 60 && lat > 40){
        return -10;
        }
        if(longi > -140 && longi < -120 && lat < 60 && lat > 40){
        return -15;
        }
        if(longi > -120 && longi < -100 && lat < 60 && lat > 40){
        return -25;
        }
        if(longi > -100 && longi < -80 && lat < 60 && lat > 40){
        return -35;
        }
        if(longi > -80 && longi < -60 && lat < 60 && lat > 40){
        return -30;
        }
        if(longi > -60 && longi < -40 && lat < 60 && lat > 40){
        return 15;
        }
        if(longi > -40 && longi < -20 && lat < 60 && lat > 40){
        return 50;
        }
        if(longi > -20 && longi < 0 && lat < 60 && lat > 40){
        return 40;
        }
        if(longi > 0 && longi < 20 && lat < 60 && lat > 40){
        return 50;
        }
        if(longi > 20 && longi < 40 && lat < 60 && lat > 40){
        return 25;
        }
        if(longi > 40 && longi < 60 && lat < 60 && lat > 40){
        return -5;
        }
        if(longi > 60 && longi < 80 && lat < 60 && lat > 40){
        return -30;
        }
        if(longi > 80 && longi < 100 && lat < 60 && lat > 40){
        return -30;
        }
        if(longi > 100 && longi < 120 && lat < 60 && lat > 40){
        return -25;
        }
        if(longi > 120 && longi < 140 && lat < 60 && lat > 40){
        return 10;
        }
        if(longi > 140 && longi < 160 && lat < 60 && lat > 40){
        return 20;
        }
        if(longi > 160 && longi < 180 && lat < 60 && lat > 40){
        return 0;
        }
        
        //Northern 20-40
        if(longi > -180 && longi < -160 && lat < 40 && lat > 20){
        return 0;
        }
        if(longi > -160 && longi < -140 && lat < 40 && lat > 20){
        return -10;
        }
        if(longi > -140 && longi < -120 && lat < 40 && lat > 20){
        return -35;
        }
        if(longi > -120 && longi < -100 && lat < 40 && lat > 20){
        return -25;
        }
        if(longi > -100 && longi < -80 && lat < 40 && lat > 20){
        return -20;
        }
        if(longi > -80 && longi < -60 && lat < 40 && lat > 20){
        return -40;
        }
        if(longi > -60 && longi < -40 && lat < 40 && lat > 20){
        return -5;
        }
        if(longi > -40 && longi < -20 && lat < 40 && lat > 20){
        return 30;
        }
        if(longi > -20 && longi < 0 && lat < 40 && lat > 20){
        return 50;
        }
        if(longi > 0 && longi < 20 && lat < 40 && lat > 20){
        return 30;
        }
        if(longi > 20 && longi < 40 && lat < 40 && lat > 20){
        return 15;
        }
        if(longi > 40 && longi < 60 && lat < 40 && lat > 20){
        return -20;
        }
        if(longi > 60 && longi < 80 && lat < 40 && lat > 20){
        return -35;
        }
        if(longi > 80 && longi < 100 && lat < 40 && lat > 20){
        return -45;
        }
        if(longi > 100 && longi < 120 && lat < 40 && lat > 20){
        return -15;
        }
        if(longi > 120 && longi < 140 && lat < 40 && lat > 20){
        return 9; // For shanghai-suzhou trip 2017
        }
        if(longi > 140 && longi < 160 && lat < 40 && lat > 20){
        return 25;
        }
        if(longi > 160 && longi < 180 && lat < 40 && lat > 20){
        return 5;
        }
        
        //Northern 0-20
        if(longi > -180 && longi < -160 && lat < 20 && lat > 0){
        return 15;
        }
        if(longi > -160 && longi < -140 && lat < 20 && lat > 0){
        return 5;
        }
        if(longi > -140 && longi < -120 && lat < 20 && lat > 0){
        return -30;
        }
        if(longi > -120 && longi < -100 && lat < 20 && lat > 0){
        return -25;
        }
        if(longi > -100 && longi < -80 && lat < 20 && lat > 0){
        return -5;
        }
        if(longi > -80 && longi < -60 && lat < 20 && lat > 0){
        return 0;
        }
        if(longi > -60 && longi < -40 && lat < 20 && lat > 0){
        return -30;
        }
        if(longi > -40 && longi < -20 && lat < 20 && lat > 0){
        return 5;
        }
        if(longi > -20 && longi < 0 && lat < 20 && lat > 0){
        return 20;
        }
        if(longi > 0 && longi < 20 && lat < 20 && lat > 0){
        return 10;
        }
        if(longi > 20 && longi < 40 && lat < 20 && lat > 0){
        return -5;
        }
        if(longi > 40 && longi < 60 && lat < 20 && lat > 0){
        return -40;
        }
        if(longi > 60 && longi < 80 && lat < 20 && lat > 0){
        return -75;
        }
        if(longi > 80 && longi < 100 && lat < 20 && lat > 0){
        return -35;
        }
        if(longi > 100 && longi < 120 && lat < 20 && lat > 0){
        return 8; //Singapore
        }
        if(longi > 120 && longi < 140 && lat < 20 && lat > 0){
        return 40;
        }
        if(longi > 140 && longi < 160 && lat < 20 && lat > 0){
        return 35;
        }
        if(longi > 160 && longi < 180 && lat < 20 && lat > 0){
        return 20;
        }
        
        //Southern 0-20
        if(longi > -180 && longi < -160 && lat < 0 && lat > -20){
        return 35;
        }
        if(longi > -160 && longi < -140 && lat < 0 && lat > -20){
        return 5;
        }
        if(longi > -140 && longi < -120 && lat < 0 && lat > -20){
        return -5;
        }
        if(longi > -120 && longi < -100 && lat < 0 && lat > -20){
        return -5;
        }
        if(longi > -100 && longi < -80 && lat < 0 && lat > -20){
        return 0;
        }
        if(longi > -80 && longi < -60 && lat < 0 && lat > -20){
        return 10;
        }
        if(longi > -60 && longi < -40 && lat < 0 && lat > -20){
        return 0;
        }
        if(longi > -40 && longi < -20 && lat < 0 && lat > -20){
        return 5;
        }
        if(longi > -20 && longi < 0 && lat < 0 && lat > -20){
        return 10;
        }
        if(longi > 0 && longi < 20 && lat < 0 && lat > -20){
        return 5;
        }
        if(longi > 20 && longi < 40 && lat < 0 && lat > -20){
        return -10;
        }
        if(longi > 40 && longi < 60 && lat < 0 && lat > -20){
        return -15;
        }
        if(longi > 60 && longi < 80 && lat < 0 && lat > -20){
        return -60;
        }
        if(longi > 80 && longi < 100 && lat < 0 && lat > -20){
        return -10;
        }
        if(longi > 100 && longi < 120 && lat < 0 && lat > -20){
        return 10;
        }
        if(longi > 120 && longi < 140 && lat < 0 && lat > -20){
        return 45;
        }
        if(longi > 140 && longi < 160 && lat < 0 && lat > -20){
        return 45;
        }
        if(longi > 160 && longi < 180 && lat < 0 && lat > -20){
        return 40;
        }
        
        //Southern 20-40
        if(longi > -180 && longi < -160 && lat < -20 && lat > -40){
        return 15;
        }
        if(longi > -160 && longi < -140 && lat < -20 && lat > -40){
        return 0;
        }
        if(longi > -140 && longi < -120 && lat < -20 && lat > -40){
        return -5;
        }
        if(longi > -120 && longi < -100 && lat < -20 && lat > -40){
        return -5;
        }
        if(longi > -100 && longi < -80 && lat < -20 && lat > -40){
        return 5;
        }
        if(longi > -80 && longi < -60 && lat < -20 && lat > -40){
        return 15;
        }
        if(longi > -60 && longi < -40 && lat < -20 && lat > -40){
        return 10;
        }
        if(longi > -40 && longi < -20 && lat < -20 && lat > -40){
        return 5;
        }
        if(longi > -20 && longi < 0 && lat < -20 && lat > -40){
        return 15;
        }
        if(longi > 0 && longi < 20 && lat < -20 && lat > -40){
        return 20;
        }
        if(longi > 20 && longi < 40 && lat < -20 && lat > -40){
        return 25;
        }
        if(longi > 40 && longi < 60 && lat < -20 && lat > -40){
        return 15;
        }
        if(longi > 60 && longi < 80 && lat < -20 && lat > -40){
        return 10;
        }
        if(longi > 80 && longi < 100 && lat < -20 && lat > -40){
        return -20;
        }
        if(longi > 100 && longi < 120 && lat < -20 && lat > -40){
        return -20;
        }
        if(longi > 120 && longi < 140 && lat < -20 && lat > -40){
        return 0;
        }
        if(longi > 140 && longi < 160 && lat < -20 && lat > -40){
        return 15;
        }
        if(longi > 160 && longi < 180 && lat < -20 && lat > -40){
        return 25;
        }
        
        //Southern 40-60
        if(longi > -180 && longi < -160 && lat < -40 && lat > -60){
        return -20;
        }
        if(longi > -160 && longi < -140 && lat < -40 && lat > -60){
        return -15;
        }
        if(longi > -140 && longi < -120 && lat < -40 && lat > -60){
        return -10;
        }
        if(longi > -120 && longi < -100 && lat < -40 && lat > -60){
        return -5;
        }
        if(longi > -100 && longi < -80 && lat < -40 && lat > -60){
        return 5;
        }
        if(longi > -80 && longi < -60 && lat < -40 && lat > -60){
        return 10;
        }
        if(longi > -60 && longi < -40 && lat < -40 && lat > -60){
        return 10;
        }
        if(longi > -40 && longi < -20 && lat < -40 && lat > -60){
        return 15;
        }
        if(longi > -20 && longi < 0 && lat < -40 && lat > -60){
        return 20;
        }
        if(longi > 0 && longi < 20 && lat < -40 && lat > -60){
        return 25;
        }
        if(longi > 20 && longi < 40 && lat < -40 && lat > -60){
        return 35;
        }
        if(longi > 40 && longi < 60 && lat < -40 && lat > -60){
        return 35;
        }
        if(longi > 60 && longi < 80 && lat < -40 && lat > -60){
        return 30;
        }
        if(longi > 80 && longi < 100 && lat < -40 && lat > -60){
        return 5;
        }
        if(longi > 100 && longi < 120 && lat < -40 && lat > -60){
        return -10;
        }
        if(longi > 120 && longi < 140 && lat < -40 && lat > -60){
        return -20;
        }
        if(longi > 140 && longi < 160 && lat < -40 && lat > -60){
        return -10;
        }
        if(longi > 160 && longi < 180 && lat < -40 && lat > -60){
        return 5;
        }
        
        return 0;
    
    }
    
}

