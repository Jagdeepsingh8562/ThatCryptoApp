//
//  HelperExtentation.swift
//  ThatCryptoApp
//
//  Created by Jagdeep Singh on 10/05/21.
//

import Foundation
import UIKit
import Network

extension UIViewController {
    
    func showAlert(message: String, title: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alertVC, animated: true)
        }
    }
    
    
    func openLink(_ url: String) {
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url) else {
            showAlert(message: "Cannot open link.", title: "Invalid Link")
            return
        }
        UIApplication.shared.open(url, options: [:])
    }

    func internetChecker(completion: @escaping (Bool) -> Void){
        let monitor = NWPathMonitor()
        let netqueue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                print("There's no internet connection.")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
        
        monitor.start(queue: netqueue)
    
    }

}

