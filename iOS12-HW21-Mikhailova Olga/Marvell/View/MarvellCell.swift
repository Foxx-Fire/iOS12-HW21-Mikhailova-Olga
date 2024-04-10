//
//  MarvellCell.swift
//  iOS12-HW21-Mikhailova Olga
//
//  Created by FoxxFire on 10.04.2024.
//

import UIKit

class MarvellTableViewCell: UITableViewCell {
    
    static let identifier = "MarvellTableViewCell"
    
    fileprivate enum Constants {
        static var smallOffset: CGFloat = 10
        static var middleOffset: CGFloat = 15
        static var bigOffset: CGFloat = 32
    }
    
    // MARK: - Elements
    
    private lazy var comicsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var comicsName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "palatino", size: 23)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(comic: Comic) {
        comicsName.text = comic.title
        comicsImage.image = UIImage(named: "smth")
        
        //не придумала как альтернативно подставлять картинку
//        let url = "\(comic.thumbnail!.path).\(ExtensionIamge.jpg.rawValue)"
//        ImageService.downloadImage(by: url) { result in
//            switch result {
//            case .success(let image):
//                DispatchQueue.main.async{
//                    self.comicsImage.image = image
//                }
//            case .failure(let failure):
//                self.comicsImage.image = UIImage(named: "smth")
//                print(failure.localizedDescription)
//            }
//        }
    }
    
    //MARK: - Setups
    
    private func setupHierarchy() {
        [comicsImage, comicsName].forEach { addSubview($0) }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
        
            comicsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.smallOffset),
            comicsImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            comicsImage.heightAnchor.constraint(equalToConstant: Constants.bigOffset),
            comicsImage.widthAnchor.constraint(equalToConstant: Constants.bigOffset),
            
            comicsName.leadingAnchor.constraint(equalTo: comicsImage.trailingAnchor, constant: Constants.middleOffset),
            comicsName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.smallOffset),
            comicsName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.smallOffset),
            comicsName.widthAnchor.constraint(equalToConstant: 270)
        ])
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
}

extension UITableViewCell {
    func addCustomDisclosureIndicator(with color: UIColor) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 15))
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular, scale: .large)
        let symbolImage = UIImage(systemName: "chevron.right",
                                  withConfiguration: symbolConfig)
        button.setImage(symbolImage?.withTintColor(color, renderingMode: .alwaysOriginal), for: .normal)
        button.tintColor = color
        self.accessoryView = button
    }
}

