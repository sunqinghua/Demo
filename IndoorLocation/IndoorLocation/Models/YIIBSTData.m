//
//  YIIBSTData.m
//  YIVasMobile
//  区域统计信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBSTData.h"

@implementation YIIBSTData
- (NSDictionary *)makeDic
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    switch (_sid) {
        case 10006:
            return @{@"sid": [NSNumber numberWithInt:_sid],
                     @"placeid": [NSNumber numberWithInt:_placeid],
                     @"edgeid": [NSNumber numberWithInt:_edgeid],
                     @"gathertime": [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_gathertime]],
                     @"staytime": [NSNumber numberWithInt:_staytime]};
        case 10004:
            return @{@"sid": [NSNumber numberWithInt:_sid],
                     @"placeid": [NSNumber numberWithInt:_placeid],
                     @"edgeid": [NSNumber numberWithInt:_edgeid],
                     @"gathertime": [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_gathertime]]};
        case 10005:
            return @{@"sid": [NSNumber numberWithInt:_sid],
                     @"placeid": [NSNumber numberWithInt:_placeid],
                     @"edgeid": [NSNumber numberWithInt:_edgeid],
                     @"gathertime": [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_gathertime]]};
        case 10007:
            return @{@"sid": [NSNumber numberWithInt:_sid],
                     @"placeid": [NSNumber numberWithInt:_placeid],
                     @"activityid": [NSNumber numberWithInt:_activityid],
                     @"gathertime": [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_gathertime]]};
        default:
            return nil;
    }
}
@end
