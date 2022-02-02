//
//  AudioPlayerController.swift
//  IUCA Tour
//
//  Created by User on 1/21/22.
//

import UIKit
import SideMenu

class AudioPlayerController: UIViewController {
    
    //MARK: - Properties
    
    private let snackbarView = UIView()
    
    private let slider = ImageSlider()
    
    private var expandViewHeightConstraint: NSLayoutConstraint?
    private var expandViewTopConstraint: NSLayoutConstraint?

    private var textViewHeightConstraint: NSLayoutConstraint?
    
    private var textViewBottomConstraint: NSLayoutConstraint?
    
    lazy var expandableViewFullHeight: CGFloat = {
        self.view.frame.height - self.calculateTopDistance()
    }()
    
    lazy var textViewFullHeight: CGFloat = {
        self.expandableViewFullHeight - self.headerOne.frame.height - self.nextDestinationButton.frame.height - 72
    }()
    
   
    lazy var textViewShortHeight: CGFloat = {
        return self.expandableViewHalfHeight*0.6
    }()
    
    lazy var expandableViewHalfHeight: CGFloat = {
        self.view.frame.height * 0.49
    }()
    
    private let expandableView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private let expandButton: UIButton = {
        let button = UIButton()
        
        button.setImage(#imageLiteral(resourceName: "Expand").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleExpand), for: .touchUpInside)
        
        
        return button
    }()
    
    private let headerOne: UILabel = {
        let label = UILabel()
        
        label.text = "ПРИХОЖАЯ"
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.textColor = .black
        
        return label
    }()
    
    private var textView: UITextView = {
        let textView = UITextView()
        
        textView.font = UIFont(name: "Roboto-Regular", size: 14)
        textView.textColor = .black
        textView.backgroundColor = .white
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.bounces = false
        textView.isSelectable = false
        
        return textView
    }()
    
    private let nextDestinationButton: UIButton = {
        let button = Utilities().createButton(withTitle: "СЛЕДУЮЩАЯ ОСТАНОВКА",
                                              backgroundColor: .blueColorForButtons)
        
        button.addTarget(self, action: #selector(handleButtonNextDestination), for: .touchUpInside)
        
        return button
    }()
    
    private let viewForAudioPlayer: UIView = {
        let view = UIView()
        view.backgroundColor = .iucaBlue
        
        return view
    }()
    
    private let skipNextFifteenSecondsButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(#imageLiteral(resourceName: "Artboard 1").withRenderingMode(.alwaysOriginal), for: .normal)
        
        button.addTarget(self, action: #selector(handleButtonNextDestination), for: .touchUpInside)
        
        return button
    }()
    
    private let rollBackNextFifteenSecondsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Artboard 1-2").withRenderingMode(.alwaysOriginal), for: .normal)
        
        button.addTarget(self, action: #selector(handleButtonNextDestination), for: .touchUpInside)
        
        return button
    }()
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Artboard 1-1").withRenderingMode(.alwaysOriginal), for: .normal)
      

        button.addTarget(self, action: #selector(handleButtonNextDestination), for: .touchUpInside)
        
        return button
    }()
    
    private let timeSlider: UISlider = {
        let slider = UISlider()
        
        return slider
    }()
    
    private let labelForTimeBeggining: UILabel = {
        let label = UILabel()
        
        label.text = "00:30"
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.textColor = .white
        
        return label
    }()

    private let labelForTimeEnd: UILabel = {
        let label = UILabel()
        
        label.text = "00:59"
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.textColor = .white
        
        return label
    }()
    
    private let text = """
                        Совершите экскурсию, чтобы познакомиться с историей и реальной атмосферой кампуса LUCIA.

                        Совершите экскурсию, чтобы познакомиться с историей и реальной атмосферой кампуса LUCIA.
                        чсбчждсбчдсьдчяьмдчлсмтлдстмлст

                        Совершите экскурсию, чтобы познакомиться с историей и реальной атмосферой кампуса LUCIA.

                        Совершите экскурсию, чтобы познакомиться с историей и реальной атмосферой кампуса LUCIA.
                        чсбчждсбчдсьдчяьмдчлсмтлдстмлст
                        Совершите экскурсию, чтобы познакомиться с историей и реальной атмосферой кампуса LUCIA.

                        Совершите экскурсию, чтобы познакомиться с историей и реальной атмосферой кампуса LUCIA.
                        чсбчждсбчдсьдчяьмдчлсмтлдстмлст

                        Совершите экскурсию, чтобы познакомиться с историей и реальной атмосферой кампуса LUCIA.

                        Совершите экскурсию, чтобы познакомиться с историей и реальной атмосферой кампуса LUCIA.
                        чсбчждсбчдсьдчяьмдчлсмтлдстмлст
                        Совершите экскурсию, чтобы познакомиться с историей и реальной атмосферой кампуса LUCIA.

                        Совершите экскурсию, чтобы познакомиться с историей и реальной атмосферой кампуса LUCIA.
                        чсбчждсбчдсьдчяьмдчлсмтлдстмлст

                        Совершите экскурсию, чтобы познакомиться с историей и реальной атмосферой кампуса LUCIA.

                        Совершите экскурсию, чтобы познакомиться с историей и реальной атмосферой кампуса LUCIA.
                        чсбчждсбчдсьдчяьмдчлсмтлдстмлст
                       """
    
    private var isExpanded: Bool = false
    
    lazy var heightOfViewForAudio: CGFloat = {
        self.viewForAudioPlayer.frame.height
    }()
    
    lazy var heightOfViewForAudio1: CGFloat = 0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavBar()
        configureExpandableView()
        configureAudioPlayer()
    }
    
    //MARK: - Selectors
    
    @objc func handleButtonNextDestination() {
        
    }
    
    @objc func handleExpand() {
        
        if isExpanded {
            hideAnimate()
            isExpanded = !isExpanded
        } else {
            expandAnimate()
            isExpanded = !isExpanded
        }
    }
    
    @objc func handleBurgerMenu() {
        let controller = MenuController(distance: self.calculateTopDistance())
        controller.delegate = self

        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: controller)
        
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view,
                                                                  forMenu: SideMenuManager.PresentDirection(rawValue: 1)!)
        
        leftMenuNavigationController.statusBarEndAlpha = 0
        
        leftMenuNavigationController.presentationStyle = .menuSlideIn
        leftMenuNavigationController.leftSide = true
        leftMenuNavigationController.menuWidth = 300
        
        

        present(leftMenuNavigationController, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Helpers
    
    
    private func expandAnimate() {
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.textView.isScrollEnabled = true

            self.textViewHeightConstraint?.constant = self.textViewFullHeight
            
            self.expandViewTopConstraint?.isActive = false

            
            self.expandViewTopConstraint = NSLayoutConstraint.init(item: self.expandableView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.topMargin, multiplier: 1.0, constant: 0)
                    
            self.expandViewTopConstraint?.isActive = true

            
            self.view.layoutIfNeeded()
        })
    }
    
