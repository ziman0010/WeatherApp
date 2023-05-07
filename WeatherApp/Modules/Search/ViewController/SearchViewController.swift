//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
    func set(items: [SearchItem])
    func add(weather: Weather)
}

final class SearchViewController: UIViewController,
                                  SearchDisplayLogic,
                                  UITableViewDelegate,
                                  UITableViewDataSource,
                                  UISearchBarDelegate {
   
    var interactor: SearchBuisnessLogic?
    var onAddAction: ((Weather) -> Void)?
    
    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var searchBar: UISearchBar?
    
    private var dataSource: [SearchItem] = []
    
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
    
    func add(weather: Weather) {
        onAddAction?(weather)
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            return
        }
        dismissKeyboard()
        interactor?.search(query: query)
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
            self?.interactor?.loadWeather(lat: lat, lon: lon)
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
}
