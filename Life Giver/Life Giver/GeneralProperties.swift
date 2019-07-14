//
//  GeneralProperties.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 14/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
public class GeneralProperties{
    private init(){
    }
    
    private static let gameDone:String = "GameFinished"
    
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
    
    private static func updatePaths(){
        if hasColors{
            redApplePath = "\(applePrefix) \(redColorSuffix)"
            greenApplePath = "\(applePrefix) \(greenColorSuffix)"
            blueApplePath = "\(applePrefix) \(blueColorSuffix)"
            vasePath = "\(vasePrefix) Normal"
            redVasePath = "\(vasePrefix) \(redColorSuffix)"
            greenVasePath = "\(vasePrefix) \(greenColorSuffix)"
            blueVasePath = "\(vasePrefix) \(blueColorSuffix)"
            dropletPath = "\(dropletPrefix)"
            redSeedPath = "\(seedPrefix) \(redColorSuffix)"
            greenSeedPath = "\(seedPrefix) \(greenColorSuffix)"
            blueSeedPath = "\(seedPrefix) \(blueColorSuffix)"
            glassPath = "\(glassPrefix) Normal"
            glassBreakingPath = "\(glassPrefix) Quebrando"
            glassBrokenPath = "\(glassPrefix) Quebrado"
        }
        else{
            redApplePath = "\(applePrefix) \(greyStyleSuffix)"
            greenApplePath = "\(applePrefix) \(greyStyleSuffix)"
            blueApplePath = "\(applePrefix) \(greyStyleSuffix)"
            vasePath = "\(vasePrefix) Normal \(greyStyleSuffix)"
            redVasePath = "\(vasePrefix) \(greyStyleSuffix)"
            greenVasePath = "\(vasePrefix) \(greyStyleSuffix)"
            blueVasePath = "\(vasePrefix) \(greyStyleSuffix)"
            dropletPath = "\(dropletPrefix) \(greyStyleSuffix)"
            redSeedPath = "\(seedPrefix) \(greyStyleSuffix)"
            greenSeedPath = "\(seedPrefix) \(greyStyleSuffix)"
            blueSeedPath = "\(seedPrefix) \(greyStyleSuffix)"
            glassPath = "\(glassPrefix) Normal \(greyStyleSuffix)"
            glassBreakingPath = "\(glassPrefix) Quebrando \(greyStyleSuffix)"
            glassBrokenPath = "\(glassPrefix) Quebrado \(greyStyleSuffix)"
        }
    }
    private static let applePrefix = "Maca"
    private static let vasePrefix = "Vaso"
    private static let dropletPrefix = "Gota"
    private static let seedPrefix = "Semente"
    private static let glassPrefix = "Vidro"
    
    private static let greyStyleSuffix = "GS"
    private static let redColorSuffix = "Vermelha"
    private static let greenColorSuffix = "Verde"
    private static let blueColorSuffix = "Azul"
    
    //MARK : Apples
    public private(set) static var redApplePath:String = "\(applePrefix) \(greyStyleSuffix)"
    public private(set) static var greenApplePath:String = "\(applePrefix) \(greyStyleSuffix)"
    public private(set) static var blueApplePath:String = "\(applePrefix) \(greyStyleSuffix)"
    //MARK : Vases
    public private(set) static var vasePath:String = "\(vasePrefix) Normal \(greyStyleSuffix)"
    public private(set) static var redVasePath:String = "\(vasePrefix) \(greyStyleSuffix)"
    public private(set) static var greenVasePath:String = "\(vasePrefix) \(greyStyleSuffix)"
    public private(set) static var blueVasePath:String = "\(vasePrefix) \(greyStyleSuffix)"
    //MARK : Droplet
    public private(set) static var dropletPath:String = "\(dropletPrefix) \(greyStyleSuffix)"
    //MARK : Seeds
    public private(set) static var redSeedPath:String = "\(seedPrefix) \(greyStyleSuffix)"
    public private(set) static var greenSeedPath:String = "\(seedPrefix) \(greyStyleSuffix)"
    public private(set) static var blueSeedPath:String = "\(seedPrefix) \(greyStyleSuffix)"
    //MARK : Glasses
    public private(set) static var glassPath:String = "\(glassPrefix) Normal \(greyStyleSuffix)"
    public private(set) static var glassBreakingPath:String = "\(glassPrefix) Quebrando \(greyStyleSuffix)"
    public private(set) static var glassBrokenPath:String = "\(glassPrefix) Quebrado \(greyStyleSuffix)"
    
    public static func enableColors(){
        defaults.set(true, forKey: gameDone)
        hasColors = true
    }
    public static func disableColors(){
        defaults.set(false, forKey: gameDone)
        hasColors = false
    }
}
