//
//  AlarmTableViewCell.swift
//  InspirationAlarm
//
//  Created by Никита Павлов on 19.06.2025.
//

import UIKit
import SnapKit

class AlarmCell: UITableViewCell {
    
    static let reuseID = "AlarmCell"
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 37, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private var alarmSwitch: UISwitch = {
        let switchView = UISwitch()
        return switchView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        alarmSwitch.addTarget(self, action: #selector(switchTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(alarmSwitch)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(8)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
        alarmSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func setupCell(data: Alarm) {
        timeLabel.text = data.clock
        nameLabel.text = data.name
    }
    
    @objc func switchTapped() {
        if alarmSwitch.isOn {
            timeLabel.textColor = .white
            nameLabel.textColor = .white
        } else {
            timeLabel.textColor = .lightGray
            nameLabel.textColor = .lightGray
        }
    }
}
