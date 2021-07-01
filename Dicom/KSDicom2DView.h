


#import <UIKit/UIKit.h>



@interface KSDicom2DView : UIView
{
    NSInteger hOffset;
    NSInteger vOffset;
    NSInteger hMax;
    NSInteger vMax;
    NSInteger imgWidth;
    NSInteger imgHeight;
    NSInteger panWidth;
    NSInteger panHeight;
    BOOL newImage;
    
    // For Window Level
    //
    NSInteger winMin;
    NSInteger winMax;
    NSInteger winCenter;
    NSInteger winWidth;
    NSInteger winShr1;
    NSInteger deltaX;
    NSInteger deltaY;
    
    double changeValWidth;
    double changeValCentre;
    BOOL signed16Image;
    BOOL imageAvailable;
    
    Byte * pix8;
    ushort * pix16;
    Byte * pix24;
    
    Byte * lut8;
    Byte * lut16;
    
    CGColorSpaceRef colorspace;
    CGContextRef bitmapContext;
    CGImageRef bitmapImage;
}

@property (nonatomic, assign) BOOL signed16Image;
@property (nonatomic, assign) NSInteger winCenter;
@property (nonatomic, assign) NSInteger winWidth;
@property (nonatomic, assign) double changeValWidth;
@property (nonatomic, assign) double changeValCentre;




- (void)setPixels8:(Byte *)pixel
             width:(NSInteger)width
            height:(NSInteger)height
       windowWidth:(double)winW 
      windowCenter:(double)winC 
   samplesPerPixel:(NSInteger)spp
       resetScroll:(BOOL)reset;

- (void)setPixels16:(ushort *)pixel
              width:(NSInteger)width
             height:(NSInteger)height
        windowWidth:(double)winW 
       windowCenter:(double)winC 
    samplesPerPixel:(NSInteger)spp
        resetScroll:(BOOL)reset;

- (UIImage *)dicomImage;

@end
