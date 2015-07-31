//
//  ViewController.m
//  CoreBluetooth通讯
//
//  Created by admin on 15/7/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

/*
 *
 A.外围设备
 
 创建一个外围设备通常分为以下几个步骤：
 
 创建外围设备CBPeripheralManager对象并指定代理。
 创建特征CBCharacteristic、服务CBSerivce并添加到外围设备
 外围设备开始广播服务（startAdvertisting:）。
 和中央设备CBCentral进行交互。
 
 */


#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralManagerDelegate,CBPeripheralDelegate>{
    CBPeripheral *_connectPeripheral;
    CBCharacteristic *_connectCharacteristic;
}
@property (nonatomic,strong) CBCentralManager *centralManager;


#define kPeripheralName @"Kenshin Cui's Device" //外围设备名称
#define kServiceUUID @"C4FB2349-72FE-4CA2-94D6-1F3CB16331EE" //服务的UUID
#define kCharacteristicUUID @"6A3E4B28-522D-4B3B-82A9-D5E2004534FC" //特征的UUID
@property (nonatomic,strong) CBPeripheralManager *peripheralManager;
@property (strong,nonatomic) NSMutableArray *centralM;//订阅此外围设备特征的中心设备
@property (strong,nonatomic) CBMutableCharacteristic *characteristicM;//特征
@property (strong,nonatomic) NSMutableArray *peripherals;//连接的外围设备


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPeripheralManager];
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)createPeripheralManager{
    self.peripheralManager=[[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)*.5, (self.view.frame.size.height-40)*.5, 100, 40)];
    btn.backgroundColor=[UIColor redColor];
    [btn setTitle:@"更新" forState:UIControlStateNormal];
    btn.tag=100;
    [btn addTarget:self action:@selector(updateCharacteristicValue) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

//更新特征值
-(void)updateCharacteristicValue{
    //特征值
    NSString *valueStr=[NSString stringWithFormat:@"%@ --%@",kPeripheralName,[NSDate   date]];
    NSData *value=[valueStr dataUsingEncoding:NSUTF8StringEncoding];
    //更新特征值
    [self.peripheralManager updateValue:value forCharacteristic:self.characteristicM onSubscribedCentrals:nil];
   // [self writeToLog:[NSString stringWithFormat:@"更新特征值：%@",valueStr]];
}

-(void)createCenteralManager{
    self.centralManager=[[CBCentralManager alloc]initWithDelegate:self queue:nil];
    self.peripherals=[NSMutableArray array];
    
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)*.5, (self.view.frame.size.height-40)*.5, 100, 40)];
    btn.backgroundColor=[UIColor redColor];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    btn.tag=100;
    [btn addTarget:self action:@selector(sendDataToPeripheral) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)sendDataToPeripheral{
    //特征值
    NSString *valueStr=[NSString stringWithFormat:@"%@ --%@",kPeripheralName,[NSDate   date]];
    NSData *value=[valueStr dataUsingEncoding:NSUTF8StringEncoding];
    [_connectPeripheral writeValue:value forCharacteristic:_connectCharacteristic type:CBCharacteristicWriteWithResponse];
    
}

#pragma mark - 1.中心服务器状态更新后
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"BLE已打开.");
            //[self writeToLog:@"BLE已打开."];
            //扫描外围设备
            NSLog(@"BLE开始扫描");
            [central scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
            break;
            
        default:
            NSLog(@"此设备不支持BLE或未打开蓝牙功能，无法作为外围设备.");
            //[self writeToLog:@"此设备不支持BLE或未打开蓝牙功能，无法作为外围设备."];
            break;
    }
}

#pragma mark  2.扫描外围设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"发现外围设备...%@",RSSI);
    //[self writeToLog:@"发现外围设备..."];
    //停止扫描
    [self.centralManager stopScan];
    //连接外围设备
    if (peripheral) {
        //添加保存外围设备，注意如果这里不保存外围设备（或者说peripheral没有一个强引用，无法到达连接成功（或失败）的代理方法，因为在此方法调用完就会被销毁
        
        NSLog(@"开始连接外围设备...");
        if(![self.peripherals containsObject:peripheral]){
            [self.peripherals addObject:peripheral];
        }
        
        //[self writeToLog:@"开始连接外围设备..."];
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
    
}

#pragma mark 3.连接到外围设备成功
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"连接外围设备成功!");
//    [self writeToLog:@"连接外围设备成功!"];
    //设置外围设备的代理为当前视图控制器
    _connectPeripheral=peripheral;
    peripheral.delegate=self;
    //外围设备开始寻找服务
    [peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
}
#pragma mark 4.连接外围设备失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"连接外围设备失败!");
   // [self writeToLog:@"连接外围设备失败!"];
}

#pragma mark 5.连接到外围设备后-》寻找到外围设备服务后
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    //[self writeToLog:@"已发现可用服务..."];
    if(error){
        NSLog(@"外围设备寻找服务过程中发生错误，错误信息：%@",error.localizedDescription);
        //[self writeToLog:[NSString stringWithFormat:@"外围设备寻找服务过程中发生错误，错误信息：%@",error.localizedDescription]];
    }
    //遍历查找到的服务
    CBUUID *serviceUUID=[CBUUID UUIDWithString:kServiceUUID];
    CBUUID *characteristicUUID=[CBUUID UUIDWithString:kCharacteristicUUID];
    for (CBService *service in peripheral.services) {
        if([service.UUID isEqual:serviceUUID]){
            //外围设备查找指定服务中的特征
            NSLog(@"已发现可用服务...");
            [peripheral discoverCharacteristics:@[characteristicUUID] forService:service];
            
        }
    }
}

