//
//  Utilities.swift
//  IUCA Tour
//
//  Created by User on 1/3/22.
//

import UIKit



class Utilities {
    
    let userDefaults = UserDefaults.standard
    
    
    func saveLangToTheMemory(lang: String) {
        userDefaults.setValue(lang, forKey: "Language")
        
    }
    
    func createButton(withTitle title: String, backgroundColor: UIColor, withImage: UIImage? = nil) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = backgroundColor
        
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 17)
        
        return button
    }
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        iv.image = image
        
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,
                  paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor,
                         right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,
                           right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }
    
    func setupViewToAnimate(shadowView: UIView, controllerView: UIView) {
        shadowView.isHidden = false
        controllerView.addSubview(shadowView)
        shadowView.addConstraintsToFillView(controllerView)
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        shadowView.frame.origin.x = controllerView.frame.height / 2
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0,
                       options: .curveEaseOut, animations: {
                        shadowView.alpha = 1
                       }, completion: {
                        _ in
                        
                       })
    }
    
    func hideShadowView(shadowView: UIView, completionHandler: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0,
                       options: .curveEaseIn, animations: {
                        shadowView.alpha = 0
                       }, completion: {
                        _ in
                        shadowView.isHidden = true
                        completionHandler()
                       })
    }
    
    func descriptionStackView(withText text: String, image: UIImage) -> UIStackView {
        let iv = UIImageView()
        let label = UILabel()
        label.text = text
        
        iv.setDimensions(width: 24, height: 24)
        
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        
        iv.image = image
        let stack = UIStackView(arrangedSubviews: [iv, label])
        
        stack.axis = .vertical
        stack.spacing = 11
//        stack.distribution = .fillEqually
      
        
        return stack
    }
    
    func getBackButtonDescription() {
        
    }
    
    func chooseLanguageButton(withImage imageForFlag: UIImageView, label: String) -> UIButton {
        let button = UIButton(type: .system)
        let imageForArrow = UIImageView()
        let labelUI = UILabel()
        
        labelUI.text = label
        
        labelUI.font = UIFont(name: "Roboto-Medium", size: 17)
        
        
        imageForFlag.setDimensions(width: 28, height: 28)
        
        
        button.addSubview(imageForFlag)
        imageForFlag.centerY(inView: button, leftAnchor: button.leftAnchor,
                             paddingLeft: 35)
        
        button.addSubview(labelUI)
        labelUI.centerY(inView: button, leftAnchor: imageForFlag.leftAnchor,
                        paddingLeft: 50)
        
        button.addSubview(imageForArrow)
        imageForArrow.centerY(inView: button, rightAnchor: button.rightAnchor,
                              paddingRight: 20)
        
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        
        imageForArrow.image = #imageLiteral(resourceName: "arrow")
        imageForArrow.setDimensions(width: 18, height: 14)
        
        return button
        
        
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return tf
    }
    
    func createCustomBarButton(buttonType: String) -> UIButton {
        
        let button = CustomUIButton()
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 9)
        label.textColor = .white
        label.textAlignment = .center
        
        if buttonType == "rus" {
            button.setImage(#imageLiteral(resourceName: "rus").withRenderingMode(.alwaysOriginal), for: .normal)
            label.text = "Язык"
            
        } else if buttonType == "eng" {
            button.setImage(#imageLiteral(resourceName: "flag").withRenderingMode(.alwaysOriginal), for: .normal)
            label.text = "Language"
            
        } else if buttonType == "kyr" {
            button.setImage(#imageLiteral(resourceName: "kyr").withRenderingMode(.alwaysOriginal), for: .normal)
            label.text = "Тил"
            
        } else if buttonType == "chin" {
            button.setImage(#imageLiteral(resourceName: "chin").withRenderingMode(.alwaysOriginal), for: .normal)
            label.text = "语言"
        }
        
        
        
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 42)
        
        
        button.addSubview(label)
        label.centerX(inView: button, topAnchor: button.bottomAnchor, paddingTop: 0)
        
        return button
    }
    
    func attributedButton (_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
    
    
    func configureActionSheet(navigationController: UINavigationController) {
        
        let text = """
                Вы действительно хотите
                завершить экскурсию?
            """
        
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        
        
        
        let sendButton = UIAlertAction(title: "Да, завершить", style: .destructive, handler: { (action) -> Void in
            DispatchQueue.main.async {
                print("Finish button tapped")
            }
            
        })
        
        let cancelButton = UIAlertAction(title: "Нет", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(sendButton)
        alertController.addAction(cancelButton)
        
        navigationController.present(alertController, animated: true, completion: nil)
        
    }
}
