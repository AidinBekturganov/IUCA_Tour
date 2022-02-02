//
//  FeedController.swift
//  IUCA Tour
//
//  Created by User on 1/3/22.
//

import UIKit

class AboutController: UIViewController {
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "О МУЦА"
        
    }
}
