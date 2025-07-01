//
//  InspirationViewController.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 01.07.2025.
//

import UIKit
import SnapKit

final class InspirationViewController: UIViewController {
    
    var viewModel: InspirationViewModel
    
    var imageData: Data?
    
    init(viewModel: InspirationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -UI-components
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let quoteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = UserDefaults.standard.string(forKey: "quote")
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        loadImage()
        setupBindings()
    }
    
    //MARK: -Constraints
    private func setupConstraints(){
        view.addSubview(mainImageView)
        mainImageView.addSubview(quoteLabel)
        
        mainImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        quoteLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    //MARK: -Bindings
    private func setupBindings() {
        viewModel.imageData = { [weak self] data in
            self?.mainImageView.image = UIImage(data: data)
        }
    }
    
    //MARK: -Logics
    private func loadImage() {
        viewModel.loadImage()
    }
}
