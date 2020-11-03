//
//  RegistrationViewController.swift
//  Party
//
//  Created by Александр Цветков on 17.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit
import CoreLocation

class RegistrationViewController: UIViewController, StatusDelegate {
    
    //MARK: - Properties
    private var locationManager: CLLocationManager = CLLocationManager()
    private var geoCoder: CLGeocoder = CLGeocoder()
    private let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.text = "Регистрация"
        view.textColor = .white
        return view
    }()
    private lazy var buttonView = ButtonView(color: Colors.buttonGray.getValue(), title: "Дальше", left: 16, right: 16)
    private let tableView = UITableView(frame: .zero, style: .grouped)
    var fieldsStatus = [false, false, false, false] {
        willSet {
            if newValue[0] && newValue[1] && newValue[2] && newValue[3] {
                buttonView.setColor(color: Colors.pink.getValue())
                buttonView.isUserInteractionEnabled = true
            } else {
                buttonView.setColor(color: Colors.buttonGray.getValue())
                buttonView.isUserInteractionEnabled = false
            }
        }
    }
    var picker: UIPickerView?
    var toolBar: UIToolbar?
    var phoneNumber: String = ""
    private var location: Location?
    private var locationId: Int = 0
    private var isKeyboardShown = false
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RegistrationCell.self, forCellReuseIdentifier: RegistrationCell.reuseId)
        setupViews()
        
        initLocation()
        let tap = UITapGestureRecognizer(target: self, action: #selector(doneButtonTapped))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserversAndRecognizers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Setup
    private func addObserversAndRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonViewTapped))
        buttonView.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func initLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(label)
        view.addSubview(buttonView)
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 376)
        ])
        if UIScreen.main.bounds.height < 740 {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
                buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            ])
        } else {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 42),
                buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            ])
        }
    }
    
    func presentPicker(_ pickerView: UIPickerView) {
        view.endEditing(true)
        picker = pickerView
        guard let picker = picker else { return }
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = Colors.textFieldBackgroundResponder.getValue()
        picker.tintColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        toolBar = UIToolbar()
        guard let toolBar = toolBar else { return }
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
    
    private func receiveServerError() {
        for row in 0...(tableView.numberOfRows(inSection: 0) - 1) {
            let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! RegistrationCell
            cell.textFieldView.floatingTextField.text = ""
        }
        guard let picker = picker else { return }
        picker.selectRow(PickerData.days.rawValue / 2, inComponent: 0, animated: false)
        picker.selectRow(PickerData.months.rawValue / 2, inComponent: 1, animated: false)
        picker.selectRow(PickerData.years.rawValue / 2, inComponent: 2, animated: false)
    }
    
    private func getUser() -> User {
        var user = User(phoneNumber: phoneNumber, firstName: "", secondName: "", birthYear: "", birthMonth: "", birthDay: "", locationId: "\(locationId)", password: "", email: "")
        let nameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RegistrationCell
        let fullName = nameCell.textFieldView.floatingTextField.text ?? ""
        if let spacingIndex = fullName.firstIndex(of: " ") {
            let firstName = fullName[..<spacingIndex]
            let secondNameIndex = fullName.index(spacingIndex, offsetBy: 1)
            let secondName = fullName[secondNameIndex...]
            user.firstName = String(firstName)
            user.secondName = String(secondName)
        } else {
            user.firstName = fullName
        }
        guard let picker = picker else { return user }
        user.birthDay = "\(picker.selectedRow(inComponent: 0) + 1)"
        user.birthMonth = "\(picker.selectedRow(inComponent: 1) + 1)"
        user.birthYear = "\(2020 - picker.selectedRow(inComponent: 2))"
        let emailCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! RegistrationCell
        let email = emailCell.textFieldView.floatingTextField.text ?? ""
        user.email = email
        let passwordCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! RegistrationCell
        let password = passwordCell.textFieldView.floatingTextField.text ?? ""
        user.password = password
        return user
    }
    
    private func sendLocation() {
        let semaphore = DispatchSemaphore(value: 0)
        guard let location = self.location else { return }
        NetworkService.shared.createLocation(locationModel: location) { result in
            switch result {
            case .success(let data):
                do {
                    guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                    print(dict)
                    if let id = dict["location_id"] as? Int {
                        self.locationId = id
                    }
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
            semaphore.signal()
        }
        semaphore.wait()
    }
    
    private func hasLocation() {
            self.location?.title = ""
            self.sendLocation()
            NetworkService.shared.createUser(user: self.getUser()) { result in
                switch result {
                case .success(let data):
                    do {
                        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                        print(dict)
                        if let warning = dict["warning"] as? String {
                            self.receiveServerError()
                            print(warning)
                            return
                        }
                        if let error = dict["error"] as? String {
                            self.receiveServerError()
                            print(error)
                            return
                        }
                        if let success = dict["success"] as? Int {
                            if success == 1 {
                                let vc = LoginViewController()
                                let backButton = UIBarButtonItem()
                                backButton.title = "Зачем?"
                                self.navigationItem.backBarButtonItem = backButton
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    private func noLocation() {
        let ac = UIAlertController(title: "Не удалось получить вашу геопозицию", message: "Пожалуйста, выберите город из списка", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .default) { _ in
            let vc = CitiesViewController()
            vc.delegate = self
            self.present(vc, animated: true)
        }
        ac.addAction(ok)
        present(ac, animated: true)
    }
    
    //MARK: - Objc methods
    @objc func doneButtonTapped() {
        toolBar?.removeFromSuperview()
        picker?.removeFromSuperview()
    }
    
    @objc private func buttonViewTapped() {
        if buttonView.isUserInteractionEnabled {
            if self.location != nil {
                hasLocation()
            } else {
                noLocation()
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        doneButtonTapped()
        guard !isKeyboardShown else { return }
        tableView.isScrollEnabled = true
        guard let userInfo = notification.userInfo else {
            tableView.isScrollEnabled = false
            return
        }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        print(keyboardFrame, "called once")
        DispatchQueue.main.async {
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            self.tableView.isScrollEnabled = true
            self.isKeyboardShown = true
        }
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 0.1, animations: {
//                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
//                //self.tableView.scrollToRow(at: IndexPath(row: 2, section: 0), at: .top, animated: true)
//            }) { _ in
//                self.tableView.isScrollEnabled = false
//            }
//        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        DispatchQueue.main.async {
            self.tableView.isScrollEnabled = true
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self.tableView.isScrollEnabled = false
            self.isKeyboardShown = false
        }
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 0.1, animations: {
//                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//                //self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//            }) { _ in
//                self.tableView.isScrollEnabled = false
//            }
//        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension RegistrationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationCell.reuseId, for: indexPath) as! RegistrationCell
        cell.configure(withType: FieldType.allCases[indexPath.row])
        cell.statusDelegate = self
        return cell
    }
}

//MARK: - CLLocationManagerDelegate
extension RegistrationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocation = manager.location else { return }
        geoCoder.reverseGeocodeLocation(locValue) { (placemarks, error) in
            if let locality = placemarks?.first?.locality, let thoroughfare = placemarks?.first?.thoroughfare, let subThoroughfare = placemarks?.first?.subThoroughfare, self.location == nil {
                self.location = Location(title: "\(thoroughfare) \(subThoroughfare)", city: locality, latitude: "\(locValue.coordinate.latitude)", longitude: "\(locValue.coordinate.longitude)")
            }
        }
        manager.stopUpdatingLocation()
    }
}

//MARK: - CityPickerDelegate
extension RegistrationViewController: CityPickerDelegate {
    func pickCity(city: String) {
        getCoordinateFrom(address: city) { coordinate, error in
            guard let coordinate = coordinate, error == nil else {
                print("\(String(describing: error)) when trying to geocode city name to coordinate")
                return
            }
            self.location = Location(title: city, city: city, latitude: "\(coordinate.latitude)", longitude: "\(coordinate.longitude)")
            self.sendLocation()
            NetworkService.shared.createUser(user: self.getUser()) { result in
                switch result {
                case .success(let data):
                    do {
                        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                        print(dict)
                        if let warning = dict["warning"] as? String {
                            self.receiveServerError()
                            print(warning)
                            return
                        }
                        if let error = dict["error"] as? String {
                            self.receiveServerError()
                            print(error)
                            return
                        }
                        if let success = dict["success"] as? Int {
                            if success == 1 {
                                let vc = LoginViewController()
                                let backButton = UIBarButtonItem()
                                backButton.title = "Зачем?"
                                self.navigationItem.backBarButtonItem = backButton
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        geoCoder.geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension RegistrationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! RegistrationCell
        cell.textFieldView.floatingTextField.titleColor = Colors.textFieldCorrect.getValue()
        let day = pickerView.selectedRow(inComponent: 0)
        let month = titleForMonthComponent(row: pickerView.selectedRow(inComponent: 1))
        let year = 2020 - pickerView.selectedRow(inComponent: 2)
        fieldsStatus[1] = true
        cell.textFieldView.floatingTextField.text = "\(day) \(month) \(year)"
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

enum PickerData: Int {
    case days = 31
    case months = 12
    case years = 100
}
