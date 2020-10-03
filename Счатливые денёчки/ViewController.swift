//
//  ViewController.swift
//  Счатливые денёчки
//
//  Created by Stanly Shiyanovskiy on 21.05.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import AVFoundation
import Photos
import Speech
import UIKit

public class ViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet private weak var helpLabel: UILabel!
    
    // MARK: - Main logic
    private func requestPhotosPermissions() {
        PHPhotoLibrary.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.requestRecordPermissions()
                } else {
                    self.helpLabel.text = "Разрешение на съемку фотографий было отклонено; включите его в настройках, затем снова нажмите Продолжить."
                }
            }
        }
    }
    
    private func requestRecordPermissions() {
        AVAudioSession.sharedInstance().requestRecordPermission { [unowned self] allowed in
            DispatchQueue.main.async {
                if allowed {
                    self.requestTranscribePermissions()
                } else {
                    self.helpLabel.text = "Разрешение на запись было отклонено; включите его в настройках, затем снова нажмите Продолжить."
                }
            }
        }
    }
    
    private func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { [unowned self] authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    self.authorizationComplete()
                } else {
                    self.helpLabel.text = "Разрешение на транскрипцию было отклонено; включите его в настройках, затем снова нажмите Продолжить."
                }
            }
        }
    }
    
    private func authorizationComplete() {
        dismiss(animated: true)
    }

    // MARK: - Actions
    @IBAction private func requestPermissions(_ sender: AnyObject) {
        requestPhotosPermissions()
    }
}