    private func hideAnimate() {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.textView.isScrollEnabled = false
            
            self.textViewHeightConstraint?.constant = self.textViewShortHeight
            
            self.expandViewTopConstraint?.isActive = false

            
            self.expandViewTopConstraint = NSLayoutConstraint.init(item: self.expandableView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.viewForAudioPlayer, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0)
                    
            self.expandViewTopConstraint?.isActive = true

            
            self.view.layoutIfNeeded()
        })
    }
    
    
    func configureNavBar() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .iucaBlue
        
        navigationItem.title = "Прихожая"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "burger menu").withRenderingMode(.alwaysOriginal),
                                                           style: .plain, target: self, action: #selector(handleBurgerMenu))
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(slider)
        slider.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                      right: view.rightAnchor, height: view.frame.height * 0.26)
        
        view.addSubview(viewForAudioPlayer)
        viewForAudioPlayer.anchor(top: slider.bottomAnchor, left: view.leftAnchor,
                                  right: view.rightAnchor, height: 110)
        heightOfViewForAudio1 = viewForAudioPlayer.frame.height
        
 
    }
    
    
    func configureExpandableView() {
        view.addSubview(expandableView)
        expandableView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        expandableView.translatesAutoresizingMaskIntoConstraints = false

        expandViewTopConstraint = NSLayoutConstraint.init(item: expandableView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewForAudioPlayer, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0)
                
        expandViewTopConstraint?.isActive = true

        expandableView.addSubview(expandButton)
        expandButton.anchor(top: expandableView.topAnchor, right: expandableView.rightAnchor,
                            paddingTop: 19, paddingRight: 47, width: 24, height: 24)
        
        expandableView.addSubview(headerOne)
        headerOne.centerX(inView: expandableView, topAnchor: expandableView.topAnchor, paddingTop: 22)
        
        let stack = UIStackView(arrangedSubviews: [textView, nextDestinationButton])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        
        expandableView.addSubview(stack)
        stack.anchor(top: headerOne.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor,
                     right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingBottom: 20,
                     paddingRight: 16)
        
        textView.text = text
    }
    
    private func configureAudioPlayer() {
        let stack = UIStackView(arrangedSubviews: [rollBackNextFifteenSecondsButton, playButton, skipNextFifteenSecondsButton])

        stack.distribution = .fill
        stack.spacing = 30
        stack.axis = .horizontal
        
        viewForAudioPlayer.addSubview(timeSlider)
        timeSlider.anchor(top: viewForAudioPlayer.topAnchor, left: viewForAudioPlayer.leftAnchor, right: viewForAudioPlayer.rightAnchor, paddingTop: 10, paddingLeft: 17, paddingRight: 17)
        
        timeSlider.heightAnchor.constraint(equalToConstant: 17).isActive = true
        timeSlider.setThumbImage(#imageLiteral(resourceName: "Ellipse 17"), for: .normal)
        timeSlider.setThumbImage(#imageLiteral(resourceName: "Ellipse 17"), for: .highlighted)
        timeSlider.minimumTrackTintColor = .white
        timeSlider.maximumTrackTintColor = UIColor.rgb(red: 124, green: 156, blue: 219)

        viewForAudioPlayer.addSubview(stack)
        stack.centerX(inView: timeSlider, topAnchor: timeSlider.bottomAnchor, paddingTop: ((view.frame.height * 0.5) * 0.02)-3)
 
        viewForAudioPlayer.addSubview(labelForTimeBeggining)
        labelForTimeBeggining.anchor(top: timeSlider.bottomAnchor, left: view.leftAnchor, paddingLeft: 17)
        
        viewForAudioPlayer.addSubview(labelForTimeEnd)
        labelForTimeEnd.anchor(top: timeSlider.bottomAnchor, right: view.rightAnchor, paddingRight: 17)
    }
    
    
    
}


extension AudioPlayerController: SideMenuNavigationControllerDelegate {
    
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

class CustomSlider: UISlider {
   
       override func trackRect(forBounds bounds: CGRect) -> CGRect {
           let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 5.0))
           super.trackRect(forBounds: customBounds)
           return customBounds
       }
   
   }


extension AudioPlayerController: MenuControllerDelegate {
    func didTapFinishTour() {
        Utilities().configureActionSheet(navigationController: self.navigationController!)
    }
    
   
}
