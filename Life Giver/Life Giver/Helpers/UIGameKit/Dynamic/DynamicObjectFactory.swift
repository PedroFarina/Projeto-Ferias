//
//  DynamicObjectFactory.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 26/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class DynamicObjectsFactory{
    public static func addObject(object:AffectedByDynamics, controller:DynamicAnimatorController){
        controller.addSubview(object)
    }
    
    public static func createSquare(height:Int, width:Int, fillColor:UIColor, controller:DynamicAnimatorController) -> DynamicShapeView{
        return createSquare(rect: CGRect(x: 0, y: 0, width: width, height: height), fillColor: fillColor, controller: controller)
    }
    
    public static func createSquare(rect:CGRect, fillColor:UIColor, controller:DynamicAnimatorController) -> DynamicShapeView{
        let obj = DynamicShapeView(frame: rect)
        obj.fillColor = fillColor
        
        controller.addSubview(obj)
        return obj
    }
    
    public static func createCircle(radius:CGFloat, fillColor:UIColor, controller:DynamicAnimatorController) -> DynamicShapeView{
        return createCircle(radius: radius, at: CGPoint(x: 0, y: 0), fillColor: fillColor, controller: controller)
    }
    
    public static func createCircle(radius:CGFloat, at:CGPoint, fillColor:UIColor, controller:DynamicAnimatorController) -> DynamicShapeView{
        let obj = DynamicShapeView(frame: CGRect(x: at.x, y: at.y, width: CGFloat(radius * 2), height: CGFloat(radius * 2)))
        obj.fillColor = fillColor
        obj.radius = radius
        
        controller.addSubview(obj)
        return obj
    }
    
    public static func createImage(image:UIImage, center:CGPoint, controller:DynamicAnimatorController) -> DynamicImageView{
        let obj  = DynamicImageView(image: image)
        obj.center = center
        
        controller.addSubview(obj)
        return obj
    }
}
