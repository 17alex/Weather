//
//  WetherViewController.swift
//  Weather
//
//  Created by Alex on 26.10.2020.
//

import UIKit

protocol MainViewInput: class {
    func update(forRow index: Int)
    func addRow(at index: Int)
    func showAlertForEnterNewCity()
    func showAlertNotLocationFor(cityName: String, error: Error)
    func showAlertForReaname(cityName: String)
    func showAlertAlreadyExists(cityName: String)
    func activityIndicator(animate: Bool)
}

class MainViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.stopAnimating()
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: String(describing: MainTableViewCell.self), bundle: nil), forCellReuseIdentifier: MainTableViewCell.reuseID)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.refreshControl = refreshControl
            tableView.tableHeaderView = searchController.searchBar
            tableView.rowHeight = 60
        }
    }
    
    //MARK: - Propertis
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        let searchCityString = NSLocalizedString("search city", comment: "")
        searchController.searchBar.placeholder = searchCityString
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        return searchController
        
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        searchController.searchBar.sizeToFit()
        
        // Add UISearchController to the tableView
//        tableView.tableHeaderView = searchController.searchBar
//        tableView.tableHeaderView?.backgroundColor = UIColor.clear
//        definesPresentationContext = true
//        searchController.hidesNavigationBarDuringPresentation = false
        
        // Style the UISearchController
//        searchController.searchBar.barTintColor = UIColor.clear
//        searchController.searchBar.tintColor = UIColor.white
        
    }()

    private let refreshControl: UIRefreshControl = {
        let refControl = UIRefreshControl()
        
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [.foregroundColor: UIColor.white])
//        refreshControl.backgroundColor = .black
        
        refControl.tintColor = .red
        refControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refControl
    }()
    
    private let presenter: MainViewOutput
    
    //MARK: - Init
    
    init(presenter: MainViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LiveCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.start()
    }

    //MARK: - Metods
    
    private func setupUI() {
        title = NSLocalizedString("Weather", comment: "")
        let arrowBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(editButtonPress))
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCityButtonPress))
        navigationItem.leftBarButtonItem = arrowBarButtonItem
        navigationItem.rightBarButtonItem = addBarButtonItem
//        navigationItem.searchController = searchController
    }
    
    private func changeSearch(text: String?) {
        guard let text = text else { return }
        presenter.searchCity(with: text)
        tableView.reloadData()
    }
    
    @objc
    private func refreshData() {
        presenter.start()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc
    private func editButtonPress() {
        let isEdit = tableView.isEditing
        tableView.setEditing(!isEdit, animated: true)
    }
    
    @objc
    private func addCityButtonPress() {
        presenter.addCityButtonAction()
    }
}

//MARK: - MainViewInput

extension MainViewController: MainViewInput {
    
    func activityIndicator(animate: Bool) {
        switch animate {
        case true: activityIndicator.startAnimating()
        case false: activityIndicator.stopAnimating()
        }
    }
    
    func update(forRow index: Int) {
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
    
    func addRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .right)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func showAlertForEnterNewCity() {
        let newCityString = NSLocalizedString("New City", comment: "")
        let addString = NSLocalizedString("Add", comment: "")
        let cancelSting = NSLocalizedString("Cancel", comment: "")
        let enterNewCityNameString = NSLocalizedString("enter new city name", comment: "")
        
        let alert = UIAlertController(title: newCityString, message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: addString, style: .default) { _ in
            if let newCityName = alert.textFields?.first?.text, newCityName != "" {
                self.presenter.enterNew(cityName: newCityName)
            }
        }
        let cancelAction = UIAlertAction(title: cancelSting, style: .cancel, handler: nil)
        alert.addTextField { (textField) in textField.placeholder = enterNewCityNameString }
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func showAlertNotLocationFor(cityName: String, error: Error) {
        let forCityString = NSLocalizedString("for name", comment: "")
        let notFoundLocationString = NSLocalizedString("not found location", comment: "")
        let okString = NSLocalizedString("Ok", comment: "")
        let inMapString = NSLocalizedString("in Map", comment: "")
            
        let alert = UIAlertController(title: forCityString + " " + cityName, message: notFoundLocationString, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okString, style: .cancel, handler: nil)
        let mapAction = UIAlertAction(title: inMapString, style: .default) { (action) in
            self.presenter.inMapButtonAction(for: cityName)
        }
        alert.addAction(okAction)
        alert.addAction(mapAction)
        present(alert, animated: true)
    }
    
    func showAlertForReaname(cityName: String) {
        let renameString = NSLocalizedString("Rename", comment: "")
        let enterNewCityNameString = NSLocalizedString("enter new city name", comment: "")
        let cancelSting = NSLocalizedString("Cancel", comment: "")
        let okString = NSLocalizedString("Ok", comment: "")
        
        let alert = UIAlertController(title: renameString + " " + cityName, message: enterNewCityNameString, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelSting, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: okString, style: .default) { (action) in
            if let newCityName = alert.textFields?.first?.text, newCityName != "" {
                self.presenter.renameCity(from: cityName, to: newCityName)
            }
        }
        alert.addTextField { (textField) in textField.placeholder = enterNewCityNameString }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showAlertAlreadyExists(cityName: String) {
        let thisCityNameString = NSLocalizedString("This city name", comment: "")
        let alreadyExistsString = NSLocalizedString("already exists.", comment: "")
        let okString = NSLocalizedString("Ok", comment: "")
        
        let alert = UIAlertController(title: thisCityNameString + " " + cityName, message: alreadyExistsString, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okString, style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.citiesForScreen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseID, for: indexPath) as! MainTableViewCell
        cell.setWeather(model: presenter.getViewModelFor(index: indexPath.row))
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteString = NSLocalizedString("Delete", comment: "")
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action,view,completionHandler) in
            self.presenter.removeCity(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let renameString = NSLocalizedString("Rename", comment: "")
        
        let renameAction = UIContextualAction(style: .normal, title: nil) { (action,view,completionHandler) in
            self.presenter.renameCityAction(at: indexPath.row)
            completionHandler(true)
        }
        renameAction.image = UIImage(systemName: "pencil")
        renameAction.backgroundColor = .orange
        return UISwipeActionsConfiguration(actions: [renameAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.pressToRow(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        presenter.reorderCity(at: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

//MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        changeSearch(text: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        changeSearch(text: "")
    }
}
