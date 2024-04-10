//
//  ViewController.swift
//  iOS12-HW21-Mikhailova Olga
//
//  Created by FoxxFire on 10.04.2024.
//
import UIKit

class MarvellViewController: UIViewController {
    
    private lazy var marvelView: MarvelView = {
        let view = MarvelView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var comicImages: [Comic] = []
    private var apiManager: APIMarvellManagerProtocol?
    private var timer: Timer?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Comics Collection"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
       
        setupHierarchy()
        setupLayout()
        marvelView.changeStatusSpinner()
        
        apiManager?.getComics{ [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let comic):
                    self.comicImages = comic
                case .failure(let error):
                    print(error)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.marvelView.reloadTable()
                    self.marvelView.changeStatusSpinner()
                }
            }
        }
    }
    
    init(apiManager: APIMarvellManagerProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.apiManager = apiManager
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(marvelView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            marvelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            marvelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            marvelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            marvelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    func changeValueSearch(text: String) {
        let tempComics = comicImages.filter {
            guard let title = $0.title else { return false}
            return title.contains(text)
        }
        comicImages = tempComics
        marvelView.reloadTable()
    }
}

//MARK: - Extensions

extension MarvellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarvellTableViewCell.identifier, for: indexPath) as? MarvellTableViewCell else { return UITableViewCell() }
     
        cell.addCustomDisclosureIndicator(with: .white)
        cell.setupCell(comic: comicImages[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comicImages.count
    }
}

extension MarvellViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailView()
        tableView.deselectRow(at: indexPath, animated: true)
        viewController.setup(comic: comicImages[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
        
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeFadeAnimation(duration: 0.5, delayFactor: 0.05)
      //  let animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height, duration: 1.0, delayFactor: 0.05)
      //  let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 1.0, delayFactor: 0.05)
      //  let animation = AnimationFactory.makeSlideIn(duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
}

