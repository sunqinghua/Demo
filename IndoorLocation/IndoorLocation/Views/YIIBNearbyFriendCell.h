//
//  YIIBNearbyFriendCell.h
//  YIVasMobile
//
//  Created by darren on 14-12-27.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YIIBNearbyFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@end
