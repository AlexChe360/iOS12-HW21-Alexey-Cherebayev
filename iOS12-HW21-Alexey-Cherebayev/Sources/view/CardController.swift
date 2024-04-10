//
//  CardController.swift
//  iOS12-HW21-Alexey-Cherebayev
//
//  Created by Alex on 05.04.2024.
//

import UIKit
import ProgressHUD

class CardController: UIViewController {
    
    // MARK: - Properties
    var apiResult: Cards? = nil
    
    // MARK: - UI
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.backgroundColor = UIColor.systemGray5
        textField.placeholder = "Search"
        textField.translatesAutoresizingMaskIntoConstraints = false
        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftView = indentView
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews([
            searchTextField,
            searchButton
        ])
        return view
    }()
    
    private lazy var cardTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        cardTableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        cardTableView.delegate = self
        cardTableView.dataSource = self
        self.showLoader()
        APIFetch.sharedInstance.fetchAPIData { apiData in
            self.apiResult = apiData
            
            DispatchQueue.main.async {
                self.cardTableView.reloadData()
                self.dismissLoader()
            }
        }
    }
    
    private func setupHierarchy() {
        view.addSubviews([
            searchView,
            cardTableView
        ])
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -5)
        ])

        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 5),
            searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -5),
            searchTextField.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
            searchTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            cardTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 10),
            cardTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cardTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cardTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc func searchDidTap() {
        showLoader()
        guard let searchText = self.searchTextField.text else { return }
        APIFetch().searchDataByName(name: searchText) { apiData in
            self.apiResult = apiData
            
            DispatchQueue.main.async {
                self.cardTableView.reloadData()
                self.dismissLoader()
            }
        }
        searchTextField.text = ""
        self.view.window?.endEditing(true)
    }
    
    // MARK: - Functions
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Информация", message: message, preferredStyle: .alert)
         
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
         
        self.present(alert, animated: true)
    }
    
    private func showLoader() {
        ProgressHUD.animationType = .activityIndicator
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.colorHUD = .clear
        ProgressHUD.animate()
    }
    
    private func dismissLoader() {
        ProgressHUD.dismiss()
    }
}

extension CardController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiResult?.cards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        if let card = apiResult?.cards?[indexPath.row] {
            cell.config(card: card)
            
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let card = apiResult?.cards?[indexPath.row] {
            self.showAlert(message: card.name ?? "")
        }
    }

}

