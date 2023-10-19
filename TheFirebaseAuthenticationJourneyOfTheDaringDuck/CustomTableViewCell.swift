//
//  CustomTableViewCell.swift
//  TheFirebaseAuthenticationJourneyOfTheDaringDuck
//
//  Created by Cenker Soyak on 19.10.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let emailLabel = UILabel()
    let postImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI(){
        postImage.contentMode = .scaleAspectFit
        self.contentView.addSubview(postImage)
        postImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(40)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-50)
        }
        
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.text = "Cenker"
        contentView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.bottom.equalTo(postImage.snp.top).offset(-5)
        }
    }
}
