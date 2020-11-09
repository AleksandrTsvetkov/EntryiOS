//
//  ProfileDetailsViewController.swift
//  Party
//
//  Created by Александр Цветков on 05.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ProfileDetailsViewController: UIViewController {
    
    var profileFieldType: ProfileFieldType = .exit
    private let exitButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "exit"), for: .normal)
        return view
    }()
    private let label: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl()
        view.layer.cornerRadius = 10
        if #available(iOS 13.0, *) {
            view.layer.borderWidth = 0
        } else {
            view.layer.borderWidth = 1
        }
        view.layer.borderColor = Colors.unselectedSegment.getValue().cgColor
        view.layer.masksToBounds = true
        view.tintColor = Colors.selectedSegment.getValue()
        let normalFont = UIFont(name: "SFProText-Semibold", size: 13) ?? UIFont.systemFont(ofSize: 13)
        let selectedFont = UIFont(name: "SFProText-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13)
        view.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: normalFont], for: .normal)
        view.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: selectedFont], for: .selected)
        view.backgroundColor = Colors.unselectedSegment.getValue()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let buttonView = ButtonView(color: Colors.pink.getValue(), title: "Сохранить", left: 16, right: 16)
    private var isKeyboardShown = false
    private var phoneMaskService = PhoneMaskService()
    private var plainNumber = ""
    private lazy var picker = UIPickerView()
    private lazy var toolBar = UIToolbar()
    private var user: User = User(phoneNumber: "79210000000", firstName: "Иван", secondName: "Иванов", birthYear: "2000", birthMonth: "9", birthDay: "6", locationId: "1", password: "123456", email: "ivanov@gmail.com")
    private var cityOfUser: String = "Санкт-Петербург"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupViews()
        configureForType()
    }
    
    private func setup() {
        plainNumber = user.phoneNumber.filter{ "0123456789".contains($0)}
        tableView.showsVerticalScrollIndicator = false
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        tableView.isUserInteractionEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.reuseId)
        tableView.isScrollEnabled = false
    }
    
    private func setupViews() {
        let color = Colors.backgroundBlack.getValue()
        view.backgroundColor = color.withAlphaComponent(1)
        view.addSubview(exitButton)
        view.addSubview(label)
        view.addSubview(tableView)
        view.addSubview(buttonView)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonViewTapped))
        buttonView.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
            exitButton.widthAnchor.constraint(equalToConstant: 30),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 10),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 288),
            
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func presentPicker() {
        view.endEditing(true)
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = Colors.textFieldBackgroundResponder.getValue()
        picker.tintColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        view.addSubview(toolBar)
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))]
        picker.selectRow(PickerData.days.rawValue / 2, inComponent: 0, animated: false)
        picker.selectRow(PickerData.months.rawValue / 2, inComponent: 1, animated: false)
        picker.selectRow(PickerData.years.rawValue / 2, inComponent: 2, animated: false)
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            toolBar.heightAnchor.constraint(equalToConstant: 50),
            toolBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: picker.topAnchor)
        ])
    }
    
    private func configureForType() {
        switch profileFieldType {
        case .personalData:
            label.text = "Мои данные"
            segmentedControl.insertSegment(withTitle: "Парень", at: 0, animated: false)
            segmentedControl.insertSegment(withTitle: "Девушка", at: 1, animated: false)
            segmentedControl.selectedSegmentIndex = 1
            let tap = UITapGestureRecognizer(target: self, action: #selector(doneButtonTapped))
            view.addGestureRecognizer(tap)
            view.addSubview(segmentedControl)
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 32),
                
                segmentedControl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 41),
                segmentedControl.heightAnchor.constraint(equalToConstant: 32),
                segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ])
        case .paymentData:
            label.text = "Платежные\nданные"
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 2
            buttonView.changeIcon(newImageName: "cardIcon")
            buttonView.changeTitle(newTitle: "Добавить карту")
            buttonView.isHidden = false
            segmentedControl.insertSegment(withTitle: "Карта", at: 0, animated: false)
            segmentedControl.insertSegment(withTitle: "Счет", at: 1, animated: false)
            segmentedControl.selectedSegmentIndex = 1
            view.addSubview(segmentedControl)
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 24),
                
                segmentedControl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 41),
                segmentedControl.heightAnchor.constraint(equalToConstant: 32),
                segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ])
        case .contacts:
            label.text = "Контакты"
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 41),
            ])
        case .changePassword:
            label.text = "Изменить пароль"
            buttonView.isHidden = false
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 41),
            ])
        default:
            break
        }
    }
    
    @objc private func buttonViewTapped() {
        
    }
    
    @objc private func doneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    @objc private func exitButtonTapped() {
        view.endEditing(true)
        dismiss(animated: true)
    }
}

