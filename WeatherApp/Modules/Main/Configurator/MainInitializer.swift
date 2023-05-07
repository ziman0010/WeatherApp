//
//  MainInitializer.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import UIKit

final class MainInitializer: NSObject {
    
    @IBOutlet private weak var viewController: MainViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let configurator = MainConfigurator()
        configurator.configure(viewController: viewController)
    }
    
    static func controller() -> MainViewController? {
         
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? MainViewController else {
            return nil
        }
        
        let configurator = MainConfigurator()
        configurator.configure(viewController: viewController)
        
        return viewController
    }
}