#pragma mark 6.监听外围设备特征
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error)
    {
        NSLog(@"Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    
    NSLog(@"服务：%@",service.UUID);
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        //发现特征
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]]) {
            NSLog(@"监听：%@",characteristic);//监听特征
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            _connectCharacteristic=characteristic;
        }
        
    }

}

#pragma mark 7.监听外围设备特征值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
    if (error==nil) {
        //调用下面的方法后 会调用到代理的- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
        [peripheral readValueForCharacteristic:characteristic];
    }
}

#pragma mark 8.外围设备特征值改变调用
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSData *data=characteristic.value;
    NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",str);
}



#pragma mark -  1.外围设备状态发生变化后调用
-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"BLE已打开.");
           // [self writeToLog:@"BLE已打开."];
            //添加服务
            [self setupService];
            break;
            
        default:
            NSLog(@"此设备不支持BLE或未打开蓝牙功能，无法作为外围设备.");
           // [self writeToLog:@"此设备不支持BLE或未打开蓝牙功能，无法作为外围设备."];
            break;
    }
}

#pragma mark 2.创建特征、服务并添加服务到外围设备
-(void)setupService{
    /*1.创建特征*/
    //创建特征的UUID对象
    CBUUID *characteristicUUID=[CBUUID UUIDWithString:kCharacteristicUUID];
    //特征值
    //    NSString *valueStr=kPeripheralName;
    //    NSData *value=[valueStr dataUsingEncoding:NSUTF8StringEncoding];
    //创建特征
    /** 参数
     * uuid:特征标识
     * properties:特征的属性，例如：可通知、可写、可读等
     * value:特征值
     * permissions:特征的权限
     */
    CBMutableCharacteristic *characteristicM=[[CBMutableCharacteristic alloc]initWithType:characteristicUUID properties: CBCharacteristicPropertyRead | CBCharacteristicPropertyWrite | CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsWriteable|CBAttributePermissionsReadEncryptionRequired];
    self.characteristicM=characteristicM;
    //    CBMutableCharacteristic *characteristicM=[[CBMutableCharacteristic alloc]initWithType:characteristicUUID properties:CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable];
    //    characteristicM.value=value;
    
    /*创建服务并且设置特征*/
    //创建服务UUID对象
    CBUUID *serviceUUID=[CBUUID UUIDWithString:kServiceUUID];
    //创建服务
    CBMutableService *serviceM=[[CBMutableService alloc]initWithType:serviceUUID primary:YES];
    //设置服务的特征
    [serviceM setCharacteristics:@[characteristicM]];
    
    
    /*将服务添加到外围设备*/
    [self.peripheralManager addService:serviceM];
}

#pragma mark 3.外围设备添加服务后调用
-(void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    if (error) {
        NSLog(@"向外围设备添加服务失败，错误详情：%@",error.localizedDescription);
       // [self writeToLog:[NSString stringWithFormat:@"向外围设备添加服务失败，错误详情：%@",error.localizedDescription]];
        return;
    }
    
    //添加服务后开始广播
    NSDictionary *dic=@{CBAdvertisementDataLocalNameKey:kPeripheralName};//广播设置
    [self.peripheralManager startAdvertising:dic];//开始广播
    NSLog(@"向外围设备添加了服务并开始广播...");
   // [self writeToLog:@"向外围设备添加了服务并开始广播..."];
}

#pragma mark -4.启动广播回调
-(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    if (error) {
        NSLog(@"启动广播过程中发生错误，错误信息：%@",error.localizedDescription);
        //[self writeToLog:[NSString stringWithFormat:@"启动广播过程中发生错误，错误信息：%@",error.localizedDescription]];
        return;
    }
    NSLog(@"启动广播...");
    //[self writeToLog:@"启动广播..."];
}

#pragma mark -5.中心设备订阅特征
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic{
    NSLog(@"中心设备：%@ 已订阅特征：%@.",central,characteristic);
    //[self writeToLog:[NSString stringWithFormat:@"中心设备：%@ 已订阅特征：%@.",central.identifier.UUIDString,characteristic.UUID]];
    //发现中心设备并存储
    if (![self.centralM containsObject:central]) {
        [self.centralM addObject:central];
    }
    /*中心设备订阅成功后外围设备可以更新特征值发送到中心设备,一旦更新特征值将会触发中心设备的代理方法：
     -(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
     */
    
    //    [self updateCharacteristicValue];
    
}

#pragma mark 6.取消订阅特征
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic{
    NSLog(@"didUnsubscribeFromCharacteristic");
}

#pragma mark 7.接受中央设备发送的数据
-(void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests{
    CBATTRequest *request=requests[0];
    NSData *data=request.value;
    NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"didReceiveWriteRequests=%@",str);
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    NSLog(@"didReceiveReadRequest");
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral willRestoreState:(NSDictionary *)dict{
    NSLog(@"willRestoreState");
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"---didWriteValueForCharacteristic-----,error=%@",error.userInfo);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
