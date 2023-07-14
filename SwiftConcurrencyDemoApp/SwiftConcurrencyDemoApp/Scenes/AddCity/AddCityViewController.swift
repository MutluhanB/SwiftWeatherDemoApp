//
//  AddCityViewController.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 30/06/2023.
//

import UIKit

protocol AddCityViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError()
    func reloadData(results: [CitySummaryModel])
}

class AddCityViewController: UIViewController {
    
    private lazy var backgroundTap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        return tap
    }()
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "Search City..."
            searchBar.delegate = self
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    
    private var timer: Timer?
    var presenter: AddCityPresenterProtocol!
    weak var delegate: AddCityListDelegate?
    
    var dataSource: UITableViewDiffableDataSource<Section, CitySummaryModel>!
    
    enum Section {
        case first
    }
    
    deinit {
        timer?.invalidate()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(backgroundTap)
        setupDataSource()
        // Do any additional setup after loading the view.
    }
    
    @objc private func backgroundTapped() {
        view.endEditing(true)
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let model = self.presenter.getModel(indexPath: indexPath)
            cell.textLabel?.text = "\(model.name ?? ""), \(model.country ?? "")"
            return cell
        })
    }
    
}

extension AddCityViewController: AddCityViewProtocol {
    func showLoading() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .blue
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
        }
    }
    
    func showError() {
        
        self.view.backgroundColor = .red
    }
    
    func reloadData(results: [CitySummaryModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CitySummaryModel>()
        snapshot.appendSections([.first])
        snapshot.appendItems(results)
        
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

extension AddCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let viewModel = presenter.getModel(indexPath: indexPath)
        delegate?.searchResultSelected(result: viewModel)
        self.dismiss(animated: true)
    }

}

extension AddCityViewController: UISearchBarDelegate {
    
    private func setSearchTextWithDebounce(searchText: String?) {
        guard let text = searchText else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { [weak self] _ in
            guard let self = self else { return }
            Task {
                self.presenter.searchTextDidChange(searchText: text)
            }
        })
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        setSearchTextWithDebounce(searchText: searchText)
    }
}

extension AddCityViewController: StoryboardInstantiatable {
    static func initVc() -> AddCityViewController {
        let viewController: AddCityViewController = AddCityViewController.instantiate(from: .addCity)
        viewController.presenter = AddCityPresenter(viewController: viewController)
        return viewController
    }
}

extension AddCityViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIControl {
            return false
        }
        return true
    }
    
}
