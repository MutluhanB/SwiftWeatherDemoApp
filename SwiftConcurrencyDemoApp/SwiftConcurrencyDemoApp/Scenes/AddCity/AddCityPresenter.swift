//
//  AddCityPresenter.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 30/06/2023.
//

import Foundation

protocol AddCityPresenterProtocol: AnyObject {
    func searchTextDidChange(searchText: String)
    func numberOfRows() -> Int
    func getModel(indexPath: IndexPath) -> CitySummaryModel
    
}

class AddCityPresenter: AddCityPresenterProtocol {
    private weak var viewController: AddCityViewProtocol?
    private var interactor: AddCityInteractorProtocol
    private var searchResults: [CitySummaryModel] = [] {
        didSet {
            viewController?.reloadData(results: searchResults)
        }
    }
    
    init(viewController: AddCityViewProtocol, interactor: AddCityInteractorProtocol = AddCityInteractor()) {
        self.viewController = viewController
        self.interactor = interactor
    }
    
    func searchTextDidChange(searchText: String) {
        Task {
            await self.searchLocation(searchText: searchText)
        }
    }
    
    func numberOfRows() -> Int {
        return searchResults.count
    }
    
    func getModel(indexPath: IndexPath) -> CitySummaryModel {
        return searchResults[indexPath.row]
    }
    
    private func searchLocation(searchText: String, limit: String = "5") async {
        var modifiedSearchText = searchText
        if searchText == "" { modifiedSearchText = " "}
        
        viewController?.showLoading()
        let response = await interactor.searchForLocation(location: modifiedSearchText, limit: limit)
        switch response {
        case .success(let models):
            searchResults = models
        case .failure(let failure):
            viewController?.showError()
        }
        
        viewController?.hideLoading()
    }
    
}
