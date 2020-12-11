//
//  HistoryViewController.swift
//  Party
//
//  Created by Александр Цветков on 31.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class HistoryViewController: ViewController {

    //MARK: - Subviews
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Мои вечеринки"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let counterLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "12"
        view.font = UIFont(name: "SFProDisplay-Bold", size: 40)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let countLabel: UILabel = {
        let view = UILabel()
        view.textColor = Colors.labelGray.getValue()
        view.text = "В этом месяце"
        view.font = UIFont(name: "SFProText-Semibold", size: 15)
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
        view.insertSegment(withTitle: "Посетил", at: 0, animated: false)
        view.insertSegment(withTitle: "Организовал", at: 1, animated: false)
        view.selectedSegmentIndex = 0
        return view
    }()
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let organizeButtonView: ButtonView = {
        let view = ButtonView(color: Colors.pink.getValue(), title: "Организовать", left: 16, right: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var commentView: CommentView = CommentView(withDelegate: self)
    private lazy var organizedEventPreview: OrganizedEventPreview = OrganizedEventPreview(withDelegate: self)
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupSubviews()
    }
    
    //MARK: - Setup
    private func initialSetup() {
        tableView.showsVerticalScrollIndicator = false
        tableView.isUserInteractionEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.reuseId)
        tableView.isScrollEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonViewTapped))
        organizeButtonView.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupSubviews() {
        view.backgroundColor = Colors.backgroundBlack.getValue().withAlphaComponent(1)
        view.addSubview(titleLabel)
        view.addSubview(counterLabel)
        view.addSubview(countLabel)
        view.addSubview(organizeButtonView)
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        view.addSubview(commentView)
        view.addSubview(organizedEventPreview)
        
        NSLayoutConstraint.activate([
            commentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            commentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            commentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            organizedEventPreview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            organizedEventPreview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18),
            organizedEventPreview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            organizedEventPreview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            titleLabel.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -33),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            segmentedControl.bottomAnchor.constraint(equalTo: counterLabel.topAnchor, constant: -50),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            counterLabel.heightAnchor.constraint(equalToConstant: 29),
            counterLabel.bottomAnchor.constraint(equalTo: countLabel.bottomAnchor),
            counterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            counterLabel.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -14.7),
            
            countLabel.heightAnchor.constraint(equalToConstant: 12.5),
            countLabel.bottomAnchor.constraint(equalTo: organizeButtonView.topAnchor, constant: -45),
            
            organizeButtonView.heightAnchor.constraint(equalToConstant: 50),
            organizeButtonView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -32),
            organizeButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            organizeButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    //MARK: - Objc methods
    @objc private func buttonViewTapped() {
        
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        DispatchQueue.main.async {
            self.commentView.bottomConstraint.constant = 400 - keyboardFrame.height
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        DispatchQueue.main.async {
            self.commentView.bottomConstraint.constant = 300
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tabBarController?.tabBar.isHidden = true
        if segmentedControl.selectedSegmentIndex == 0 {
            commentView.isHidden = false
        } else {
            organizedEventPreview.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return EventsHeaderView(ofType: EventType.allCases[section])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.reuseId, for: indexPath) as? HistoryCell else { return UITableViewCell() }
        let event = Event(title: "Drug", beginning: "2020-12-13 20:00", description: "description", location_id: "", price: "", ending: "", shisha: "", age_bottom_limit: "", age_top_limit: "", count_bottom_limit: "", count_top_limit: "")
        cell.configure(withModel: event, forType: EventType.allCases[indexPath.section])
        return cell
    }
}

//MARK: - CommentViewDelegate
extension HistoryViewController: CommentViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text.count < 2 else { return false }
        if textView.text.count == 180 && text != "" {
            return false
        } else {
            return true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        if newSize.height > 80 && newSize.height < 150 {
            commentView.commentTextViewHeightConstraint.constant = newSize.height
            //commentView.backButtonViewBottomConstraint.constant = (newSize.height - 80) - 350
        }
    }
    
    func hideView() {
        commentView.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
}

//MARK: - OrganizedEventPresenter
extension HistoryViewController: OrganizedEventPresenter {
    
    func presentOrganizedEventVC() {
        let vc = OrganizedEventViewController()
        tabBarController?.tabBar.isHidden = false
        present(vc, animated: true)
    }
}
