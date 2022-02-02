//
//  ChooseTypeOfTourScreen.swift
//  IUCA Tour
//
//  Created by User on 1/11/22.
//

import UIKit

protocol ChooseTypeOfTourDelegate: class {
    func choosenLanguage(lang: String)
}

class ChooseTypeOfTourController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: ChooseTypeOfTourDelegate?
    
    
    private let personsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "SD")
        return iv
    }()
    
    private let chooseDurationOfTourLabel: UILabel = {
        let label = UILabel()
        
        label.text = """
        Выберите
        продолжительность
        экскурсии
        """
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Regular", size: 23)
        label.textColor = .black
        return label
    }()
    
    private let quickExcursionButton: UIButton = {
        let button = Utilities().createButton(withTitle: "Быстрая (10 минут)",
                                              backgroundColor: .blueColorForButtons)
        
        button.addTarget(self, action: #selector(handleGoToExcursionQuick), for: .touchUpInside)
        
        
        
        return button
    }()
    
    private let longExcursionButton: UIButton = {
        let button = Utilities().createButton(withTitle: "Подробная (30 минут)",
                                              backgroundColor: .blueColorForButtons)
        
        button.addTarget(self, action: #selector(handleGoToExcursionLong), for: .touchUpInside)
        
        
        
        return button
    }()
    
    private var lang: String
    
    private lazy var cusButton = Utilities().createCustomBarButton(buttonType: lang)
    
    private lazy var backBarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Vector-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Selectors
    
    @objc func handleGoToExcursionQuick() {
        let controller = TourDetailController(lang: lang)
        
        controller.delegate = self
        
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func handleGoToExcursionLong() {
        
    }
    
    @objc func handleChooseLanguageEngForBarButton() {
        DispatchQueue.main.async {
            let controller = SelectLanguageController()
            
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            
            
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    @objc func handleBackButton() {
        delegate?.choosenLanguage(lang: lang)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Lifecycle
    
    init(lang: String) {
        self.lang = lang
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBarButton()
        
    }
    
    //MARK: - Helpers
    
    func configureBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cusButton)
        cusButton.addTarget(self, action: #selector(handleChooseLanguageEngForBarButton), for: .touchUpInside)
        
    }
    
    func configureUI() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
        
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .iucaBlue
        
        navigationItem.title = "Экскурсия"
        
        view.addSubview(personsImageView)
        personsImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                                right: view.rightAnchor, paddingTop: view.safeAreaLayoutGuide.layoutFrame.height / 10,
                                paddingLeft: 10, paddingRight: 10, width: 370, height: 187)
        
        chooseDurationOfTourLabel.adjustsFontSizeToFitWidth = true
        chooseDurationOfTourLabel.minimumScaleFactor = 0.5
        
        
        let stack = UIStackView(arrangedSubviews: [quickExcursionButton, longExcursionButton])
        
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fillEqually
        
        
        
        
        
        let stackMain = UIStackView(arrangedSubviews: [chooseDurationOfTourLabel, stack])
        
        stackMain.axis = .vertical
        stackMain.spacing = 30
        
        view.addSubview(stackMain)
        stackMain.anchor(top: personsImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                         paddingTop: view.safeAreaLayoutGuide.layoutFrame.height / 10, paddingLeft: 10, paddingRight: 10)
        
        
    }
}

extension ChooseTypeOfTourController: SelectLanguageDelegate {
    func selectLang(lang: String) {
        dismiss(animated: true) {
            Utilities().saveLangToTheMemory(lang: lang)
            self.lang = lang
            self.cusButton = Utilities().createCustomBarButton(buttonType: lang)
            self.configureBarButton()
        }
        
    }
}

extension ChooseTypeOfTourController: TourDetailControlleDelegate {
    func choosenLanguage(lang: String) {
        self.lang = lang
        self.cusButton = Utilities().createCustomBarButton(buttonType: lang)
        self.configureBarButton()
    }
    
}
