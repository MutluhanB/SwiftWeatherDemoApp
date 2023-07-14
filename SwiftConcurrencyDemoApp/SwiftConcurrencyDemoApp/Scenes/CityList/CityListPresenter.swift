//
//  CityListPresenter.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 30/06/2023.
//

import Foundation

protocol CityListPresenterProtocol: AnyObject {
    func addCityButtonTapped()
    func getViewModel(indexPath: IndexPath) -> CityWeatherStatusModel
    func numberOfRows() -> Int
    func locationAdded(location: CitySummaryModel)
}

class CityListPresenter {
    
    private weak var view: CityListViewProtocol?
    private var interactor: CityListInteractorProtocol
    private var router: CityListRouterProtocol?
    
    private var locations : [CityWeatherStatusModel] = [] {
        didSet {
            view?.reloadData(locations: locations)
        }
    }
    
    init(view: CityListViewProtocol, router: CityListRouterProtocol, interactor: CityListInteractorProtocol = CityListInteractor()) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension CityListPresenter: CityListPresenterProtocol {
    func addCityButtonTapped() {
        router?.navigateToAddCity()
    }
    
    func numberOfRows() -> Int {
        return locations.count
    }
    
    func getViewModel(indexPath: IndexPath) -> CityWeatherStatusModel {
        return locations[indexPath.row]
    }
    
    func locationAdded(location: CitySummaryModel) {
        Task {
            let lat = "\(location.lat ?? 0.0)"
            let lon = "\(location.lon ?? 0.0)"

            let result = await interactor.getWeatherInformation(lat: lat, lon: lon)
            switch result {
            case .success(let model):
                locations.append(model)
            case .failure(let failure):
                view?.showError(message: failure.localizedDescription)
            }
        }
    }
}
