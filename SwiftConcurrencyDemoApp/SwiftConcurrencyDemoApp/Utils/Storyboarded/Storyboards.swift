//
//  Storyboard.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 29/06/2023.
//

import Foundation
import UIKit


// write an extension from app
enum Storyboards: String {
    case viewController = "ViewController"
    case cityList = "CityList"
    case addCity = "AddCity"
}

extension Storyboards {
    public var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    public func viewController<S: UIViewController>(viewControllerClass: S.Type, function: String = #function, line: Int = #line, file: String = #file) -> S {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? S else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
}
