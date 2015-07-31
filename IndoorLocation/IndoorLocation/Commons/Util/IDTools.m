//
//  IDTools.m
//  SvUDID
//
//  Created by  maple on 8/18/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import "IDTools.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation IDTools

+ (NSString *)devId
{
    return [NSString stringWithFormat:@"%@|2|%@|%@", [IDTools idString2]==nil?[IDTools idString]:[IDTools idString2], [[UIDevice currentDevice] systemVersion], [IDTools firstSetupDate]];
}

+ (NSInteger)timeout
{
    return 30;
}

+ (NSString*)idString2
{
    NSString *udid = [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken2"];
//    NSLog(@"id : %@", udid);
    return udid;
}

+ (NSString*)idString
{
    NSString *udid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"];
    if (!udid) {
        
        NSString *sysVersion = [UIDevice currentDevice].systemVersion;
        CGFloat version = [sysVersion floatValue];
        
        if (version >= 7.0) {
            udid = [IDTools _UDID_iOS7];
        }
        else if (version >= 2.0) {
            udid = [IDTools uuid];
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:udid forKey:@"uuid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return udid;
}

+ (NSString*)apiUrl
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"api21"];
    if (!str) {

        str = @"http://www.admore.cn:10002/vas-openapi/api/";

        [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"api"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return str;
}

+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    //[dateFormatter release];
    
    return dateString;
}

+ (NSString *)dateToQueryString:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    //[dateFormatter release];
    
    return dateString;
}

+ (NSDate *)dateFromString:(NSString *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateString = [dateFormatter dateFromString:date];
    
    //[dateFormatter release];
    
    return dateString;
}

+ (NSDate *)dateFromString2:(NSString *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *dateString = [dateFormatter dateFromString:date];
    
    //[dateFormatter release];
    
    return dateString;
}

+ (NSString*)firstSetupDate
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"setupdate"];
    if (!str) {
        
        NSDate *date = [NSDate date];
        str = [IDTools dateToString:date];

        [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"setupdate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    return str;
}

/*
 * iOS 6.0
 * use wifi's mac address
 */
+ (NSString*)_UDID_iOS6
{
    return [IDTools getMacAddress];
}

+ (NSString*) uuid
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
   // return [result autorelease];
}

/*
 * iOS 7.0
 * Starting from iOS 7, the system always returns the value 02:00:00:00:00:00 
 * when you ask for the MAC address on any device.
 * use identifierForVendor
 */
+ (NSString*)_UDID_iOS7
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}


#pragma mark -
#pragma mark Helper Method for Get Mac Address

// from http://stackoverflow.com/questions/677530/how-can-i-programmatically-get-the-mac-address-of-an-iphone
+ (NSString *)getMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = nil;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        if (msgBuffer) {
            free(msgBuffer);
        }
        
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}

+ (NSDate *)getTheDate:(NSDate *)theDate numMonth:(NSInteger)num
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:theDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:num];
    [adcomps setDay:0];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:theDate options:0];
    
//    [comps release];
//    [adcomps release];
//    [calendar release];
    
    return newdate;
}

@end
