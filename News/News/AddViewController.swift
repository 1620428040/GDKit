//
//  AddViewController.swift
//  News
//
//  Created by 国栋 on 16/2/26.
//  Copyright © 2016年 GD. All rights reserved.
//

import UIKit

let sw=UIScreen.mainScreen().bounds.size.width
let sh=UIScreen.mainScreen().bounds.size.height

class AddViewController: UIViewController,UITextFieldDelegate {
    
    var vw:CGFloat=0
    var vh:CGFloat=0
    var titleInput:UITextField=UITextField()
    
    override func viewDidLoad() {
        vw=self.view.frame.size.width
        vh=self.view.frame.size.height
        
        self.view.backgroundColor=UIColor.whiteColor();
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "上传", style: .Done, target: self, action:Selector("uploadHandler"))
        
        let descLabel=UILabel()
        descLabel.frame=CGRectMake(vw*0.05, 74, vw*0.9, 30)
        descLabel.numberOfLines=0
        descLabel.text="在这个界面，您可以创建并上传任何内容的新闻到服务器，它们将会在被审核后发布"
        descLabel.textColor=UIColor.lightGrayColor()
        descLabel.sizeToFit()
        self.view.addSubview(descLabel)
        
        titleInput.frame=CGRectMake(vw*0.05, descLabel.frame.origin.y+descLabel.frame.size.height+10, vw*0.9, 30)
        titleInput.backgroundColor=UIColor.grayColor()
        titleInput.placeholder="新闻标题"
        titleInput.delegate=self;
        self.view.addSubview(titleInput)
        
        
        
    }
    
    func uploadHandler()
    {
        NSLog("上传中")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        NSLog("返回")
        titleInput.resignFirstResponder()
        return true
    }
}