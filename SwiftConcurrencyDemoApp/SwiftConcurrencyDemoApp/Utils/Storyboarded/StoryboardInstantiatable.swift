//
//  StoryboardInstantiatable.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 29/06/2023.
//

import Foundation
import UIKit

public protocol StoryboardInstantiatable: UIViewController {
    associatedtype vcType = Self
    
    static func initVc() -> vcType
}
