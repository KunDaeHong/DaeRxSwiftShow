//
//  opencvWrapper.h
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/01/13.
//

#import <Foundation/Foundation.h>
#import "opencvWrapper.h"

NS_ASSUME_NONNULL_BEGIN

@interface opencvWrapper : NSObject

- (void)processMotion:(CGImage *)image;
+ (NSString *)openCVVersion;

@end

NS_ASSUME_NONNULL_END
