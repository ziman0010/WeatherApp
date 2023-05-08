//
//  SearchInitializer.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import UIKit

final class SearchInitializer: NSObject {
    
    @IBOutlet private weak var viewController: SearchViewController!
    
    static func controller(onAddAction: @escaping ((Float, Float) -> Void)) -> SearchViewController? {
         
        let storyboardName = "Search"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? SearchViewController else {
            return nil
        }
        
        let configurator = SearchConfigurator()
        configurator.configure(viewController: viewController, onAddAction: onAddAction)
        
        return viewController
    }
}
