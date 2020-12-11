//
//  ProfileCell.swift
//  Party
//
//  Created by Александр Цветков on 05.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    static let reuseId = "ProfileCell"
    
    //MARK: - Subviews
    private let textFieldView: TextFieldView = {
        let view = TextFieldView(text: "", placeholder: "")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var editImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "editButton")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Properties
    var profileCellDelegate: ProfileCellDelegate?
    private var cellType: ProfileFieldType = .exit
    private var cellRow = 0
    private let phoneMaskService = PhoneMaskService()
    
    //MARK: - Reuse
    func configure(forUser user: UserRequest, forType type: ProfileFieldType, row: Int) {
        cellRow = row
        cellType = type
        isUserInteractionEnabled = true
        backgroundColor = .clear
        selectionStyle = .none
        
        setupTextFieldView(forType: type, row: row)
        textFieldView.floatingTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        var placeHolder = ""
        switch type {
        case .personalData:
            var text = ""
            switch row {
            case 0:
                placeHolder = "Имя"
                text = "\(user.firstName) \(user.secondName)"
                textFieldView.floatingTextField.tag = 0
            case 1:
                textFieldView.floatingTextField.isUserInteractionEnabled = false
                placeHolder = "Город"
                text = "Санкт-Петербург"
                let tap = UITapGestureRecognizer(target: self, action: #selector(openCities))
                textFieldView.addGestureRecognizer(tap)
                textFieldView.floatingTextField.tag = 1
            case 2:
                textFieldView.floatingTextField.isUserInteractionEnabled = false
                placeHolder = "Дата рождения"
                let tap = UITapGestureRecognizer(target: self, action: #selector(openPicker))
                textFieldView.addGestureRecognizer(tap)
                textFieldView.floatingTextField.tag = 2
                guard let birthMonth = Int(user.birthMonth) else { return }
                text = "\(user.birthDay) \(PickerData.monthNumberToString(number: birthMonth)) \(user.birthYear)"
            default:
                break
            }
            textFieldView.floatingTextField.text = text
            addEditImage()
        case .paymentData:
            placeHolder = "Номер карты"
            textFieldView.floatingTextField.text = "1234 4567 7890 0123"
            textFieldView.floatingTextField.tag = 3
            addEditImage()
        case .contacts:
            var text = ""
            switch row {
            case 0:
                phoneMaskService.originalNumber = user.phoneNumber
                text = phoneMaskService.visibleNumber
                placeHolder = "Номер телефона"
                textFieldView.configure(withKeyboardType: .namePhonePad, textContentType: .telephoneNumber)
                textFieldView.floatingTextField.tag = 4
            case 1:
                text = user.email
                placeHolder = "E-mail"
                textFieldView.floatingTextField.tag = 5
            default:
                break
            }
            textFieldView.floatingTextField.text = text
            addEditImage()
        case .changePassword:
            switch row {
            case 0:
                placeHolder = "Старый пароль"
                textFieldView.floatingTextField.tag = 6
            case 1:
                placeHolder = "Новый пароль"
                textFieldView.floatingTextField.tag = 7
            case 2:
                placeHolder = "Новый пароль (еще раз)"
                textFieldView.floatingTextField.tag = 8
            default:
                break
            }
            textFieldView.floatingTextField.isSecureTextEntry = true
        default:
            break
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        textFieldView.setPlaceholder(placeholder: placeHolder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Setup
    private func setupTextFieldView(forType type: ProfileFieldType, row: Int) {
        textFieldView.floatingTextField.selectedTitleColor = Colors.gray.getValue()
        textFieldView.floatingTextField.onProfileScreen = true
        textFieldView.setBackgroundColor(color: Colors.textFieldBackgroundResponder.getValue())
        textFieldView.floatingTextField.delegate = profileCellDelegate
        textFieldView.floatingTextField.placeholderFont = UIFont(name: "SFProText-Regular", size: 15)
        textFieldView.floatingTextField.titleFont = UIFont(name: "SFProText-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
        addSubview(textFieldView)
        
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: self.topAnchor),
            textFieldView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            textFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func addEditImage() {
        addSubview(editImage)
        //editImage.addTarget(self, action: #selector(editImageTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            editImage.heightAnchor.constraint(equalToConstant: 19),
            editImage.widthAnchor.constraint(equalToConstant: 19),
            editImage.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -14),
            editImage.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -15),
        ])
    }
    
    //MARK: - External methods
    func getTextField() -> FloatingField {
        return textFieldView.floatingTextField
    }
    
    func changeText(text: String) {
        textFieldView.floatingTextField.text = text
    }
    
    func changeTitleColor(color: UIColor) {
        textFieldView.floatingTextField.titleColor = color
    }
    
    //MARK: - Objc methods
    @objc private func openPicker() {
        profileCellDelegate?.openPicker()
    }
    
    @objc private func openCities() {
        profileCellDelegate?.openCities()
    }
    
    @objc private func textFieldChanged() {
        profileCellDelegate?.textFieldChanged()
    }
    
    @objc private func keyboardWillShow() {
        if let _ = self.firstResponder{
            profileCellDelegate?.keyboardWillShow(row: cellRow)
        }
    }
    
    @objc private func keyboardWillHide() {
        profileCellDelegate?.keyboardWillHide(row: cellRow)
    }
    
    @objc private func editImageTapped() {
        print("asdasd")
    }
}
