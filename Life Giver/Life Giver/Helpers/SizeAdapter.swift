//
//  SizeAdapter.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 17/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class SizeAdapter{
    private init(){
    }
    
    public static func getRatioSizeByHeight(_ size:CGSize, deviceSize:CGSize) -> CGSize{
        let newHeight:CGFloat = size.height * deviceSize.height / GeneralProperties.iPhoneXRSize.height
        let ratio = (size.height / size.width)
        
        let newWidth:CGFloat = newHeight * ratio
        
        return CGSize(width: newWidth, height: newHeight)
    }
    
    public static func getRatioSizeByWidth(_ size:CGSize, deviceSize:CGSize) -> CGSize{
        let newWidth:CGFloat = size.width * deviceSize.width / GeneralProperties.iPhoneXRSize.width
        let ratio = (size.width / size.height)
        
        let newHeight:CGFloat = newWidth * ratio
        
        return CGSize(width: newWidth, height: newHeight)
    }
    
    public static func getRatioSizeByMinor(_ size:CGSize, deviceSize:CGSize) -> CGSize{
        if deviceSize.height < deviceSize.width{
            return getRatioSizeByHeight(size, deviceSize: deviceSize)
        }
        else{
            return getRatioSizeByWidth(size, deviceSize: deviceSize)
        }
    }
    
    public static func getProportionalSize(_ object:UIView, deviceSize:CGSize) -> CGSize{
        let newWidth:CGFloat = object.frame.size.width * deviceSize.width / GeneralProperties.iPhoneXRSize.width
        let newHeight:CGFloat  = object.frame.size.height * deviceSize.height / GeneralProperties.iPhoneXRSize.height
        
        return CGSize(width: newWidth, height: newHeight)
    }
    
    public static func getTrebuchetProportionalFontSize(_ fontSize:CGFloat, deviceSize:CGSize) -> CGFloat{
        
        let newFontSize:CGFloat = fontSize * deviceSize.height / GeneralProperties.iPhoneXRSize.height
        
        return newFontSize
    }
}
