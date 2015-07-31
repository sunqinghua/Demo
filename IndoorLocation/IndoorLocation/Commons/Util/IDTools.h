//
//  SvUDIDTools.h
//  SvUDID
//
//  Created by  maple on 8/18/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IDTools : NSObject

+ (NSString*)idString;

+ (NSString*)apiUrl;

+ (NSString*)firstSetupDate;

+ (NSString *)dateToQueryString:(NSDate *)date;

+ (NSString *)dateToString:(NSDate *)date;

+ (NSDate *)dateFromString2:(NSString *)date;

+ (NSDate *)dateFromString:(NSString *)date;

+ (NSString *)devId;

+ (NSString*) uuid;

+ (NSInteger)timeout;

+ (NSDate *)getTheDate:(NSDate *)theDate numMonth:(NSInteger)num;

@end
