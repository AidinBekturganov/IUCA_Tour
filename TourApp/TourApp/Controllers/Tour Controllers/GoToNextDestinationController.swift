//
//  GoToNextDestinationController.swift
//  IUCA Tour
//
//  Created by User on 1/17/22.
//

import UIKit
import SideMenu

protocol GoNextDestinationDelegate: class {
    func handleMenuToggle()
}

class GoToNextDestinationController: UIViewController {
    //MARK: - Properties
    
    weak var delegate: GoNextDestinationDelegate?
    
    
    
    private let labelOne: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textColor = .black
        
        label.text = "Следуйте по пути к:"
        
        return label
    }()
    
    private let labelTwo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        label.textColor = .black
        
        
        label.text = "СТОЛОВОЙ"
        
        return label
    }()
    
    
    private let imageOfDestination: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFill
        
        iv.clipsToBounds = true
        return iv
    }()
    
    private let gotToPlace: UIButton = {
        let button = Utilities().createButton(withTitle: "Я УЖЕ ЗДЕСЬ",
                                              backgroundColor: .blueColorForButtons)
        
        button.addTarget(self, action: #selector(handleButtonIAmHere), for: .touchUpInside)
        
        
        
        return button
    }()
    
    private let shadowView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        
        return view
    }()
    
    
    
    
    private var nav: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let snackbarView = UIView()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Экскурсия"
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .iucaBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
    }
    
    //MARK: - Selectors
    
    @objc func handleButtonIAmHere() {
        let controller = UINavigationController(rootViewController: AudioPlayerController())
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    @objc func handleBurgerMenu() {
        let controller = MenuController(distance: self.calculateTopDistance())
        controller.delegate = self
        
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: controller)
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view, forMenu: SideMenuManager.PresentDirection(rawValue: 1)!)
        leftMenuNavigationController.statusBarEndAlpha = 0
        
        leftMenuNavigationController.presentationStyle = .menuSlideIn
        leftMenuNavigationController.leftSide = true
        leftMenuNavigationController.menuWidth = 300

        present(leftMenuNavigationController, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Helpers
    
    
    func configureUI() {
        view.backgroundColor = .white
        
        
        let sizeOfHeight = view.frame.height
        
        
        
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "burger menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleBurgerMenu))
//        touch.view.isUserInteractionEnabled = false
        let stack = UIStackView(arrangedSubviews: [labelOne, labelTwo])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.alignment = .center
        
        view.addSubview(stack)
        stack.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: sizeOfHeight * 0.05)
        
        view.addSubview(imageOfDestination)
        
        imageOfDestination.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 50)
        imageOfDestination.layer.cornerRadius = (sizeOfHeight / 2.4) / 2
        imageOfDestination.setDimensions(width: sizeOfHeight / 2.4, height: sizeOfHeight / 2.4)
        imageOfDestination.image = #imageLiteral(resourceName: "2018-09-28_11-33-21_165537 4")
        
        view.addSubview(gotToPlace)
        gotToPlace.anchor(top: imageOfDestination.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: sizeOfHeight / 11, paddingLeft: 16, paddingRight: 16)
        
    }
}

extension GoToNextDestinationController: SideMenuNavigationControllerDelegate {
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        self.navigationController?.view.isUserInteractionEnabled = false
        Utilities().hideShadowView(shadowView: snackbarView, completionHandler: {
            self.navigationController?.view.isUserInteractionEnabled = true

        })
    }
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        Utilities().setupViewToAnimate(shadowView: snackbarView, controllerView: self.view)
    }
}

extension GoToNextDestinationController: MenuControllerDelegate {
    func didTapFinishTour() {
        Utilities().configureActionSheet(navigationController: self.navigationController!)
    }
    
   
}

