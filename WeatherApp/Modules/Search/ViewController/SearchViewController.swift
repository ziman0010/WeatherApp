//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
    func set(items: [SearchItem])
    func add(lat: Float, lon: Float)
    func showEmptyState()
    func displayAlert(title: String?, message: String)
}

final class SearchViewController: UIViewController,
                                  SearchDisplayLogic,
                                  UITableViewDelegate,
                                  UITableViewDataSource,
                                  UISearchBarDelegate {
    
    var interactor: SearchBuisnessLogic?
    var onAddAction: ((Float, Float) -> Void)?
    
    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var searchBar: UISearchBar?
    @IBOutlet private weak var emptyStateLabel: UILabel?
    
    private var dataSource: [SearchItem] = []
    
    private var lastSearchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
    }
    
    
    func set(items: [SearchItem]) {
        dataSource = items
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
    
    func add(lat: Float, lon: Float) {
        onAddAction?(lat, lon)
    }
    
    func showEmptyState() {
        emptyStateLabel?.isHidden = false
    }
    
    func displayAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if lastSearchText.isEmpty {
            lastSearchText = searchText
        }
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.search), object: lastSearchText)
        lastSearchText = searchText
        self.perform(#selector(self.search), with: searchText, afterDelay: 0.7)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseId) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(with: dataSource[indexPath.row]) { [weak self] in
            guard
                let lat = self?.dataSource[indexPath.row].lat,
                let lon = self?.dataSource[indexPath.row].lon
            else {
                return
            }
            self?.interactor?.addWeather(lat: lat, lon: lon)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    private func configureSearchBar() {
        searchBar?.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        tableView?.keyboardDismissMode = .onDrag
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func search(query: String) {
        interactor?.search(query: query)
        emptyStateLabel?.isHidden = true
    }
}
