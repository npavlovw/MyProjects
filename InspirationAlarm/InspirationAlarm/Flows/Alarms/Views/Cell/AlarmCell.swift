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
        label.textColor = .white
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private var alarmSwitch = UISwitch()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        setConstraints()
        alarmSwitch.addTarget(self, action: #selector(alarmIsOn), for: .touchUpInside)
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
        alarmSwitch.isOn = data.isActive
        
        let textColor: UIColor = data.isActive ? .white : .lightGray
        timeLabel.textColor = textColor
        nameLabel.textColor = textColor
    }
    
    @objc func alarmIsOn() {
        timeLabel.textColor = alarmSwitch.isOn ? .white : .lightGray
        nameLabel.textColor = alarmSwitch.isOn ? .white : .lightGray
    }
}
