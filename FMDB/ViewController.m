//
//  ViewController.m
//  FMDB
//
//  Created by 徐继垚 on 15/6/4.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImageManager.h>
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    
     
    DXDBmanager * dbmanager = [DXDBmanager shareManager];
    
    
    [dbmanager createDB];
    [dbmanager createTable];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    
    NSString * url = @"http://t11.baidu.com/it/u=4209496624,220690163&fm=32&s=0371C324C02394B4258D91B20300D085&w=533&h=800&img.JPEG";
    
  [manager downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
      
  } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                   NSData * imagedata = UIImageJPEGRepresentation(image, 0);
      [dbmanager addFileToDBWithData:imagedata];
  }];
    
    NSMutableArray * array =   [dbmanager searchFromDB];
    NSLog(@"%@" , array);
    
    Person * model = [[Person alloc]init];
    if (array.count != 0) {
        model = [array objectAtIndex:0];
        
    }
   
    self.label1.text = model.name;
    self.label2.text = [NSString stringWithFormat:@"%d",model.age];
    self.userimage.image = [UIImage imageWithData:model.imagedata];
    

    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
