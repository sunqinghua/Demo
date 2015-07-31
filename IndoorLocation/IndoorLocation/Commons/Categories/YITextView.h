//
//  YITextView.h
//  YIVasMobile
//
//  Created by wshm on 15/1/11.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YITextView : UITextView{
    NSString *_placeholder;
@private
    UILabel *_holderLabel;
}

@property(nonatomic, copy) NSString *placeholder;
@end
