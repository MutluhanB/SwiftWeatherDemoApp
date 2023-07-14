//
//  UIViewController+Extensions.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 29/06/2023.
//

import Foundation
import UIKit

extension UIViewController {
    @objc class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate<T>(from: Storyboards) -> T {
        return from.viewController(viewControllerClass: self) as! T
    }
}
