//
//  ProfileCellDelegate.swift
//  Party
//
//  Created by Александр Цветков on 15.11.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol ProfileCellDelegate: UITextFieldDelegate {
    func textFieldChanged()
    func keyboardWillShow(row: Int)
    func keyboardWillHide(row: Int)
    func openPicker()
    func openCities()
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
            let userBirthDate = "\(user.birthDay) \(PickerData.monthNumberToString(number: birthMonth)) \(user.birthYear)"
            checkName(nameCell.getTextField())
            if name != userName {
                updatedFields = updatedFields.filter { (key, value, _) -> Bool in
                    return key != "first_name" && key != "second_name"
                }
                if let spacingIndex = name.firstIndex(of: " ") {
                    let firstName = String(name[..<spacingIndex])
                    let secondNameIndex = name.index(spacingIndex, offsetBy: 1)
                    let secondName = String(name[secondNameIndex...])
                    updatedFields.append(("first_name", firstName, false))
                    updatedFields.append(("second_name", secondName, false))
                } else {
                    updatedFields.append(("first_name", name, false))
                }
            }
            if birthDate != userBirthDate {
                updatedFields = updatedFields.filter { (key, value, _) -> Bool in
                    return key != "birthday_date"
                }
                let dateParts = birthDate.split(separator: " ")
                let newBirthDate = "\(dateParts[2])-\(PickerData.monthStringToNumber(string: String(dateParts[1])))-\(dateParts[0])"
                updatedFields.append(("birthday_date", newBirthDate, false))
            }
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
            if phone != userPhone {
                updatedFields = updatedFields.filter { (key, value, _) -> Bool in
                    return key != "phone_number"
                }
                updatedFields.append(("phone_number", phone, false))
            }
            if email != userEmail {
                updatedFields = updatedFields.filter { (key, value, _) -> Bool in
                    return key != "email_address"
                }
                updatedFields.append(("email_address", email, false))
            }
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
                passwordsForRequest.0 = oldPassword
                passwordsForRequest.1 = firstPassword
                passwordsForRequest.2 = secondPassword
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
