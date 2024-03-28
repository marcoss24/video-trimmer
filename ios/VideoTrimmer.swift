import Foundation
import AVFoundation
import React

@objc(VideoTrimmer)
class VideoTrimmer: RCTEventEmitter {
  
  @objc(trimVideo:startTime:endTime:callback:)
  func trimVideo(sourceURL: String, startTime: Double, endTime: Double, callback: @escaping RCTResponseSenderBlock) {
    let manager = FileManager.default
    guard let documentsPath = manager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
      callback(["Could not find cache directory", NSNull()])
      return
    }
    
    // Determine the file extension to preserve the original format
    let fileExtension = URL(fileURLWithPath: sourceURL).pathExtension
    let outputPath = documentsPath.appendingPathComponent(UUID().uuidString).appendingPathExtension(fileExtension).path
    
    let asset = AVAsset(url: URL(fileURLWithPath: sourceURL))
    guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {
      callback(["Could not create AVAssetExportSession", NSNull()])
      return
    }
    
    exportSession.outputURL = URL(fileURLWithPath: outputPath)
    
    // Preserving the original video format
    switch fileExtension.lowercased() {
    case "mov":
        exportSession.outputFileType = .mov
    case "mp4":
        exportSession.outputFileType = .mp4
    default:
        callback(["Unsupported file format", NSNull()])
        return
    }
    
    exportSession.timeRange = CMTimeRange(start: CMTimeMakeWithSeconds(startTime, preferredTimescale: 600), end: CMTimeMakeWithSeconds(endTime, preferredTimescale: 600))
    
    exportSession.exportAsynchronously {
      switch exportSession.status {
      case .completed:
        callback([NSNull(), outputPath])
      case .failed, .cancelled:
        callback([exportSession.error?.localizedDescription ?? "Unknown error", NSNull()])
      default:
        break
      }
    }
  }
  
  override func supportedEvents() -> [String]! {
    // Return an array of event names if your module may emit events to JavaScript
    return []
  }

  @objc
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
