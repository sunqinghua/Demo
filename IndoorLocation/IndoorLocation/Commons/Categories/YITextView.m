//
//  YITextView.m
//  YIVasMobile
//
//  Created by wshm on 15/1/11.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import "YITextView.h"
#define PADDING 8.0f
@implementation YITextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 创建并初始化placeholder label
        _holderLabel = [[UILabel alloc] initWithFrame:CGRectMake(PADDING, PADDING,
                                                                 CGRectGetWidth(self.frame) - 2*PADDING ,
                                                                 CGRectGetHeight(self.frame)/2)];
        _holderLabel.numberOfLines = 0;
        _holderLabel.textColor = [UIColor lightGrayColor];
        _holderLabel.backgroundColor = [UIColor clearColor];
        _holderLabel.font = self.font;
        [self addSubview:_holderLabel];
        
        // Notifications
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidBeginEditing:)
                                                     name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:)
                                                     name:UITextViewTextDidChangeNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidEndEditing:)
                                                     name:UITextViewTextDidEndEditingNotification object:self];
    }
    return self;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)awakeFromNib {
    [super awakeFromNib];
    // 创建并初始化placeholder label
    _holderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _holderLabel.numberOfLines = 0;
    _holderLabel.textColor = [UIColor lightGrayColor];
    _holderLabel.backgroundColor = [UIColor clearColor];
    _holderLabel.font = self.font;
    [self addSubview:_holderLabel];
    
    // Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidBeginEditing:)
                                                 name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:)
                                                 name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidEndEditing:)
                                                 name:UITextViewTextDidEndEditingNotification object:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _holderLabel.frame = CGRectMake(PADDING, PADDING, CGRectGetWidth(self.frame) - 2*PADDING , CGRectGetHeight(self.frame)/2);
    [_holderLabel sizeToFit];
}

#pragma mark -
#pragma mark CITextView Notification Callbacks

- (void)textViewTextDidBeginEditing:(NSNotification *)notification {
    
}

- (void)textViewTextDidChange:(NSNotification *)notification {
    if ([self.text isEqualToString:@""] || nil == self.text) {
        _holderLabel.hidden = NO;
    }
    else {
        _holderLabel.hidden = YES;
    }
    
}

- (void)textViewTextDidEndEditing:(NSNotification *)notification {
    
}



- (void)setText:(NSString *)text {
    [super setText:text];
    if ([self.text isEqualToString:@""] || nil == self.text) {
        _holderLabel.hidden = NO;
    }
    else {
        _holderLabel.hidden = YES;
    }
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _holderLabel.font = font;
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (placeholder != _holderLabel.text) {
        _holderLabel.text = placeholder;
        [_holderLabel sizeToFit];
    }
}

- (NSString *)placeholder {
    return _holderLabel.text;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _holderLabel = nil;
    _placeholder = nil;
}
@end
