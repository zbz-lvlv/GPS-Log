//
//  FirstViewController.swift
//  GPS Log
//
//  Created by Zhang Bozheng on 15/11/17.
//  Copyright © 2017 Zhang Bozheng. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    let views = [UIView]();
    var foregroundColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0, green: 16/255, blue: 53/255, alpha: 1)
        foregroundColor = UIColor(red: 188/255, green: 211/255, blue: 244/255, alpha: 1)
        
    }
    
    func addView(view: UIView, locationX: Int, locationY: Int){
        
    }
    
    func setLabel(viewName: String, side: Side){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

