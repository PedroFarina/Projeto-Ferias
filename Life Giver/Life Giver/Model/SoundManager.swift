//
//  SoundManager.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 01/08/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import AVFoundation

public enum GameSound : String {
    case waterFail = "water hit.m4a"
    case waterSuccess = "water drop.m4a"
    case glassBreaking = "glass cling.wav"
    case glassBroke = "glass shatter.wav"
    case appleJump = "apple jump.m4a"
    case appleToSeed = "thump.m4a"
    case levelSuccess = "success.wav"
}

public class SoundManager{
    private init(){
    }
    
    private static let defaults = UserDefaults.standard
    
    public static let SFXKey:String = "SFX"
    
    public static var SFXValue:Int = defaults.integer(forKey: SFXKey){
        didSet{
            defaults.set(SFXValue, forKey: SFXKey)
        }
    }
    
    private static var players:Dictionary<String, AVAudioPlayer> = [:]
    public static func initPlayers(){
        if players.count != 0{
            return
        }
        do{
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            if let path = Bundle.main.path(forResource: GameSound.waterFail.rawValue, ofType: nil){
                players[GameSound.waterFail.rawValue] = initPlayer(path: path, typeHint: AVFileType.m4a.rawValue)
            }
            
            if let path = Bundle.main.path(forResource: GameSound.waterSuccess.rawValue, ofType: nil){
                players[GameSound.waterSuccess.rawValue] = initPlayer(path: path, typeHint: AVFileType.m4a.rawValue)
            }
            
            if let path = Bundle.main.path(forResource: GameSound.glassBreaking.rawValue, ofType: nil){
                players[GameSound.glassBreaking.rawValue] = initPlayer(path: path, typeHint: AVFileType.wav.rawValue)
            }
            
            if let path = Bundle.main.path(forResource: GameSound.glassBroke.rawValue, ofType: nil){
                players[GameSound.glassBroke.rawValue] = initPlayer(path: path, typeHint: AVFileType.wav.rawValue)
            }
            
            if let path = Bundle.main.path(forResource: GameSound.appleJump.rawValue, ofType: nil){
                players[GameSound.appleJump.rawValue] = initPlayer(path: path, typeHint: AVFileType.m4a.rawValue)
            }
            
            if let path = Bundle.main.path(forResource: GameSound.appleToSeed.rawValue, ofType: nil){
                players[GameSound.appleToSeed.rawValue] = initPlayer(path: path, typeHint: AVFileType.m4a.rawValue)
            }
            
            if let path = Bundle.main.path(forResource: GameSound.levelSuccess.rawValue, ofType: nil){
                players[GameSound.levelSuccess.rawValue] = initPlayer(path: path, typeHint: AVFileType.wav.rawValue)
            }
            
            //if let path = Bundle.main.path(forResource: , ofType: )
        }
        catch let error{
            fatalError(error.localizedDescription)
        }
    }
    
    private static func initPlayer(path:String, typeHint:String) -> AVAudioPlayer{
        let url = URL(fileURLWithPath: path)
        do{
            let player = try AVAudioPlayer(contentsOf: url, fileTypeHint: typeHint)
            player.prepareToPlay()
            return player
        }
        catch let error{
            fatalError(error.localizedDescription)
        }
    }
    
    public static func playSFX(sound:GameSound){
        guard let player = players[sound.rawValue] else { return }
        player.volume = Float(SoundManager.SFXValue - 1)/100
        if player.isPlaying{
            player.stop()
        }
        player.play()
    }
}
