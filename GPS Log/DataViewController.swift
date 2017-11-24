//
//  FirstViewController.swift
//  GPS Log
//
//  Created by Zhang Bozheng on 15/11/17.
//  Copyright © 2017 Zhang Bozheng. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UIAlertViewDelegate {

    var views = [DataView]();
    var foregroundColor: UIColor!
    
    var canvas: UIImageView!
    let CANVAS_WIDTH: CGFloat = 250;
    let CANVAS_HEIGHT: CGFloat = 250;
    let CANVAS_BOTTOM_MARGIN: CGFloat = 100;
    
    var pointerViews = [PointerType : UIView](); // Size, View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Constants.BACKGROUND_COLOR
        
    }
    
    func addView(view: UIView){
        
        self.view.addSubview(view)
        views.append(view as! DataView)
        
    }
    
    func addCanvas(imageName: String){
        
        //Add the canvas
        canvas = UIImageView(frame: CGRect(x: Constants.SCREEN_WIDTH / 2 - CANVAS_WIDTH / 2, y: Constants.SCREEN_HEIGHT - CANVAS_HEIGHT - CANVAS_BOTTOM_MARGIN, width: CANVAS_WIDTH, height: CANVAS_HEIGHT))
        canvas.image = UIImage(named: imageName)
        self.view.addSubview(canvas)
        
    }
    
    func addPointer(pointerType: PointerType, pointerTypeString: String){
        
        let pointerView = UIImageView();
        pointerView.image = UIImage(named: pointerTypeString)
        pointerView.frame = CGRect(x: 0, y: 0, width: CANVAS_WIDTH, height: CANVAS_HEIGHT)

        canvas.addSubview(pointerView)
        pointerViews[pointerType] = pointerView
        
    }
    
    func updatePointer(pointerType: PointerType, angleInRadians: Double){
        
        pointerViews[pointerType]?.transform = CGAffineTransform(rotationAngle: CGFloat(angleInRadians))
        
    }
    
    func setLabel(viewName: String, side: Side, value: String){
        
        for view in views{
            
            if(view.name == viewName){
                
                switch side {
                case .Description:
                    view.labelDescription.text = value
                    break
                    
                case .Value:
                    view.labelValue.text = value
                    break
                }
                
            }
            
        }
        
    }
    
    func showTextfield(title: String, message: String){
        
        var alert = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
        alert.alertViewStyle = .plainTextInput
        alert.show()
        
    }
    
    func alertView(_ alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        
        if(buttonIndex == 1){
            
            if let value = (alertView.textField(at: 0)?.text)!.doubleValue  {
                AltitudeProvider.seaLevelPressure = value
            } else {
                print("invalid input")
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

enum PointerType{
    
    case Long
    case Medium
    case Short
    
}

extension String {
    var doubleValue: Double? {
        return Double(self)
    }
    var floatValue: Float? {
        return Float(self)
    }
    var integerValue: Int? {
        return Int(self)
    }
}
