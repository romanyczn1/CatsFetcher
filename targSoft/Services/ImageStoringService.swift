//
//  ImageStoringService.swift
//  targSoft
//
//  Created by Roman Bukh on 8.08.21.
//

import UIKit

protocol ImageStoringServiceType {
    func saveImage(imageUrl: String)
}

final class ImageStoringService: ImageStoringServiceType {
    
    func saveImage(imageUrl: String) {
        createFile()
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Downloads", isDirectory: true)

        if let url = URL(string: imageUrl) {
            URLSession.shared.downloadTask(with: url) { location, response, error in
                guard let location = location else {
                    print("download error:", error ?? "")
                    return
                }
                // move the downloaded file from the temporary location url to your app documents directory
                do {
                    try FileManager.default.moveItem(at: location, to: documents.appendingPathComponent(response?.suggestedFilename ?? url.lastPathComponent))
                    print("nice ez saved")
                } catch {
                    print(error)
                }
            }.resume()
        }
    }
    
    func createFile() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        let dataPath = docURL.appendingPathComponent("Downloads")
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
