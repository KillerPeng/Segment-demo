//
//  ViewController.swift
//  TestView
//
//  Created by travelzen on 16/1/14.
//  Copyright © 2016年 phz. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let view=CustomeSegmentControl.init(frame: CGRectMake(30, 100, UIScreen.mainScreen().bounds.size.width-60, 50))
        view.duration=0.7
        view.titlesArray=["红","黄","蓝","紫"]
        view.setButtonOnClickBlock { (tag, str) -> Void in
            print(tag,str)
        }
        self.view.addSubview(view)
        
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

