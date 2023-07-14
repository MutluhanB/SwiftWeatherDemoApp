//
//  CityListViewController.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 29/06/2023.
//

import UIKit
import CoreUtilities

protocol CityListViewProtocol: UIViewController, AddCityListDelegate {
    func reloadData(locations: [CityWeatherStatusModel])
    func showError(message: String?)
}

class CityListViewController: UIViewController {

    @IBOutlet weak var addCityButton: UIButton! {
        didSet {
            addCityButton.setImage(UIImage.image(from: .plus), for: .normal)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
            tableView.delegate = self
        }
    }
    
    enum Section {
        case first
    }
    
    var datasource: UITableViewDiffableDataSource<Section, CityWeatherStatusModel>!
    
    var presenter: CityListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datasource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") else { return UITableViewCell() }
            let model = self.presenter.getViewModel(indexPath: indexPath)
            cell.textLabel?.text = "\(model.cityName ?? "") tempature: , \((model.tempatureKelvin ?? 0))"
            return cell
        })
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func addCityButtonTapped(_ sender: Any) {
        presenter.addCityButtonTapped()
    }
}


extension CityListViewController: CityListViewProtocol {
    
    func reloadData(locations: [CityWeatherStatusModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CityWeatherStatusModel>()
        snapshot.appendSections([.first])
        snapshot.appendItems(locations)
        
        datasource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func showError(message: String?) {
        print(message)
    }
    
}


extension CityListViewController: AddCityListDelegate {
    
    func searchResultSelected(result: CitySummaryModel) {
        presenter.locationAdded(location: result)
    }

}

extension CityListViewController: StoryboardInstantiatable {
    
    static func initVc() -> CityListViewController {
        let viewController: CityListViewController = CityListViewController.instantiate(from: .cityList)
        viewController.presenter = CityListPresenter(view: viewController, router: CityListRouter(viewController: viewController))
        return viewController
    }

}

extension CityListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
