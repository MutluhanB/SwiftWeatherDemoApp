//
//  CityListRouter.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 30/06/2023.
//

import UIKit

protocol CityListRouterProtocol {
    func navigateToAddCity()
}

class CityListRouter {
    private weak var viewController: CityListViewProtocol?
    
    init(viewController: CityListViewProtocol?) {
        self.viewController = viewController
    }
}

extension CityListRouter: CityListRouterProtocol {
    func navigateToAddCity() {
        let addCityVc = AddCityViewController.initVc()
        addCityVc.delegate = viewController
        viewController?.present(addCityVc, animated: true)
    }
}
