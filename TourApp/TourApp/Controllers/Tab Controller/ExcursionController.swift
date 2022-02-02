//
//  ExcursionController.swift
//  IUCA Tour
//
//  Created by User on 1/3/22.
//

import UIKit

class ExcursionController: UIViewController {
    //MARK: - Properties
    
    private let actionSheet: ActionSheetLauncher
    
    private let labelHeaderOne: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        label.text = "ГЛАВНЫЙ КОРПУС МУЦА"
        return label
    }()
    
    private let labelSmallText: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.numberOfLines = 0
        
        label.text = """
                    Начните экскурсию,
                    чтобы познакомиться
                    с историей и атмосферой МУЦА!
                    """
        label.textAlignment = .center
        return label
    }()
    
    
    private let illustrationOfMandD: UIImageView = {
        let iv = UIImageView()
        
        iv.image = #imageLiteral(resourceName: "MandD")
        
        return iv
    }()
    
    private let startExcursionButton: UIButton = {
        let button = Utilities().createButton(withTitle: "ПЕРЕЙТИ К ЭКСКУРСИИ",
                                              backgroundColor: .blueColorForButtons)
        
        button.addTarget(self, action: #selector(handleGoToExcursion), for: .touchUpInside)
        
        
        
        return button
    }()
    
    
    
    
    private var lang: String
    
    private lazy var cusButton = Utilities().createCustomBarButton(buttonType: lang)
    
    private var sizeOfFrame: CGFloat = 0
    
    //MARK: - Lifecycle
    
    init(lang: String) {
        self.lang = lang
        self.actionSheet = ActionSheetLauncher()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureBarButtonItem()
        
    }
    
    //MARK: - Selectors
    
    @objc func handleChooseLanguageEngForBarButton() {
        DispatchQueue.main.async {
            
            let controller = SelectLanguageController()
            
            controller.delegate = self
            
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
        
    }
    
    @objc func handleGoToExcursion() {
        configureActionSheet()
    }
    
    //MARK: - Helpers
    
    
    
    func configureActionSheet() {
        
        let text = """
                Вы сейчас находитесь
                в главном корпусе МУЦА?
            """
        
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .actionSheet)
        
        
        
        let sendButton = UIAlertAction(title: "Да, я здесь", style: .default, handler: { (action) -> Void in
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: ChooseTypeOfTourController(lang: self.lang))
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            
        })
        
        let  deleteButton = UIAlertAction(title: "Нет, я удаленно", style: .default, handler: { (action) -> Void in
            print("Delete button tapped")
        })
        
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(sendButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func configureBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cusButton)
        cusButton.addTarget(self, action: #selector(handleChooseLanguageEngForBarButton), for: .touchUpInside)
    }
    
    func configureUI() {
        
        let controller = ChooseTypeOfTourController(lang: lang)
        controller.delegate = self
        
        sizeOfFrame = view.safeAreaLayoutGuide.layoutFrame.height
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .iucaBlue
        
        
        
        
        
        navigationItem.title = "Экскурсия"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        view.addSubview(labelHeaderOne)
        labelHeaderOne.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor,
                               paddingTop: sizeOfFrame / 13)
        
        view.addSubview(illustrationOfMandD)
        illustrationOfMandD.anchor(top: labelHeaderOne.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                   paddingTop: sizeOfFrame / 13, paddingLeft: 10, paddingRight: 10, width: 350, height: 200)
        
        view.addSubview(labelSmallText)
        labelSmallText.centerX(inView: view, topAnchor: illustrationOfMandD.bottomAnchor, paddingTop: sizeOfFrame / 14)
        
        view.addSubview(startExcursionButton)
        startExcursionButton.anchor(top: labelSmallText.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                    paddingTop: sizeOfFrame / 13, paddingLeft: 20, paddingRight: 20)
        
        
    }
}

extension ExcursionController: SelectLanguageDelegate {
    func selectLang(lang: String) {
        dismiss(animated: true) {
            Utilities().saveLangToTheMemory(lang: lang)
            self.lang = lang
            self.cusButton = Utilities().createCustomBarButton(buttonType: lang)
            self.configureBarButtonItem()
        }
        
    }
}

extension ExcursionController: ChooseTypeOfTourDelegate {
    func choosenLanguage(lang: String) {
        self.lang = lang
        self.cusButton = Utilities().createCustomBarButton(buttonType: lang)
        self.configureBarButtonItem()
    }
    
}

