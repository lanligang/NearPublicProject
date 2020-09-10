//
//  MineArrowCell.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class MineArrowCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

	lazy var icon: UIImageView = {
		let imgV = UIImageView()
		imgV.contentMode = .scaleAspectFit
		contentView.addSubview(imgV)
		return imgV
	}()
	lazy var arrowImgV: UIImageView = {
		let imgV = UIImageView()
		imgV.contentMode = .scaleAspectFit
		contentView.addSubview(imgV)
		imgV.image = UIImage(named: "fbre_gdxx_btn_icon")
		return imgV
	}()
	lazy var titleLable: UILabel = {
		let l = UILabel()
		l.textAlignment = .left
		l.text = "type"
		l.font = .systemFont(ofSize: 25.f_pt)
		l.textColor = .hexInt(0x434343)
		contentView.addSubview(l)
		return l
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		icon.snp.makeConstraints { (make) in
			make.left.equalTo(30.f_pt)
			make.top.equalTo(20.f_pt)
			make.height.equalTo(55.f_pt)
			make.width.equalTo(55.f_pt)
			make.bottom.equalTo(-30.f_pt)
		}
		titleLable.snp.makeConstraints { (make) in
			make.left.equalTo(icon.snp_right).offset(10.f_pt)
			make.centerY.equalToSuperview()
			make.height.equalTo(60.f_pt)
			make.right.equalTo(-100.f_pt)
		}
		arrowImgV.snp.makeConstraints { (make) in
			make.right.equalTo(-25.f_pt)
			make.width.height.equalTo(25.f_pt)
			make.centerY.equalToSuperview()
		}
	}

	var minemMdel:MineModel? {
		didSet {
			titleLable.text = minemMdel?.title
			icon.image = UIImage(named: minemMdel?.iconName ?? "")
		}
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
