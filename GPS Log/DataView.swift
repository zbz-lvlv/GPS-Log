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
    
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let VIEW_HEIGHT = 20;
    
    init(frameIn: CGRect, index: Int) {
        
        super.init(frame: frameIn)
        
        let labelDescription = UILabel();
        labelDescription.font = UIFont(name: "Verdana", size: 17)
        labelDescription.text = "Description"
        self.addSubview(labelDescription)
        
        let labelValue = UILabel();
        labelValue.font = UIFont(name: "Verdana", size: 17)
        labelValue.text = "Value"
        labelValue.textAlignment = .right
        labelValue.frame = CGRect(x: DataView.SCREEN_WIDTH / 2, y: CGFloat(8 + DataView.VIEW_HEIGHT * index), width: DataView.SCREEN_WIDTH / 2 - 20, height: CGFloat(VIEW_HEIGHT))
        self.addSubview(labelValue)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
