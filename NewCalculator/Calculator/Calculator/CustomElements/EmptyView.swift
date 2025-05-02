//
//  EmptyView.swift
//  Calculator
//
//  Created by Никита Павлов on 02.05.2025.
//

import UIKit

final class EmptyView: UIView {
    
    init() {
        super.init(frame: .zero)
        makeEmptyView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeEmptyView() {
        self.backgroundColor = .clear
    }
}
