//
//  TabBarVC.swift
//  TheFirebaseAuthenticationJourneyOfTheDaringDuck
//
//  Created by Cenker Soyak on 18.10.2023.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    func createUI(){
        
        let feedVC = FeedVC()
        let uploadVC = UploadVC()
        let settingsVC = SettingsVC()
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "list.dash"), tag: 0)
        uploadVC.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "square.and.arrow.up"), tag: 1)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        
        setViewControllers([feedVC, uploadVC, settingsVC], animated: true)
        tabBar.unselectedItemTintColor = .gray
        tabBar.itemPositioning = .fill
        tabBar.tintColor = .blue
        tabBar.backgroundColor = .white
        tabBar.window?.rootViewController = feedVC
    }
}
extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 0
        return sizeThatFits
    }
}
