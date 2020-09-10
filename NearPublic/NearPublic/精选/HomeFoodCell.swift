//
//  HomeFoodCell.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/9.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit

class HomeFoodCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

		super.init(style: style, reuseIdentifier: reuseIdentifier)

		backgroundColor = .hexInt(0xfafafa)

		bgView.snp.makeConstraints { (make) in
			make.left.equalTo(15.f_pt)
			make.right.equalTo(-15.f_pt)
			make.top.equalTo(5.f_pt)
			make.bottom.equalToSuperview().offset(-10.f_pt)
		}

		foodImgV.snp.makeConstraints { (make) in
			make.left.equalTo(20.f_pt)
			make.height.equalTo(150.f_pt)
			make.width.equalTo(foodImgV.snp_height).multipliedBy(16.0/9.0)
			make.top.equalTo(20.f_pt)
			make.bottom.equalTo(-20.f_pt)
		}

		foodName.snp.makeConstraints { (make) in
			make.left.equalTo(foodImgV.snp_right).offset(10.f_pt)
			make.top.equalTo(foodImgV.snp_centerY).offset(-50.f_pt)
			make.height.equalTo(40.f_pt)
			make.right.equalToSuperview()
		}

		address.snp.makeConstraints { (make) in
			make.top.equalTo(foodName.snp_bottom).offset(10.f_pt)
			make.left.equalTo(foodName)
			make.right.equalToSuperview()
			make.height.equalTo(foodName)
		}

		foodImgV.sd_setImage(with: URL(string: "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3289253709,3155059999&fm=26&gp=0.jpg"), completed: nil)

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	lazy var bgView: UIView = {
		let v = UIView()
		v.layer.cornerRadius = 10.f_pt
		v.clipsToBounds = true
		v.backgroundColor = .white
		contentView.addSubview(v)
		return v
	}()

	lazy var foodImgV: UIImageView = {
		let imgV = UIImageView()
		imgV.layer.cornerRadius = 10.f_pt
		imgV.clipsToBounds = true
		imgV.backgroundColor = .hexInt(0xfafafa)
		bgView.addSubview(imgV)
		return imgV
	}()

	lazy var foodName: UILabel = {
		let nameLable = UILabel()
		nameLable.text = "宫保鸡丁盖饭"
		nameLable.font = .systemFont(ofSize: 30.f_pt)
		nameLable.textColor = .hexInt(0x888888)
		nameLable.numberOfLines = 0
		bgView.addSubview(nameLable)
		return nameLable
	}()

	lazy var address: UILabel = {
		let l = UILabel()
		l.text = "长安区嘉和广场8号楼0802"
		l.textColor = .hexInt(0xffa000)
		l.textAlignment = .left
		l.font = .systemFont(ofSize: 26.f_pt)
		bgView.addSubview(l)
		return l
	}()

}
