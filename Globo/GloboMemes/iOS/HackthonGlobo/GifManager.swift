//
//  GifManager.swift
//  HackthonGlobo
//
//  Created by Bruno Faganello Neto on 13/05/17.
//  Copyright © 2017 Bruno Faganello Neto. All rights reserved.
//

import UIKit
import Regift


class GifManager {
    
    class func convertToGIF(videoURL:String, frameCount:Int, delayTime:Float, loopCount:Int? = 0) -> Data{
        let url = URL(string:videoURL)
        let loop = loopCount ?? 0
        let reg = Regift(sourceFileURL: url!, frameCount: frameCount, delayTime: delayTime, loopCount: loop)
        let gifURL = reg.createGif()
        let data = try? Data(contentsOf: gifURL!)
        return data!
    }
    
    class func convertToMovie(videoURL:String) -> Data{
        let url = URL(string: videoURL)
        let data = try? Data(contentsOf: url!)
        return data!
    }
    
}
