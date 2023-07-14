//
//  AddCityListDelegate.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 07/07/2023.
//

import Foundation

protocol AddCityListDelegate: AnyObject {
    func searchResultSelected(result: CitySummaryModel)
}
