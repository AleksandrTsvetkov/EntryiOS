//
//  ProfileViewController.swift
//  Party
//
//  Created by Александр Цветков on 30.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ProfileViewController: ViewController {
    
    var userState: UserState = .authorized
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .darkGray
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let label: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var exitView: TextView = {
        let view = TextView(ofType: .exit)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureStackView()
        if userState == .unauthorized { unauthorizedSetup() } else { authorizedSetup() }
    }
    
    private func setupViews() {
        view.backgroundColor = Colors.backgroundBlack.getValue()
        view.addSubview(label)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func authorizedSetup() {
        view.addSubview(profileImageView)
        view.addSubview(exitView)
        
        label.text = "Анна, 19 лет"
        label.textAlignment = .center
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tap)
        let profileHeightAndWidth: CGFloat = smallScreen ? 90 : 120
        profileImageView.layer.cornerRadius = profileHeightAndWidth / 2
        let stackViewLabelSpacing: CGFloat = smallScreen ? 24 : 37
        let profileTop: CGFloat = smallScreen ? 50 : 80
        
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: profileHeightAndWidth),
            profileImageView.widthAnchor.constraint(equalToConstant: profileHeightAndWidth),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: profileTop),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: stackViewLabelSpacing),
            
            exitView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            exitView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            exitView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
        ])
    }
    
    private func unauthorizedSetup() {
        label.text = "Профиль"
        label.textAlignment = .left
        
        let stackViewLabelSpacing: CGFloat = smallScreen ? 34 : 41
        let labelTopSpacing: CGFloat = smallScreen ? 52 : 71
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: stackViewLabelSpacing),
            
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: labelTopSpacing),
        ])
    }
    
    private func configureStackView() {
        switch userState {
        case .authorized:
            let textView0 = TextView(ofType: .personalData)
            textView0.delegate = self
            stackView.addArrangedSubview(textView0)
            let textView1 = TextView(ofType: .paymentData)
            textView1.delegate = self
            stackView.addArrangedSubview(textView1)
            let textView2 = TextView(ofType: .contacts)
            textView2.delegate = self
            stackView.addArrangedSubview(textView2)
            let textView3 = TextView(ofType: .changePassword)
            textView3.delegate = self
            stackView.addArrangedSubview(textView3)
        case .unauthorized:
            let textView0 = TextView(ofType: .phoneRegister)
            textView0.delegate = self
            stackView.addArrangedSubview(textView0)
            let textView1 = TextView(ofType: .loginPhone)
            textView1.delegate = self
            stackView.addArrangedSubview(textView1)
            let textView2 = TextView(ofType: .loginApple)
            textView2.delegate = self
            stackView.addArrangedSubview(textView2)
            let textView3 = TextView(ofType: .loginVK)
            textView3.delegate = self
            stackView.addArrangedSubview(textView3)
            let textView4 = TextView(ofType: .loginFacebook)
            textView4.delegate = self
            stackView.addArrangedSubview(textView4)
            let textView5 = TextView(ofType: .loginGoogle)
            textView5.delegate = self
            stackView.addArrangedSubview(textView5)
        }
    }
    
    @objc private func profileImageTapped() {
        let addPhotoAlertController = UIAlertController(title: "Какое фото добавить?", message: nil, preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Из галлереи", style: .default) { [weak self] _ in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self?.present(imagePickerController, animated: true)
        }
        let cameraAction = UIAlertAction(title: "С камеры", style: .default) { [weak self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = .camera
                self?.present(imagePickerController, animated: true)
            } else {
                let errorAlertController = UIAlertController(title: "Ошибка", message: "Камера недоступна", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ок", style: .default)
                errorAlertController.addAction(okAction)
                errorAlertController.removeNegativeWidthConstraints()
                self?.present(errorAlertController, animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        addPhotoAlertController.addAction(galleryAction)
        addPhotoAlertController.addAction(cameraAction)
        addPhotoAlertController.addAction(cancelAction)
        addPhotoAlertController.removeNegativeWidthConstraints()
        self.present(addPhotoAlertController, animated: true)
    }

    enum UserState {
        case authorized
        case unauthorized
    }
}

extension ProfileViewController: TextViewDelegate {
    func tapOnTextView(ofType type: ProfileFieldType) {
        let vc = ProfileDetailsViewController()
        //vc.modalPresentationStyle = .fullScreen
        vc.profileFieldType = type
        present(vc, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        profileImageView.image = image
    }
}
