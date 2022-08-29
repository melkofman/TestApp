//
//  Extensions.swift
//  TestApp
//
//  Created by Melanie Kofman on 26.08.2022.
//

import Foundation
import UIKit
extension UITextField {
    func customField() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func error() {
        layer.borderColor = UIColor.red.cgColor
        backgroundColor = UIColor(red: 246, green: 34, blue: 23, alpha: 0.4)
    }
    
    func notEmpty() -> Bool {
        guard let text = self.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return false
        }
        if (text.isEmpty) {
            return false
        }
        return true
    }
}

extension UIButton {
    func styleBtn() {
        layer.cornerRadius = 8
        backgroundColor = .systemBlue
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIViewController {
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 250, height: 40))
        toastLabel.backgroundColor = UIColor.red
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 13.0)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.3, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
