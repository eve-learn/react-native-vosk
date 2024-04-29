//
//  Vosk.swift
//  VoskApiTest
//
//  Created by Niсkolay Shmyrev on 01.03.20.
//  Copyright © 2020-2021 Alpha Cephei. All rights reserved.
//

import Foundation

public final class VoskModel {
    
    var model : OpaquePointer!
    var spkModel : OpaquePointer!
    
    // init(name: String) throws {
        
    //     // Set to -1 to disable logs
    //     vosk_set_log_level(0);
        
    //     let appBundle = Bundle(for: Self.self)
        
    //     // Load model from main app bundle
    //     if let resourcePath = Bundle.main.resourcePath {
    //         let modelPath = resourcePath + "/" + name
    //         model = vosk_model_new(modelPath)
    //     }

    //     // Get the URL to the spk model inside this pod
    //     if let spkModelPath = appBundle.path(forResource: "vosk-model-spk-0.4", ofType: nil) {
    //         spkModel = vosk_spk_model_new(spkModelPath)
    //     }
    // }
    
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentsDirectory = paths[0]
//        return documentsDirectory
//    }

    init(name: String) throws {
        
        // Set to -1 to disable logs
        vosk_set_log_level(0);
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let modelURL = documentsDirectory.appendingPathComponent(name)
            if FileManager.default.fileExists(atPath: modelURL.path) {
                // File exists, you can read its contents or perform other operations
                do {
                    let fileContents = try String(contentsOf: fileURL)
                    print("File contents: \(fileContents)")

                    // Load model from documents directory
                    model = vosk_model_new(modelURL.path)

                    let appBundle = Bundle(for: Self.self)

                    // Get the URL to the spk model inside this pod
                    if let spkModelPath = appBundle.path(forResource: "vosk-model-spk-0.4", ofType: nil) {
                        spkModel = vosk_spk_model_new(spkModelPath)
                    }
                } catch {
                    print("Error reading file: \(error.localizedDescription)")
                }
            } else {
                print("File does not exist.")
            }
        
    }
    
    deinit {
        vosk_model_free(model)
        vosk_spk_model_free(spkModel)
    }
    
}

