//
//  MarvellView.swift
//  iOS12-HW21-Mikhailova Olga
//
//  Created by FoxxFire on 10.04.2024.
//

import UIKit

class MarvelView: UIView {

    weak var delegate: MarvellViewController?
    
    private lazy var spinner: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView(style: .large)
        view.color = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView  = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MarvellTableViewCell.self, forCellReuseIdentifier: MarvellTableViewCell.identifier)
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .black
        tableView.dataSource = delegate
        tableView.delegate = delegate
        return tableView
    }()
    
    private lazy var searchField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "input your search:"
        text.layer.borderWidth = 2
        text.layer.borderColor = UIColor.gray.cgColor
        text.layer.cornerRadius = 5
        text.textAlignment = .center
        text.backgroundColor = .white
        text.addTarget(self, action: #selector(changeTextSearch), for: .editingChanged)
        return text
    }()

    init(delegate: MarvellViewController) {
        super.init(frame: .zero)
        self.delegate = delegate
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func changeStatusSpinner() {
        spinner.isAnimating ? spinner.stopAnimating() : spinner.startAnimating()
    }
    
    @objc private func changeTextSearch() {
        guard let text = searchField.text else { return }
        delegate?.changeValueSearch(text: text)
    }
    
    private func setupHierarchy() {
        addSubview(tableView)
        addSubview(spinner)
        addSubview(searchField)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            searchField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            searchField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            searchField.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

