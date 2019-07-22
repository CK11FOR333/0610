//
//  CafeRealm.h
//  0610
//
//  Created by Chris on 2019/7/22.
//  Copyright © 2019 user. All rights reserved.
//

#import <Realm/Realm.h>

// 使用者帳號資訊
@interface CafeRealm : RLMObject

@property NSString *ID;
@property NSString *mrt;
@property NSString *url;
@property NSString *city;
@property NSString *name;
@property NSString *socket;
@property NSString *address;
@property NSString *longitude;
@property NSString *latitude;
@property NSString *limited_time;
@property NSString *standing_desk;

@property NSInteger wifi;
@property NSInteger seat;
@property NSInteger quiet;
@property NSInteger tasty;
@property NSInteger cheap;
@property NSInteger music;

@end
