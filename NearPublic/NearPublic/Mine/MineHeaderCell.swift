//
//  MineHeaderCell.swift
//  NearPublic
//
//  Created by ios2 on 2020/9/8.
//  Copyright © 2020 lg. All rights reserved.
//

import UIKit
import SnapKit
class MineHeaderCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

	lazy var nameLable: UILabel = {
		let l = UILabel()
		l.font =  .systemFont(ofSize: 28.f_pt)
		l.textColor = .hexInt(0x434343)
		l.text = "黎港蓝天"
		contentView .addSubview(l)
		return l
	}()

	lazy var userIcon: UIImageView = {
		let imgV = UIImageView()
		imgV.layer.cornerRadius = 40.f_pt
		imgV.clipsToBounds = true
		imgV.backgroundColor = .hexInt(0xf0f0f0)
		contentView .addSubview(imgV)
		return imgV
	}()

	lazy var companyLable: UILabel = {
		let l = UILabel()
		l.textAlignment = .left
		l.text = "XXX网络技术有限公司"
		l.font = .systemFont(ofSize: 25.f_pt)
		l.textColor = .hexInt(0x434343)
		contentView.addSubview(l)
		return l
	}()

	lazy var messageLable: UILabel = {
		let l = UILabel()
		l.textColor = .hexInt(0x888888)
		l.text = "敢作敢为，勇于争先"
		l.font = .systemFont(ofSize: 27.f_pt)
		let v = UIView()
		v.clipsToBounds = true
		v.layer.cornerRadius = 10.f_pt
		v.backgroundColor = .hexInt(0xf0f0f0)
		contentView.insertSubview(v, at: 0);
		contentView .addSubview(l)
		v.snp.makeConstraints { (make) in
			make.edges.equalTo(l).inset(UIEdgeInsets(top: 0, left: -10.f_pt, bottom: 0, right: -10.f_pt))
		}
		return l
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setUpUI()
	}

	func setUpUI()  {

		userIcon.snp.makeConstraints { (make) in
			make.right.equalTo(-20.f_pt)
			make.height.equalTo(80.f_pt)
			make.width.equalTo(80.f_pt)
			make.top.equalTo(statusHeight + 20.f_pt)
		}

		nameLable.snp.makeConstraints { (make) in
			make.left.equalTo(30.f_pt)
			make.top.equalTo(userIcon.snp_top)
			make.height.equalTo(55.f_pt)
			make.right.lessThanOrEqualTo(userIcon.snp_left).offset(-1)
		}

		companyLable.snp.makeConstraints { (make) in
			make.top.equalTo(nameLable.snp_bottom)
			make.height.equalTo(40.f_pt)
			make.left.equalTo(nameLable)
		}

		messageLable.snp.makeConstraints { (make) in
			make.top.equalTo(userIcon.snp_bottom).offset(30.f_pt)
			make.left.equalTo(40.f_pt)
			make.right.equalTo(-40.f_pt)
			make.height.equalTo(60.f_pt)
			make.bottom.equalTo(-30.f_pt)
		}

		let imgUrlStr = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1599739174107&di=02cf17ad3433b39bfef2954b8b11c671&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fpmop%2F2018%2F0613%2F777CD76919E2510DF380FC834B774AD80F089912_size19_w414_h359.jpeg"
		userIcon.sd_setImage(with: URL(string: imgUrlStr), completed: nil)
 	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}



}
