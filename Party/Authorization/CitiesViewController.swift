//
//  CitiesViewController.swift
//  Party
//
//  Created by Александр Цветков on 29.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    
    private var places: Array<Place> = []
    private var filteredPlaces: Array<Place> = []
    private let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    private let tableView = UITableView()
    weak var delegate: CityPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
    }
    
    private func setup() {
        let color = Colors.backgroundBlack.getValue().withAlphaComponent(1)
        view.backgroundColor = color
        tableView.backgroundColor = color
        searchBar.barTintColor = color
        searchBar.keyboardAppearance = .dark
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        guard let path = Bundle.main.path(forResource: "Cities", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        var JSONmodels: Array<Place> = []
        do {
            let data = try Data(contentsOf: url)
            JSONmodels = try JSONDecoder().decode([Place].self, from: data)
        } catch {
            print(error)
        }
        places = JSONmodels
        searchBar.placeholder = "Поиск"
        searchBar.delegate = self
    }
    
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let searchText = searchBar.text else {
            delegate?.pickCity(city: places[indexPath.row].city)
            return
        }
        if searchText.isEmpty {
            delegate?.pickCity(city: places[indexPath.row].city)
        } else {
            delegate?.pickCity(city: filteredPlaces[indexPath.row].city)
        }
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchText = searchBar.text else { return places.count }
        if searchText.isEmpty {
            return places.count
        } else {
            return filteredPlaces.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        let color = Colors.backgroundBlack.getValue().withAlphaComponent(1)
        cell.backgroundColor = color
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont(name: "SFProText-Regular", size: 14)
        let place: Place
        if searchBar.text == nil || searchBar.text == "" {
            place = places[indexPath.row]
        } else {
            place = filteredPlaces[indexPath.row]
        }
        cell.textLabel?.text = "\(place.city)\n\(place.region)"
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPlaces = places.filter { place -> Bool in
            place.city.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}

protocol CityPickerDelegate: class {
    func pickCity(city: String)
}

struct Place: Decodable {
    var region: String
    var city: String
}
