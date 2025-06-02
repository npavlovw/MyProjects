//
//  HeaderView.swift
//  FoodDeliveryApp
//
//  Created by Никита Павлов on 27.05.2025.
//

import UIKit

class AllCategoriesView: UIView {
        
    private lazy var titleLabel: UILabel = {
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var seeAllBtn: UIButton = {
        $0.setTitle("See All", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        return $0
    }(UIButton(type: .system))
    
    private lazy var moreBtn: UIButton = {
        $0.setTitle(">", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        $0.tintColor = .systemGray
        return $0
    }(UIButton(type: .system))
    
    init(target: Any?, action: Selector, title: String) {
        super.init(frame: .zero)
        makeConstraints()
        makeBtn(target: target, action: action)
        makeLabel(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        addSubview(titleLabel)
        addSubview(seeAllBtn)
        addSubview(moreBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        moreBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        seeAllBtn.snp.makeConstraints { make in
            make.trailing.equalTo(moreBtn.snp.leading)
            make.centerY.equalTo(moreBtn.snp.centerY)
        }
    }
    
    private func makeBtn(target: Any?, action: Selector) {
        seeAllBtn.addTarget(target, action: action, for: .touchUpInside)
        moreBtn.addTarget(target, action: action, for: .touchUpInside)
    }
    
    private func makeLabel(title: String) {
        titleLabel.text = title
    }
}
