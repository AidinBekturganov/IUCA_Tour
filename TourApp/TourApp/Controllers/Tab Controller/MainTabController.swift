//
//  MainTabController.swift
//  IUCA Tour
//
//  Created by User on 1/3/22.
//

import UIKit

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    let userDefaults = UserDefaults.standard
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(actionButtonTaped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = userDefaults.object(forKey: "Language") as? String ?? ""
        
        checkIfLanguageIsSelected(lang: value)
        
    }
    
    //MARK: - Selectors
    
    @objc func actionButtonTaped() {
        print("123")
    }
    
    //MARK: - Helpers
    
    func checkIfLanguageIsSelected(lang: String) -> Bool {
        if lang != "" {
            userDefaults.setValue(lang, forKey: "Language")
        }
        
        let value = userDefaults.object(forKey: "Language") as? String ?? ""
        
        if value == "" {
            
            DispatchQueue.main.async {
                
                let controller = SelectLanguageController()
                
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewController(lan: value)
            return true
        }
        return false
        
    }
    
    func configureViewController(lan: String) {
        
        let about = AboutController()
        let nav1 = templateNavigationController(image: UIImage(named: "1")?.withTintColor(.black),
                                                title: "О МУЦА", rootViewController: about)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "3")?.withTintColor(.black),
                                                title: "ИЗУЧЕНИЕ", rootViewController: explore)
        
        
        let excursion = ExcursionController(lang: lan)
        let nav3 = templateNavigationController(image: UIImage(named: "2")?.withTintColor(.black),
                                                title: "ЭКСКУРСИЯ", rootViewController: excursion)
        
        viewControllers = [nav1, nav3, nav2]
        
        self.selectedIndex = 1
        
    }
    
    
    func templateNavigationController(image: UIImage?, title: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.image = image
        nav.tabBarItem.selectedImage = image?.withTintColor(.iucaBlue)
        nav.tabBarController?.tabBar.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,
                                            right: view.rightAnchor, height: 200)
        
        nav.navigationBar.barTintColor = .white
        nav.tabBarItem.title = title
        return nav
        
    }
}


