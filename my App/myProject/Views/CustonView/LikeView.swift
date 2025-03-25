//
//  LikeView.swift
//  myProject
//
//  Created by Никита Павлов on 19.02.2025.
//

import UIKit

class LikeView: UIView {

    private var likeImageView = UIImageView()
    private var likeCountLabel = UILabel()
    
    private var likeCount: Int = 0
    private var isSelected: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        likeImageView.frame = bounds
    }
    
    private func addSubviews() {
        addSubview(likeImageView)
        addSubview(likeCountLabel)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap() {
        animateTap()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubviews()
        setupLikeImageView()
        setupLikeCounterLabel()
    }

    private func setupLikeImageView() {
        likeImageView.tintColor = .red.withAlphaComponent(0.8)
        likeImageView.image = UIImage(systemName: "heart.fill")
    }
    
    func Configure(isLike: Bool, likeCount: Int) {
        self.likeCount = likeCount
        isSelected = isLike
        
    }
    
    private func setupLikeCounterLabel() {
        likeCountLabel.textColor = .white
        likeCountLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        likeCountLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        likeCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func animateTap() {
        isSelected.toggle()
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations:  { [self] in
            likeCountLabel.text = isSelected ? String(likeCount + 1) : String(likeCount)
            likeImageView.alpha = isSelected ? 0.8 : 0.5})
    }
}
