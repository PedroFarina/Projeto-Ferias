//
//  GeneralProperties.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 14/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
public class GeneralProperties{
    private init(){
    }
    
    public static let iPhoneXRSize:CGSize = CGSize(width: 414, height: 896)
    
    private static let gameDone:String = "GameFinished"
    public static let SFXKey:String = "SFX"
    public static let BGMKey:String = "BGM"
    public static let DaltonismoKey:String = "Daltonismo"
    
    private static let defaults = UserDefaults.standard
    private static var _hasColors:Bool = defaults.bool(forKey: gameDone)
    
    public private(set) static var hasColors:Bool{
        get{
            return _hasColors
        }
        set{
            _hasColors = newValue
            updatePaths()
        }
    }
    
    public static var SFXValue:Int = defaults.integer(forKey: SFXKey){
        didSet{
            defaults.set(SFXValue, forKey: SFXKey)
        }
    }
    public static var BGMValue:Int = defaults.integer(forKey: BGMKey){
        didSet{
            defaults.set(BGMValue, forKey: BGMKey)
        }
    }
    public static var DaltonismoValue:Bool = defaults.bool(forKey: DaltonismoKey){
        didSet{
            defaults.set(DaltonismoValue, forKey: DaltonismoKey)
            if DaltonismoValue{
                daltonismoSuSuffix = "Daltonismo"
            }
            else{
                daltonismoSuSuffix = ""
            }
            updatePaths()
        }
    }
    
    private static var started:Bool = false
    public static func start(){
        if !started{
            updatePaths()
            started = true
        }
    }
    
    private static func updatePaths(){
        if hasColors{
            redColor = #colorLiteral(red: 0.7490196078, green: 0.1764705882, blue: 0.1294117647, alpha: 1)
            blueColor = #colorLiteral(red: 0.1921568627, green: 0.4235294118, blue: 0.6901960784, alpha: 1)
            lightblueColor = #colorLiteral(red: 0.1294117647, green: 0.6980392157, blue: 0.7490196078, alpha: 1)
            bronzeColor = #colorLiteral(red: 0.6901960784, green: 0.5529411765, blue: 0.3411764706, alpha: 1)
            silverColor = #colorLiteral(red: 0.4588235294, green: 0.5254901961, blue: 0.5725490196, alpha: 1)
            goldColor = #colorLiteral(red: 0.9176470588, green: 0.6862745098, blue: 0.1098039216, alpha: 1)
            playPath = "\(playPrefix)"
            cogPath = "\(cogPrefix)"
            redApplePath = "\(applePrefix) \(redColorSuffix) \(daltonismoSuSuffix)"
            greenApplePath = "\(applePrefix) \(greenColorSuffix) \(daltonismoSuSuffix)"
            blueApplePath = "\(applePrefix) \(blueColorSuffix) \(daltonismoSuSuffix)"
            vasePath = "\(vasePrefix) Normal"
            redVasePath = "\(vasePrefix) \(redColorSuffix) \(daltonismoSuSuffix)"
            greenVasePath = "\(vasePrefix) \(greenColorSuffix) \(daltonismoSuSuffix)"
            blueVasePath = "\(vasePrefix) \(blueColorSuffix) \(daltonismoSuSuffix)"
            dropletPath = "\(dropletPrefix)"
            redSeedPath = "\(seedPrefix) \(redColorSuffix) \(daltonismoSuSuffix)"
            greenSeedPath = "\(seedPrefix) \(greenColorSuffix) \(daltonismoSuSuffix)"
            blueSeedPath = "\(seedPrefix) \(blueColorSuffix) \(daltonismoSuSuffix)"
            glassPath = "\(glassPrefix) Normal"
            glassBreakingPath = "\(glassPrefix) Quebrando"
            glassBrokenPath = "\(glassPrefix) Quebrado"
        }
        else{
            redColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            blueColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            lightblueColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            bronzeColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5137254902, alpha: 1)
            silverColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5137254902, alpha: 1)
            goldColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5137254902, alpha: 1)
            playPath = "\(playPrefix) \(grayStyleSuffix)"
            cogPath = "\(cogPrefix) \(grayStyleSuffix)"
            redApplePath = "\(applePrefix) \(grayStyleSuffix)"
            greenApplePath = "\(applePrefix) \(grayStyleSuffix)"
            blueApplePath = "\(applePrefix) \(grayStyleSuffix)"
            vasePath = "\(vasePrefix) Normal \(grayStyleSuffix)"
            redVasePath = "\(vasePrefix) \(grayStyleSuffix)"
            greenVasePath = "\(vasePrefix) \(grayStyleSuffix)"
            blueVasePath = "\(vasePrefix) \(grayStyleSuffix)"
            dropletPath = "\(dropletPrefix) \(grayStyleSuffix)"
            redSeedPath = "\(seedPrefix) \(grayStyleSuffix)"
            greenSeedPath = "\(seedPrefix) \(grayStyleSuffix)"
            blueSeedPath = "\(seedPrefix) \(grayStyleSuffix)"
            glassPath = "\(glassPrefix) Normal \(grayStyleSuffix)"
            glassBreakingPath = "\(glassPrefix) Quebrando \(grayStyleSuffix)"
            glassBrokenPath = "\(glassPrefix) Quebrado \(grayStyleSuffix)"
        }
    }
    private static let playPrefix = "Play"
    private static let cogPrefix = "Cog"
    private static let applePrefix = "Maca"
    private static let vasePrefix = "Vaso"
    private static let dropletPrefix = "Gota"
    private static let seedPrefix = "Semente"
    private static let glassPrefix = "Vidro"
    
    private static let grayStyleSuffix = "GS"
    private static let redColorSuffix = "Vermelha"
    private static let greenColorSuffix = "Verde"
    private static let blueColorSuffix = "Azul"
    
    private static var daltonismoSuSuffix = ""
    
    //MARK : Colors
    public private(set) static var redColor:UIColor = UIColor()
    public private(set) static var blueColor:UIColor = UIColor()
    public private(set) static var lightblueColor:UIColor = UIColor()
    public private(set) static var bronzeColor:UIColor = UIColor()
    public private(set) static var silverColor:UIColor = UIColor()
    public private(set) static var goldColor:UIColor = UIColor()
    //MARK : Play
    public private(set) static var playPath:String = ""
    //MARK : Cog
    public private(set) static var cogPath:String = ""
    //MARK : Apples
    public private(set) static var redApplePath:String = ""
    public private(set) static var greenApplePath:String = ""
    public private(set) static var blueApplePath:String = ""
    //MARK : Vases
    public private(set) static var vasePath:String = ""
    public private(set) static var redVasePath:String = ""
    public private(set) static var greenVasePath:String = ""
    public private(set) static var blueVasePath:String = ""
    //MARK : Droplet
    public private(set) static var dropletPath:String = ""
    //MARK : Seeds
    public private(set) static var redSeedPath:String = ""
    public private(set) static var greenSeedPath:String = ""
    public private(set) static var blueSeedPath:String = ""
    //MARK : Glasses
    public private(set) static var glassPath:String = ""
    public private(set) static var glassBreakingPath:String = ""
    public private(set) static var glassBrokenPath:String = ""
    
    public static func enableColors(){
        defaults.set(true, forKey: gameDone)
        hasColors = true
    }
    public static func disableColors(){
        defaults.set(false, forKey: gameDone)
        hasColors = false
    }
}
