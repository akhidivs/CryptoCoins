//
//  LocalFileManager.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 04/02/25.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let shared = LocalFileManager()
    private init() { }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path()) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path())
    }
    
    func saveImage(image: UIImage, with imageName: String, and folderName: String) {
        
        // create folder if not created already
        createFolderIfNeeded(folderName: folderName)
        
        // get image data to save to file
        guard let imageData = image.pngData(),
        let url = getURLForImage(imageName: imageName, folderName: folderName) else { return }
        
        // save image data to file
        do {
            try imageData.write(to: url)
        } catch let error {
            print("Error saving image \(imageName) - \(error.localizedDescription)")
        }
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let folder = getURLForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: folder.path()) {
            do {
                try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory \(folderName) - \(error.localizedDescription)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appending(path: folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folder = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folder.appending(path: imageName + ".png")
    }
}
