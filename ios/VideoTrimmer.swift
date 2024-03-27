import Foundation
import AVFoundation

@objc(VideoTrimmer)
class VideoTrimmer: NSObject {
  
  @objc func trimVideo(sourceURL: String, startTime: Double, endTime: Double, callback: @escaping RCTResponseSenderBlock) {
    let manager = FileManager.default
    guard let documentsPath = manager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
      callback(["Could not find cache directory", NSNull()])
      return
    }
    let outputPath = documentsPath.appendingPathComponent(UUID().uuidString).appendingPathExtension("mov").path
    
    let asset = AVAsset(url: URL(fileURLWithPath: sourceURL))
    let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)!
    
    exportSession.outputURL = URL(fileURLWithPath: outputPath)
    exportSession.outputFileType = .mov
    exportSession.timeRange = CMTimeRangeFromTimeToTime(start: CMTimeMakeWithSeconds(startTime, preferredTimescale: 600), end: CMTimeMakeWithSeconds(endTime, preferredTimescale: 600))
    
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
}
