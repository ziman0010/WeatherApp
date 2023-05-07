//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import UIKit

protocol MainDisplayLogic: AnyObject {
    func set(viewObject: WeatherCellViewObject)
}

final class MainViewController: UIViewController,
                                MainDisplayLogic,
                                UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout {
    
    var interactor: MainBuisnessLogic?
    
    @IBOutlet private weak var pageControl: UIPageControl?
    @IBOutlet private weak var collectionView: UICollectionView?
    @IBOutlet private weak var gradientView: GradientView?
    
    private var dataSource: [WeatherCellViewObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        interactor?.getCurrentWeather()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("add"), object: nil)
    }
    
    @IBAction func didTapSearch(_ sender: Any) {
        let controller = SearchInitializer.controller() { [weak self] weather in
            self?.interactor?.addWeather(weather: weather)
        }
        
        guard let controller = controller else {
            return
        }
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem?.tintColor = .white
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func set(viewObject: WeatherCellViewObject) {
        dataSource.append(viewObject)
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseId, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(with: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        pageControl?.numberOfPages = dataSource.count
        pageControl?.isHidden = !(dataSource.count > 1)
        
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let gradientColor = dataSource[indexPath.row].gradientColor
        gradientView?.startColor = UIColor(named: gradientColor.0)
        gradientView?.endColor = UIColor(named: gradientColor.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    private func configureCollectionView() {
        collectionView?.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MainCollectionViewCell.reuseId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
}
