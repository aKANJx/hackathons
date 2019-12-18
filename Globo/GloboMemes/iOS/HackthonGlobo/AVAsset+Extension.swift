//
//  AVAsset+Extension.swift
//  HackthonGlobo
//
//  Created by Jean Paul Marinho on 14/05/17.
//  Copyright © 2017 Bruno Faganello Neto. All rights reserved.
//

import Foundation
import AVFoundation

extension AVAsset {
    
    func writeAudioTrackToURL(URL: NSURL, completion: @escaping (Bool, NSError?) -> ()) {
        
        do {
            
            let audioAsset = try self.audioAsset()
            audioAsset.writeToURL(URL: URL, completion: completion)
            
        } catch (let error as NSError){
            
            completion(false, error)
            
        } catch {
            
            print("\(type(of: self)) \(#function) [\(#line)], error:\(error)")
        }
    }
    
    func writeToURL(URL: NSURL, completion: @escaping (Bool, NSError?) -> ()) {
        
        guard let exportSession = AVAssetExportSession(asset: self, presetName: AVAssetExportPresetAppleM4A) else {
            completion(false, nil)
            return
        }
        
        exportSession.outputFileType = AVFileTypeAppleM4A
        exportSession.outputURL      = URL as URL
        
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                completion(true, nil)
            case .unknown, .waiting, .exporting, .failed, .cancelled:
                completion(false, nil)
            }
        }
    }
    
    func audioAsset() throws -> AVAsset {
        
        let composition = AVMutableComposition()
        
        let audioTracks = tracks(withMediaType: AVMediaTypeAudio)
        
        for track in audioTracks {
            
            let compositionTrack = composition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
            do {
                try compositionTrack.insertTimeRange(track.timeRange, of: track, at: track.timeRange.start)
            } catch {
                throw error
            }
            compositionTrack.preferredTransform = track.preferredTransform
        }
        return composition
    }
}
