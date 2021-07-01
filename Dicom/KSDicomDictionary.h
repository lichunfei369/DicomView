 
//

#ifndef __DICOM_DICTIONARY_H__
#define __DICOM_DICTIONARY_H__

#import <Foundation/Foundation.h>

@interface KSDicomDictionary : NSObject
{
    NSDictionary *dictionary;
}

+ (id) sharedInstance;

- (NSString *) valueForKey:(NSString *)key;

@end

#endif //__DICOM_DICTIONARY_H__
