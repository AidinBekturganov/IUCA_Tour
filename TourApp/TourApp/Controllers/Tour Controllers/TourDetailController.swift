//
//  TourDetailController.swift
//  IUCA Tour
//
//  Created by User on 1/15/22.
//


import UIKit
import SideMenu

protocol TourDetailControlleDelegate: class {
    func choosenLanguage(lang: String)
}

private let reuseIdentifier = "ImageCell"

class TourDetailController: UIViewController {
    //MARK: - Properties
    
    let slider = ImageSlider()
    
    weak var delegate: TourDetailControlleDelegate?
    
    
    let stopList = StopList()
    
    lazy var collectionViewForImages: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    private var stack = Utilities().descriptionStackView(withText: "1-2", image: #imageLiteral(resourceName: "flag"))
    
    private let labelForDistance: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        
        label.text = "1-2 км"
       

        return label
    }()
    
    private let labelTimeOfTour: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.text = "10 мин"
        
        return label
    }()
    
    private let labelTimeOfAudio: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.text = "5 мин"

        return label
    }()
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        label.text = "ОПИСАНИЕ ВАШЕЙ ЭКСКУРСИИ"

        return label
    }()
    
    private let imageOfDistance: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "123")
        return iv
    }()
    
    private let imageOfTimeTour: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Asset 1")

        return iv
    }()
    
    private let imageOfTimeAudio: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Asset 2")

        return iv
    }()
    
    private let mapImageView: UIImageView = {
        let iv = UIImageView()
        
        iv.image = #imageLiteral(resourceName: "image 3")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private let secondLabelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        label.text = "ОПИСАНИЕ ВАШЕЙ ЭКСКУРСИИ"

        return label
    }()
    
    private let startExcursionButton: UIButton = {
        let button = Utilities().createButton(withTitle: "НАЧАТЬ ЭКСКУРСИЮ",
                                              backgroundColor: .blueColorForButtons)
        
        button.addTarget(self, action: #selector(handleStartToExcursion), for: .touchUpInside)
        
        
        
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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBarButton()
    }
    
    init(lang: String) {
        self.lang = lang
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleStartToExcursion() {
       
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: GoToNextDestinationController())
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        
                
        let nav = UINavigationController(rootViewController: GoToNextDestinationController())
        
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
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
    
    //MARK: - Helpers
    
    func configureBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cusButton)
        cusButton.addTarget(self, action: #selector(handleChooseLanguageEngForBarButton), for: .touchUpInside)
        
    }
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        navigationItem.title = "О МУЦА"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)

        
        view.addSubview(slider)
        slider.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                      right: view.rightAnchor, width: view.frame.width, height: view.frame.height * 0.26)
     
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .iucaBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        navigationItem.title = "Экскурсия"


        let stackForDistance = UIStackView(arrangedSubviews: [imageOfDistance, labelForDistance])
        stackForDistance.axis = .horizontal
        stackForDistance.spacing = 11
        stackForDistance.distribution = .fill
        
        let stackForTimeOfTour = UIStackView(arrangedSubviews: [imageOfTimeTour, labelTimeOfTour])
        stackForTimeOfTour.axis = .horizontal
        stackForTimeOfTour.spacing = 11
        stackForTimeOfTour.distribution = .fill

        let stackForAudioTime = UIStackView(arrangedSubviews: [imageOfTimeAudio, labelTimeOfAudio])
        stackForAudioTime.axis = .horizontal
        stackForAudioTime.spacing = 11
        stackForAudioTime.distribution = .fill

        let stack = UIStackView(arrangedSubviews: [stackForDistance, stackForTimeOfTour, stackForAudioTime])
        stack.axis = .horizontal
        stack.spacing = 45
        stack.distribution = .fillProportionally
        
        view.addSubview(labelTitle)
        labelTitle.centerX(inView: view, topAnchor: slider.bottomAnchor, paddingTop: 10)
        
        view.addSubview(stack)
        stack.centerX(inView: view, topAnchor: labelTitle.bottomAnchor, paddingTop: 12)
        
        view.addSubview(mapImageView)
        mapImageView.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, height: view.frame.height / 5)
        
        view.addSubview(secondLabelTitle)
        secondLabelTitle.centerX(inView: view, topAnchor: mapImageView.bottomAnchor, paddingTop: 10)
        
        view.addSubview(stopList)
        stopList.anchor(top: secondLabelTitle.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, height: view.frame.height / 6)
        
        view.addSubview(startExcursionButton)
        startExcursionButton.anchor(top: stopList.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 16, paddingRight: 16)
    }
}

extension TourDetailController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageSliderCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
}

extension TourDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension TourDetailController: UICollectionViewDelegate {
    
}


extension TourDetailController: SelectLanguageDelegate {
    func selectLang(lang: String) {
        dismiss(animated: true) {
            Utilities().saveLangToTheMemory(lang: lang)
            self.lang = lang
            self.cusButton = Utilities().createCustomBarButton(buttonType: lang)
            self.configureBarButton()
        }
        
    }
}
