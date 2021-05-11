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
    func setChangePercentage(_ changeLabel: UILabel,percentage: String?){
        guard let a = percentage  else {
            changeLabel.text = ""
            return
        }
        let doubleValue = Double(a)!
        var arrow: String = ""
        if doubleValue < 0 {
            changeLabel.textColor = .red
            arrow = "\u{2193}"
        }
        else {
            changeLabel.textColor = .systemGreen
            arrow = "\u{2191}"
        }
        changeLabel.text = arrow + String(format: "%.2f", doubleValue) + "%"
    }
    func setPrice(_ priceLabel: UILabel,price: String,currencySymbol: String) {
        let doubleValue = Double(price)!
        priceLabel.text = currencySymbol + String(format: "%.3f", doubleValue)
    }
    func formatPrice(_ number: Double) -> String {
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000

        if billion >= 1.0 {
            return "\(round(billion*10)/10)Billion"
        } else if million >= 1.0 {
            return "\(round(million*10)/10)Million"
        } else if thousand >= 1.0 {
            return ("\(round(thousand*10/10))K")
        } else {
            return "\(Int(number))"
        }
    }
}

