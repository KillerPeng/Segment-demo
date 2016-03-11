//
//  CustomeSegmentControl.swift
//  TestView
//
//  Created by travelzen on 16/1/14.
//  Copyright © 2016年 phz. All rights reserved.
//

import UIKit

typealias ButtonOnClickBlock = (tag:NSInteger,str:String)->Void

class CustomeSegmentControl: UIView
{
    var titlesArray:NSArray?
    var titlesCustomeColor:UIColor?        //文本原来的颜色
    var titlesHeightLightColor:UIColor?    //文本高亮时的颜色
    var backgroundHeightLightColor:UIColor? //背景view高亮时的颜色
    var titlesFont:UIFont?                  //字体大小
    var duration:Double?                   //动画时长
    
    var viewWidth:CGFloat?//组件的宽度
    var viewHeight:CGFloat?//组件的高度
    var lableWidth:CGFloat?//lable的宽度
    
    var heightLightView:UIView?
    var heightTopView:UIView?
    
    var buttonBlock:ButtonOnClickBlock?
    var labelMutableArray:NSMutableArray?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.viewHeight=frame.size.height
        self.viewWidth=frame.size.width
        self.duration=3.0
    }
    
    override func layoutSubviews()
    {
        self.customeData()
        self.createBottomLabels()
        self.createTopLables()
        self.createTopButtons()
    }
    
    func setButtonOnClickBlock(block:ButtonOnClickBlock!)
    {
        if (block != nil)
        {
            self.buttonBlock=block
        }
    }
    
    func customeData()
    {
        if titlesArray==nil
        {
            titlesArray=["test0","test1","test2","test3"]
        }
        if titlesCustomeColor==nil
        {
            titlesCustomeColor=UIColor.blackColor()
        }
        if titlesHeightLightColor==nil
        {
            titlesHeightLightColor=UIColor.whiteColor()
        }
        if backgroundHeightLightColor==nil
        {
            backgroundHeightLightColor=UIColor.blueColor()
        }
        if titlesFont==nil
        {
            titlesFont=UIFont.systemFontOfSize(20)
        }
        if labelMutableArray==nil
        {
            labelMutableArray=NSMutableArray.init(capacity: (titlesArray?.count)!)
        }
        self.lableWidth = CGFloat(self.viewWidth!) / CGFloat((titlesArray?.count)!)
    }
    
    //返回当前view的frame
    func countCurrentRectWithIndex(index:NSInteger)->CGRect
    {
        return CGRectMake(CGFloat(self.lableWidth!) * CGFloat(index), 0, self.lableWidth!, self.viewHeight!)
    }

    func createLabelWithTitlesIndex(index:NSInteger,textColor:UIColor)->UILabel
    {
        let currentLabelFrame = self.countCurrentRectWithIndex(index)
        let tempLabel = UILabel.init(frame: currentLabelFrame)
        tempLabel.textColor = textColor
        tempLabel.text = titlesArray![index] as? String
        tempLabel.font = self.titlesFont;
        tempLabel.minimumScaleFactor = 0.1;
        tempLabel.textAlignment = NSTextAlignment.Center;
        return tempLabel;
    }
    
    //  创建最底层的Label
    func createBottomLabels()
    {
        for (var i = 0; i < titlesArray!.count; i++)
            {
                let tempLabel = self.createLabelWithTitlesIndex(i, textColor: titlesCustomeColor!)
                self.addSubview(tempLabel)
                labelMutableArray?.addObject(tempLabel)
            }
    }
    
    //创建高亮使用 label
    func createTopLables()
    {
        let heightLightViewFrame = CGRectMake(0, 0, lableWidth!, viewHeight!)
        heightLightView = UIView.init(frame: heightLightViewFrame)
        heightLightView!.clipsToBounds = true;
        heightLightView?.layer.cornerRadius=20
        heightLightView?.backgroundColor=backgroundHeightLightColor
        
        heightTopView = UIView.init(frame:CGRectMake(0, 0,viewWidth!,viewHeight!))
        for (var i = 0; i < titlesArray!.count; i++)
        {
            let label = self.createLabelWithTitlesIndex(i, textColor: titlesHeightLightColor!)
            heightTopView!.addSubview(label)
        }
        heightLightView!.addSubview(heightTopView!)
        self.addSubview(heightLightView!);
    }
    
    //  创建按钮
    func createTopButtons()
    {
        for (var i = 0; i < titlesArray!.count; i++)
            {
                let tempFrame = self.countCurrentRectWithIndex(i)
                let tempButton = UIButton.init(frame: tempFrame)
                tempButton.tag = i;
                tempButton.addTarget(self, action:"tapButton:", forControlEvents:UIControlEvents.TouchUpInside)
                self.addSubview(tempButton)
            }
    }
    
    //给按钮绑定的方法
    func tapButton(sender:UIButton)
    {
        if (buttonBlock != nil  && sender.tag < titlesArray!.count)
        {
            buttonBlock!(tag: sender.tag,str:titlesArray![sender.tag] as! String);
        }
        
        let frame = self.countCurrentRectWithIndex(sender.tag)
        let changeFrame = self.countCurrentRectWithIndex(-sender.tag)
        
        UIView.animateWithDuration(duration!, animations: { () -> Void in
            self.heightLightView!.frame = frame
            self.heightTopView!.frame = changeFrame
            }){ (finished:Bool) -> Void in
                
                self.shakeAnimationForView(self.heightLightView!)
        }
    }

    //抖动效果
    func shakeAnimationForView(view:UIView)
    {
        let viewLayer = view.layer;
        let position = viewLayer.position;
        let x = CGPointMake(position.x + 1, position.y);
        let y = CGPointMake(position.x - 1, position.y);
        let animation=CABasicAnimation(keyPath:"position")
        animation.timingFunction=CAMediaTimingFunction.init(name:kCAMediaTimingFunctionDefault)
        animation.fromValue=NSValue(CGPoint: x)
        animation.toValue=NSValue(CGPoint: y)
        animation.autoreverses=true
        animation.duration=0.06
        animation.repeatCount=3
        viewLayer.addAnimation(animation, forKey: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
