//
//  Images.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 30/06/2023.
//

import Foundation
import UIKit

enum Images: String {
    case plus = "plus"
}

extension UIImage {
    static func image(from image: Images) -> UIImage {
        return UIImage(systemName: image.rawValue)!
    }
}