extension ProfileDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = smallScreen ? 77 : 96
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch profileFieldType {
        case .personalData:
            return 3
        case .paymentData:
            return 1
        case .contacts:
            return 2
        case .changePassword:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.reuseId, for: indexPath) as? ProfileCell else { return UITableViewCell() }
        cell.profileCellDelegate = self
        cell.configure(forUser: user, forType: profileFieldType, row: indexPath.row)
        return cell
    }
}

extension ProfileDetailsViewController: ProfileCellDelegate {
    func textFieldChanged() {
        var noChanges = true
        var notEmpty = true
        var noErrors = true
        switch profileFieldType {
        case .personalData:
            guard
                let nameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProfileCell,
                let cityCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? ProfileCell,
                let birthDateCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? ProfileCell,
                let birthMonth = Int(user.birthMonth),
                let name = nameCell.getTextField().text,
                let city = cityCell.getTextField().text,
                let birthDate = birthDateCell.getTextField().text
                else { return }
            let userName = "\(user.firstName) \(user.secondName)"
            let userBirthDate = "\(user.birthDay) \(PickerData.monthStringToNumber(number: birthMonth)) \(user.birthYear)"
            checkName(nameCell.getTextField())
            noChanges = (name == userName) && (city == cityOfUser) && (birthDate == userBirthDate)
            notEmpty = !name.isEmpty && !city.isEmpty && !birthDate.isEmpty
            noErrors = (nameCell.getTextField().errorMessage == nil || nameCell.getTextField().errorMessage == "") &&
                (cityCell.getTextField().errorMessage == nil || cityCell.getTextField().errorMessage == "") &&
                (birthDateCell.getTextField().errorMessage == nil || birthDateCell.getTextField().errorMessage == "")
        case .contacts:
            guard
                let phoneCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProfileCell,
                let emailCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? ProfileCell,
                let phone = phoneCell.getTextField().text,
                let email = emailCell.getTextField().text
                else { return }
            let userPhone = user.phoneNumber
            let userEmail = user.email
            let isEmail = email.isEmail()
            checkPhone(phoneCell.getTextField())
            emailCell.getTextField().errorMessage = (isEmail  || email.isEmpty) ? "" : "Неправильные символы".uppercased()
            noChanges = (userPhone == phone) && (userEmail == email)
            notEmpty = !phone.isEmpty && !email.isEmpty
            let noErrorMessages = (phoneCell.getTextField().errorMessage == nil || phoneCell.getTextField().errorMessage == "") &&
                (emailCell.getTextField().errorMessage == nil || emailCell.getTextField().errorMessage == "")
            let phoneIsCorrect = (plainNumber.starts(with: "7") && plainNumber.count == 11) || (!plainNumber.starts(with: "7") && plainNumber.count > 5)
            noErrors = noErrorMessages && phoneIsCorrect
        case .changePassword:
            guard
            let oldPasswordCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProfileCell,
            let firstPasswordCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? ProfileCell,
            let secondPasswordCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? ProfileCell,
            let oldPassword = oldPasswordCell.getTextField().text,
            let firstPassword = firstPasswordCell.getTextField().text,
            let secondPassword = secondPasswordCell.getTextField().text
            else { return }
            if firstPassword != secondPassword && !firstPassword.isEmpty && !secondPassword.isEmpty {
                firstPasswordCell.getTextField().errorMessage = "Пароли не совпадают"
                secondPasswordCell.getTextField().errorMessage = "Пароли не совпадают"
            } else {
                firstPasswordCell.getTextField().errorMessage = ""
                secondPasswordCell.getTextField().errorMessage = ""
            }
            notEmpty = !oldPassword.isEmpty && !firstPassword.isEmpty && !secondPassword.isEmpty
            noErrors = (oldPasswordCell.getTextField().errorMessage == nil || oldPasswordCell.getTextField().errorMessage == "") &&
                       (firstPasswordCell.getTextField().errorMessage == nil || firstPasswordCell.getTextField().errorMessage == "") &&
                       (secondPasswordCell.getTextField().errorMessage == nil || secondPasswordCell.getTextField().errorMessage == "")
        default:
            break
        }
        if noChanges || !noErrors || !notEmpty {
            hideButton()
        } else {
            showButton()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        if string == " " && text.count == 0 {
            return false
        }
        if text.contains(" ") && string == " " {
            return false
        }
        if profileFieldType == .contacts && textField.tag == 4 {
            return charReplacementForNumber(textField, shouldChangeCharactersIn: range, replacementString: string)
        }
        return true
    }
    
    private func checkName(_ textField: FloatingField) {
        let text = textField.text ?? ""
        var set = CharacterSet.letters
        set.insert(" ")
        var isValid = true
        for i in text {
            if String(i).rangeOfCharacter(from: set) == nil {
                isValid = false
            }
        }
        if !isValid && !text.isEmpty {
            textField.errorMessage = "Неправильные символы".uppercased()
        } else {
            textField.errorMessage = ""
        }
    }
    
    private func checkPhone(_ textField: FloatingField) {
        guard let text = textField.text else { return }
        textField.text = text.replacingOccurrences(of: " ", with: "")
        guard var currentText = textField.text else { return }
        currentText = currentText.filter{ "0123456789".contains($0)}
        if !currentText.isNumeric {
            textField.errorMessage = "НЕПРАВИЛЬНЫЙ НОМЕР".uppercased()
        } else {
            textField.errorMessage = ""
            plainNumber = currentText
            if plainNumber.first == "7" {
                phoneMaskService.originalNumber = plainNumber
                textField.text = phoneMaskService.visibleNumber
                let index = phoneMaskService.visibleNumber.distance(of: "_") ?? phoneMaskService.visibleNumber.count
                let position = textField.position(from: textField.beginningOfDocument, offset: index) ?? textField.beginningOfDocument
                textField.selectedTextRange = textField.textRange(from: position, to: position)
            } else {
                textField.text = "+" + plainNumber
            }
            if plainNumber.count > 11 {
                plainNumber.removeLast(plainNumber.count - 11)
            }
        }
    }
    
    private func charReplacementForNumber(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let floatingTextField = textField as? SkyFloatingLabelTextField else { return false }
        let text = floatingTextField.text ?? ""
        let noInsert0 = range.length > 1
        let noInsert1 = range.location > 1 && string.count > 1
        let noInsert2 = range.location == 0 && string.count > 1 && text.starts(with: "+")
        let noInsert3 = range.location == 1 && string.count > 1 && !text.starts(with: "+")
        if noInsert0 || noInsert1 || noInsert2 || noInsert3 {
            if text.starts(with: "+7") {
                let index = phoneMaskService.visibleNumber.distance(of: "_") ?? phoneMaskService.visibleNumber.count
                let position = floatingTextField.position(from: floatingTextField.beginningOfDocument, offset: index) ?? floatingTextField.beginningOfDocument
                floatingTextField.selectedTextRange = floatingTextField.textRange(from: position, to: position)
            } else {
                floatingTextField.selectedTextRange = floatingTextField.textRange(from: floatingTextField.endOfDocument, to: floatingTextField.endOfDocument)
            }
            return false
        }
        if range.location < 2 && string.count > 1 {
            plainNumber.append(string.filter{ "0123456789".contains($0)})
            if plainNumber.count > 11 {
                plainNumber.removeLast(plainNumber.count - 11)
            }
            if text.contains("(") || string.starts(with: "+7") {
                phoneMaskService.originalNumber = plainNumber
                floatingTextField.text = phoneMaskService.visibleNumber
                let index = phoneMaskService.visibleNumber.distance(of: "_") ?? phoneMaskService.visibleNumber.count
                let position = floatingTextField.position(from: floatingTextField.beginningOfDocument, offset: index) ?? floatingTextField.beginningOfDocument
                floatingTextField.selectedTextRange = floatingTextField.textRange(from: position, to: position)
            } else {
                floatingTextField.text = "+" + plainNumber
                floatingTextField.selectedTextRange = floatingTextField.textRange(from: floatingTextField.endOfDocument, to: floatingTextField.endOfDocument)
            }
            return false
        }
        if text.starts(with: "+_") && string.isEmpty {
            defer {
                let position = floatingTextField.position(from: floatingTextField.beginningOfDocument, offset: 1) ?? floatingTextField.beginningOfDocument
                floatingTextField.selectedTextRange = floatingTextField.textRange(from: position, to: position)
            }
            return false
        }
        if text == "" && !string.isEmpty {
            floatingTextField.text = "+"
            return true
        }
        if string.isEmpty {
            if plainNumber.first == "7" {
                plainNumber = String(plainNumber.dropLast())
                phoneMaskService.originalNumber = plainNumber
                floatingTextField.text = phoneMaskService.visibleNumber
                let index = phoneMaskService.visibleNumber.distance(of: "_") ?? phoneMaskService.visibleNumber.count
                defer {
                    let position = floatingTextField.position(from: floatingTextField.beginningOfDocument, offset: index) ?? floatingTextField.beginningOfDocument
                    floatingTextField.selectedTextRange = floatingTextField.textRange(from: position, to: position)
                }
                if plainNumber.isEmpty { floatingTextField.text = "+" + plainNumber }
                return false
            }
            plainNumber = String(plainNumber.dropLast())
            floatingTextField.text = "+" + plainNumber
            return false
        } else if floatingTextField.text?.count == 12 && !string.isEmpty{
            return false
        } else {
            return true
        }
    }
    
    func openPicker() {
        guard profileFieldType == .personalData else { return }
        presentPicker()
    }
    
    func openCities() {
        guard profileFieldType == .personalData else { return }
        let vc = CitiesViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func keyboardWillShow(row: Int) {
        doneButtonTapped()
        guard !isKeyboardShown else { return }
        var offsetY: CGFloat = 0
        switch row {
        case 0:
            return
        case 1:
            offsetY = smallScreen ? 50 : 50
        case 2:
            offsetY = smallScreen ? 130 : 90
        default:
            return
        }
        tableView.isScrollEnabled = true
        DispatchQueue.main.async {
            //self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 130, right: 0)
            self.tableView.contentOffset.y = offsetY
            self.tableView.isScrollEnabled = false
            self.isKeyboardShown = true
        }
    }
    
    func keyboardWillHide(row: Int) {
        DispatchQueue.main.async {
            self.tableView.isScrollEnabled = true
            //self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.tableView.contentOffset.y = 0
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self.tableView.isScrollEnabled = false
            self.isKeyboardShown = false
        }
    }
    
    func showButton() {
        buttonView.isHidden = false
    }
    
    func hideButton() {
        buttonView.isHidden = true
    }
}

extension ProfileDetailsViewController: CityPickerDelegate {
    func pickCity(city: String) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? ProfileCell else { return }
        cell.changeText(text: city)
        textFieldChanged()
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension ProfileDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return PickerData.days.rawValue
        case 1:
            return PickerData.months.rawValue
        case 2:
            return PickerData.years.rawValue
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? ProfileCell else { return }
        //cell.changeTitleColor(color: Colors.textFieldCorrect.getValue())
        let day = pickerView.selectedRow(inComponent: 0)
        let month = titleForMonthComponent(row: pickerView.selectedRow(inComponent: 1))
        let year = 2020 - pickerView.selectedRow(inComponent: 2)
        cell.changeText(text: "\(day) \(month) \(year)")
        textFieldChanged()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var string = ""
        switch component {
        case 0:
            string = "\(row)"
        case 1:
            string = titleForMonthComponent(row: row)
        case 2:
            string = "\(2020 - row)"
        default:
            string = ""
        }
        let attributedString = NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        return attributedString
    }
    
    private func titleForMonthComponent(row: Int) -> String {
        switch row {
        case 0:
            return "январь"
        case 1:
            return "февраль"
        case 2:
            return "март"
        case 3:
            return "апрель"
        case 4:
            return "май"
        case 5:
            return "июнь"
        case 6:
            return "июль"
        case 7:
            return "август"
        case 8:
            return "сентябрь"
        case 9:
            return "октябрь"
        case 10:
            return "ноябрь"
        case 11:
            return "декабрь"
        default:
            return ""
        }
    }
    
}
