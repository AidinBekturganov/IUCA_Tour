//
//  SelectLanguageController.swift
//  IUCA Tour
//
//  Created by User on 1/7/22.
//

import UIKit

protocol SelectLanguageDelegate: class {
    func selectLang(lang: String)
}

class SelectLanguageController: UIViewController {
    //MARK: - Properties
    
    weak var delegate: SelectLanguageDelegate?
    
    private lazy var pictureContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .iucaBlue
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        view.addSubview(wavesImageView)
        wavesImageView.anchor(top: view.topAnchor, left: view.leftAnchor,
                              paddingTop: 50, width: 112, height: 42)
        
        view.addSubview(personImageView)
        personImageView.anchor(bottom: view.bottomAnchor, right: view.rightAnchor,
                               width: 154, height: 126)
        
        view.addSubview(chooseLanguageLabel)
        chooseLanguageLabel.centerX(inView: view, topAnchor: view.topAnchor,
                                    paddingTop: 100)
        
        return view
    }()
    
    private let chooseLanguageLabel: UILabel = {
        let label = UILabel()
        
        label.text = """
        Select language
        Тилди танданыз
        Выберите язык
        选择语言
        """
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Regular", size: 23)
        label.textColor = .white
        return label
    }()
    
    private let wavesImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "Lines 1-1")
        return iv
    }()
    
    private let personImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "Aza 1-1")
        return iv
    }()
    
    private let englishLanguageButton: UIButton = {
        
        let imageForFlag = UIImageView()
        let imageForArrow = UIImageView()
        let label = "ENGLISH LANGUAGE"
        
        imageForFlag.image = #imageLiteral(resourceName: "flag")
        
        let button = Utilities().chooseLanguageButton(withImage: imageForFlag, label: label)
        
        button.addTarget(self, action: #selector(handleChooseLanguageEng), for: .touchUpInside)
        
        return button
    }()
    
    private let kyrgyzLanguageButton: UIButton = {
        
        let imageForFlag = UIImageView()
        let imageForArrow = UIImageView()
        let label = "КЫРГЫЗ ТИЛИ"
        
        imageForFlag.image = #imageLiteral(resourceName: "kyr")
        
        let button = Utilities().chooseLanguageButton(withImage: imageForFlag, label: label)
        
        button.addTarget(self, action: #selector(handleChooseLanguageKyr), for: .touchUpInside)
        
        return button
    }()
    
    private let russianLanguageButton: UIButton = {
        
        let imageForFlag = UIImageView()
        let imageForArrow = UIImageView()
        let label = "РУССКИЙ ЯЗЫК"
        
        imageForFlag.image = #imageLiteral(resourceName: "rus")
        
        let button = Utilities().chooseLanguageButton(withImage: imageForFlag, label: label)
        
        button.addTarget(self, action: #selector(handleChooseLanguageRus), for: .touchUpInside)
        
        return button
    }()
    
    private let chineseLanguageButton: UIButton = {
        
        let imageForFlag = UIImageView()
        let imageForArrow = UIImageView()
        let label = "中文"
        
        imageForFlag.image = #imageLiteral(resourceName: "chin")
        
        let button = Utilities().chooseLanguageButton(withImage: imageForFlag, label: label)
        
        button.addTarget(self, action: #selector(handleChooseLanguageChin), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        
        
    }
    
    //MARK: - Selectors
    
    @objc func handleChooseLanguageEng() {
        updateMainTabController(lang: "eng")
    }
    
    @objc func handleChooseLanguageKyr() {
        updateMainTabController(lang: "kyr")
    }
    
    @objc func handleChooseLanguageRus() {
        updateMainTabController(lang: "rus")
    }
    
    @objc func handleChooseLanguageChin() {
        updateMainTabController(lang: "chin")
    }
    
    //MARK: - Helpers
    
    func updateMainTabController(lang: String) {
        
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        guard let tab = window.rootViewController as? MainTabController else { return }
        
        if tab.checkIfLanguageIsSelected(lang: lang) {
            delegate?.selectLang(lang: lang)
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func configureUI() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.rgb(red: 154, green: 178, blue: 227)
        
        view.addSubview(pictureContainerView)
        
        pictureContainerView.anchor(top: view.topAnchor, left: view.leftAnchor,
                                    right: view.rightAnchor, height: 300)
        
        
        let stack = UIStackView(arrangedSubviews: [englishLanguageButton, kyrgyzLanguageButton,
                                                   russianLanguageButton, chineseLanguageButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: pictureContainerView.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)
        
        navigationItem.title = "Экскурсия"
        
    }
}
