//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import UIKit

protocol MainDisplayLogic: AnyObject {
    func append(viewObject: WeatherCellViewObject)
    func replace(viewObject: WeatherCellViewObject)
    func set(allViewObjects: [WeatherCellViewObject])
    func displayAlert(title: String?, message: String)
}

final class MainViewController: UIViewController,
                                MainDisplayLogic,
                                UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout,
                                UIScrollViewDelegate {
    
    var interactor: MainBuisnessLogic?
    
    private var observer: NSObjectProtocol?
    
    @IBOutlet private weak var searchButton: UIBarButtonItem?
    @IBOutlet weak var blockView: UIView!
    @IBOutlet private weak var pageControl: UIPageControl?
    @IBOutlet private weak var collectionView: UICollectionView?
    @IBOutlet private weak var gradientView: GradientView?
    
    private var dataSource: [WeatherCellViewObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureObserver()
        configurePageControl()
        interactor?.viewDidLoad()
    }
    
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
        NotificationCenter.default.removeObserver(NSNotification.Name("Block"))
        NotificationCenter.default.removeObserver(NSNotification.Name("UnBlock"))
        
    }
    
    @IBAction func didTapSearch(_ sender: Any) {
        let controller = SearchInitializer.controller { [weak self] lat, lon in
            var index: Int
            if let count = self?.dataSource.count {
                index = count > 0 ? (count - 1) : -1
            } else {
                index = 0
            }
            self?.interactor?.addWeather(lat: lat, lon: lon, prevIndex: index)
        }
        
        guard let controller = controller else {
            return
        }
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem?.tintColor = .white
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func append(viewObject: WeatherCellViewObject) {
        DispatchQueue.main.async { [weak self] in
            self?.dataSource.append(viewObject)
            self?.collectionView?.reloadData()
            let gradientColor = viewObject.gradientColor
            self?.gradientView?.startColor = UIColor(named: gradientColor.0)
            self?.gradientView?.endColor = UIColor(named: gradientColor.1)
        }
    }
    
    func replace(viewObject: WeatherCellViewObject) {
        guard dataSource.count > viewObject.index else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.dataSource[viewObject.index] = viewObject
            self?.collectionView?.reloadData()
            let gradientColor = viewObject.gradientColor
            self?.gradientView?.startColor = UIColor(named: gradientColor.0)
            self?.gradientView?.endColor = UIColor(named: gradientColor.1)
        }
    }
    
    func set(allViewObjects: [WeatherCellViewObject]) {
        DispatchQueue.main.async { [weak self] in
            self?.dataSource = allViewObjects
            if !allViewObjects.isEmpty {
                self?.gradientView?.startColor = UIColor(named: allViewObjects[0].gradientColor.0)
                self?.gradientView?.endColor = UIColor(named: allViewObjects[0].gradientColor.1)
            }
            self?.collectionView?.reloadData()
        }
    }
    
    func displayAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseId, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellViewObject = dataSource[indexPath.row]
        cell.setup(with: cellViewObject)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        pageControl?.numberOfPages = dataSource.count
        
        return dataSource.count
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl?.currentPage =  index
        
        let cellViewObject = dataSource[index]
        interactor?.updateWeather(viewObject: cellViewObject)
        
        let gradientColor = cellViewObject.gradientColor
        gradientView?.startColor = UIColor(named: gradientColor.0)
        gradientView?.endColor = UIColor(named: gradientColor.1)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    private func willEnterForeground() {
        guard let scrollView = view.subviews.filter({ $0 is UIScrollView }).first as? UIScrollView else {
            return
        }
        
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl?.currentPage =  index
        
        if index >= 0 && index < dataSource.count {
            let cellViewObject = dataSource[index]
            interactor?.updateWeather(viewObject: cellViewObject)
        }
    }
    
    private func configureCollectionView() {
        collectionView?.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.reuseId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    private func configureObserver() {
        observer =  NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] _ in
            self?.willEnterForeground()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(blockApp), name: NSNotification.Name("Block"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(unblockApp), name: NSNotification.Name("UnBlock"), object: nil)

    }
    
    @objc private func blockApp() {
        searchButton?.isHidden = true
        blockView?.isHidden = false
        pageControl?.isHidden = true
    }
    
    @objc private func unblockApp() {
        searchButton?.isHidden = false
        blockView?.isHidden = true
        pageControl?.isHidden = false
    }
    
    private func configurePageControl() {
        pageControl?.hidesForSinglePage = true
    }
}
