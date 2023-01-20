//
//  opencvWrapper.m
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/01/13.
//

#import "opencvWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

using namespace std;
using namespace cv;

@implementation opencvWrapper

- (void)processMotion:(CGImage *) image{
    cv::Mat imageMat;
    
    int thresh = 23;
    int max_diff = 5;
    
    CGImage *a = image;
    CGImage *b = image;
    CGImage *c = image;
}

+ (NSString *)openCVVersion {
    return [NSString stringWithFormat:@"OpenCV Version %s", CV_VERSION];
}

@end
