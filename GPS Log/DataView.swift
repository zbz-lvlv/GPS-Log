//
//  DataView.swift
//  GPS Log
//
//  Created by Zhang Bozheng on 15/11/17.
//  Copyright © 2017 Zhang Bozheng. All rights reserved.
//

import UIKit

enum Side {
    case Description
    case Value
}

class DataView : UIView{

    static let VIEW_HEIGHT = 18;
    static let HOTIZONTAL_MARGIN = 8;
    
    var labelDescription: UILabel!
    var labelValue: UILabel!
    
    var name = ""
    
    init(index: Int, name: String) {
        
        self.name = name;
        
        let frameView = CGRect(x: Double(0), y: Double(20 + index * DataView.VIEW_HEIGHT), width: Double(Constants
            .SCREEN_WIDTH), height: Double(DataView.VIEW_HEIGHT))
        
        super.init(frame: frameView)
        
        labelDescription = UILabel();
        labelDescription.font = UIFont(name: "Verdana", size: 17)
        labelDescription.textColor = Constants.FOREGROUND_COLOR
        labelDescription.text = "Description"
        labelDescription.frame = CGRect(x: CGFloat(DataView.HOTIZONTAL_MARGIN), y: CGFloat(DataView.HOTIZONTAL_MARGIN + DataView.VIEW_HEIGHT * index), width: Constants.SCREEN_WIDTH / 2 - CGFloat(DataView.HOTIZONTAL_MARGIN), height: CGFloat(DataView.VIEW_HEIGHT))
        self.addSubview(labelDescription)
        
        labelValue = UILabel();
        labelValue.font = UIFont(name: "Verdana", size: 17)
        labelValue.textColor = Constants.FOREGROUND_COLOR
        labelValue.text = "Value"
        labelValue.textAlignment = .right
        labelValue.frame = CGRect(x: Constants.SCREEN_WIDTH / 2, y: CGFloat(DataView.HOTIZONTAL_MARGIN + DataView.VIEW_HEIGHT * index), width: Constants.SCREEN_WIDTH / 2 - CGFloat(DataView.HOTIZONTAL_MARGIN), height: CGFloat(DataView.VIEW_HEIGHT))
        self.addSubview(labelValue)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
