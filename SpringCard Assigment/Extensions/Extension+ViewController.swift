//
//  Extension+ViewController.swift
//  SpringCard Assigment
//
//  Created by Mina Wefky on 09/03/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(with title: String, message: String) {
        dismiss(animated: false, completion: nil)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    static func loadNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: Bundle.init(for: Self.self))
        }
        return instantiateFromNib()
    }
}
