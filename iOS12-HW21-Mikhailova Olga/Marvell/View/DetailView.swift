//
//  DetailView.swift
//  iOS12-HW21-Mikhailova Olga
//
//  Created by FoxxFire on 10.04.2024.
//

import UIKit

class DetailView: UIViewController, UIScrollViewDelegate {
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .black
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var comicsImage: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.image = UIImage(named: "smth")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var comicsName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "palatino", size: 26)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var author: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "palatino", size: 21)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cost: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "palatino", size: 21)
        label.textColor = .red
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var annotation: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "palatino", size: 23)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var heroes: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "palatino", size: 23)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        view.backgroundColor = UIColor.random()
    }
    
    func setup(comic: Comic) {
        comicsName.text = comic.title
        guard let creators = comic.creators?.items else { return }
        for creator in creators {
            author.text = "Creator: " + (creator.name ?? "Uncnown creator")
            }
        guard let prices = comic.prices else { return }
        for price in prices {
            cost.text = "Price: \(price.price ?? 0)"
        }
        
        guard let texts = comic.textObjects else { return }
        for text in texts {
            annotation.text = "Short annotation: \(text.text)"
        }
        
        guard let characters = comic.characters else { return }
        heroes.text = "List of characters URL: \(characters.collectionURI)"
       
       
        let url = "\(comic.thumbnail!.path).\(ExtensionIamge.jpg.rawValue)"
        ImageService.downloadImage(by: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async{
                    self.comicsImage.image = image
                }
            case .failure(let failure):
                self.comicsImage.image = UIImage(named: "smth")
                print(failure.localizedDescription)
            }
        }
    }
    
    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
      [comicsImage, comicsName, author, cost, annotation, heroes].forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 2),
            
            comicsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            comicsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            comicsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            comicsImage.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 245),
        
            comicsName.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            comicsName.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            comicsName.topAnchor.constraint(equalTo: comicsImage.bottomAnchor, constant: 8),
            
            author.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -180),
            author.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 180),
            author.topAnchor.constraint(equalTo: comicsName.bottomAnchor, constant: 20),
            
            cost.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -180),
            cost.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 180),
            cost.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 20),
            
            annotation.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -180),
            annotation.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 180),
            annotation.topAnchor.constraint(equalTo: cost.bottomAnchor, constant: 20),
            
            heroes.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -180),
            heroes.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 180),
            heroes.topAnchor.constraint(equalTo: annotation.bottomAnchor, constant: 20)
       ])
    }
}



