//
//  QRScannerViewController.swift
//  IUCA Tour
//
//  Created by User on 2/1/22.
//

import UIKit

class QRScannerViewController: UIViewController {
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .iucaBlue
        
        navigationItem.title = "Изучение"
        
    }
}
