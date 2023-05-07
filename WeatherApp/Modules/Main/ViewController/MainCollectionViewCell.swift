//
//  MainCollectionViewCell.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "MainCollectionViewCell"
    
    @IBOutlet private weak var cityLabel: UILabel?
    @IBOutlet private weak var weekDayLabel: UILabel?
    @IBOutlet private weak var tempLabel: UILabel?
    @IBOutlet private weak var conditionLabel: UILabel?
    @IBOutlet private weak var humidityLabel: UILabel?
    @IBOutlet weak var imageView: UIImageView?
    
    func setup(with viewObject: WeatherCellViewObject) {
        cityLabel?.text = viewObject.cityName
        weekDayLabel?.text = viewObject.date
        tempLabel?.text = viewObject.temp
        conditionLabel?.text = viewObject.condition
        humidityLabel?.text = viewObject.humidity
        imageView?.image = UIImage(named: viewObject.image)
    }
}
