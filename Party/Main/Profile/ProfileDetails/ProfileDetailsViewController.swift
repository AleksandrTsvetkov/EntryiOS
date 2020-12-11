//
//  ProfileDetailsViewController.swift
//  Party
//
//  Created by Александр Цветков on 05.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ProfileDetailsViewController: ViewController {
    
    //MARK: - Subviews
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
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let buttonView = ButtonView(color: Colors.pink.getValue(), title: "Сохранить", left: 16, right: 16)
    private lazy var picker = UIPickerView()
    private lazy var toolBar = UIToolbar()
    
    //MARK: - Properties
    var profileFieldType: ProfileFieldType = .exit
    var isKeyboardShown = false
    var phoneMaskService = PhoneMaskService()
    var plainNumber = ""
    var updatedFields: Array<(String, String, Bool)> = []
    var cityOfUser: String = ""
    var user: UserRequest!
    var passwordsForRequest: (String, String, String) = ("", "", "")
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        setupSubviews()
        configureForType()
    }
    
    //MARK: - Setup
    private func initialSetup() {
        plainNumber = user.phoneNumber.filter{ "0123456789".contains($0)}
        tableView.showsVerticalScrollIndicator = false
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        tableView.isUserInteractionEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.reuseId)
        tableView.isScrollEnabled = false
    }
    
    private func setupSubviews() {
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
    
    //MARK: - External methods
    func presentPicker() {
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
    
    //MARK: - Objc methods
    @objc private func buttonViewTapped() {
        if !updatedFields.isEmpty {
            NetworkService.shared.updateUserDetails(updatedFields: updatedFields) { result in
                switch result {
                case .success(_):
                    print("Success in \(#function)")
                case .failure(let error):
                    self.showAlert(title: "Не удалось обновить информацию", text: error.localizedDescription)
                    print(error)
                }
            }
        } else if profileFieldType == .changePassword {
            NetworkService.shared.changePassword(password: passwordsForRequest.0, newPassword1: passwordsForRequest.1, newPassword2: passwordsForRequest.2) { result in
                switch result {
                case .success(let data):
                    do {
                        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                        if dict["success"] != nil {
                            print("Success in \(#function)")
                        } else {
                            self.showAlert(title: "Не удалось сменить пароль", text: "Что-то пошло не так")
                        }
                    } catch {
                        self.showAlert(title: "Не удалось сменить пароль", text: error.localizedDescription)
                        print(error)
                    }
                case .failure(let error):
                    self.showAlert(title: "Не удалось сменить пароль", text: error.localizedDescription)
                    print(error)
                }
            }
        }
    } // buttonViewTapped
    
    @objc func doneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    @objc private func exitButtonTapped() {
        view.endEditing(true)
        dismiss(animated: true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
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

//MARK: - CityPickerDelegate
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
