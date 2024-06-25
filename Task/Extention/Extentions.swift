//
//  Extentions.swift
//  Task
//
//  Created by ARK on 10/06/2024.

import Foundation
import UIKit

// MARK: - ExtentionUITableViewCell
extension UITableViewCell {
     func setupLabel(_ label: UILabel) {
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.textAlignment = .center
        label.textColor = .blue
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.backgroundColor = UIColor.white
        label.layer.shadowColor = UIColor.red.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 1)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2
    }
}

// MARK: - ExtentionUIViewController
extension UIViewController {
     func setupTitleLabel(_ label: UILabel) {
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
            label.layer.borderWidth = 2
            label.layer.borderColor = UIColor.blue.cgColor
            label.textColor = UIColor.black
            label.backgroundColor = UIColor.white
            label.layer.shadowColor = UIColor.black.cgColor
            label.layer.shadowOffset = CGSize(width: 0, height: 2)
            label.layer.shadowOpacity = 0.2
            label.layer.shadowRadius = 4
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textAlignment = .center
        }
    
    func setupLabel(_ label: UILabel) {
       label.layer.cornerRadius = 8
       label.layer.masksToBounds = true
       label.layer.borderWidth = 1
       label.textAlignment = .center
       label.textColor = .blue
       label.layer.borderColor = UIColor.lightGray.cgColor
       label.backgroundColor = UIColor.white
       label.layer.shadowColor = UIColor.red.cgColor
       label.layer.shadowOffset = CGSize(width: 0, height: 1)
       label.layer.shadowOpacity = 0.5
       label.layer.shadowRadius = 2
   }
    
     func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

// MARK: - ExtentionUIViewController
extension UICollectionViewCell {
    func setupLabel(_ label: UILabel) {
       label.layer.cornerRadius = 8
       label.layer.masksToBounds = true
       label.layer.borderWidth = 1
       label.textAlignment = .center
       label.textColor = .blue
       label.layer.borderColor = UIColor.lightGray.cgColor
       label.backgroundColor = UIColor.white
       label.layer.shadowColor = UIColor.red.cgColor
       label.layer.shadowOffset = CGSize(width: 0, height: 1)
       label.layer.shadowOpacity = 0.5
       label.layer.shadowRadius = 2
   }
}
