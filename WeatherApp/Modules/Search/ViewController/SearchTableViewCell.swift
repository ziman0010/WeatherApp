//
//  SearchTableViewCell.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    static let reuseId = "SearchTableViewCell"
    
    var onTap: (() -> Void)?
    
    @IBOutlet weak var nameLabel: UILabel?
    
    @IBAction func didTapAddButton(_ sender: Any) {
        onTap?()
    }
    
    func setup(with item: SearchItem, onTap: @escaping (() -> Void)) {
        nameLabel?.text = item.name
        self.onTap = onTap
    }
}
