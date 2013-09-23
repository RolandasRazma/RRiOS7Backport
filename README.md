iOS7 Backport
=============

This is [iOS7](http://www.apple.com/ios/ios7/) API [backport](http://en.wikipedia.org/wiki/Backporting) to [iOS6](http://www.apple.com/ios/ios6/).

### Goal
* backport useful features from iOS7 to iOS6 to simplify transition for developers without using any private API.
* backport should behave 100% same way on iOS6 as on iOS7 from developers and users perspective.  For example it is ok to add implementation of `-[NSTimer setTolerance:]` that does nothing.
* on iOS7 back ported API shouldn't have any effect on system - default iOS implementation should be used.

### Why?
Not all users will update to iOS7 and developer life is hard enaugh :)

### How
Add project as library, setup `Build Phases`, add `-ObjC` to `Other Linker Flags`

### Current backports table
<table>
  <!-- NSArray -->
  <tr>
    <th colspan="2"><a href="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSArray_Class/NSArray.html">NSArray</a></th>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSArray_Class/NSArray.html#//apple_ref/occ/instm/NSArray/firstObject">-[NSArray firstObject]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  
  <!-- UIView -->
  <tr>
    <th colspan="2"><a href="https://developer.apple.com/library/ios/documentation/uikit/reference/uiview_class/UIView/UIView.html">UIView</a></th>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/library/ios/documentation/uikit/reference/uiview_class/UIView/UIView.html#//apple_ref/occ/clm/UIView/performWithoutAnimation:">+[UIView performWithoutAnimation:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/library/ios/documentation/uikit/reference/uiview_class/UIView/UIView.html#//apple_ref/occ/instm/UIView/drawViewHierarchyInRect:afterScreenUpdates:">-[UIView drawViewHierarchyInRect:afterScreenUpdates:]</a></td>
    <td style="background-color: yellow;">Done.</td>
  </tr>
  
  <!-- UITableView -->
  <tr>
      <th colspan="2"><a href="https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableView_Class/Reference/Reference.html">UITableView</a></th>
  </tr>
  <tr>
      <td><a href="https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableView_Class/Reference/Reference.html#//apple_ref/occ/instp/UITableView/estimatedRowHeight">-[UITableView estimatedRowHeight]</a></td>
      <td style="background-color: yellow;">Done.</td>
  </tr>
  
  <!-- UINavigationController -->
  <tr>
      <th colspan="2"><a href="https://developer.apple.com/library/ios/documentation/UIKit/Reference/UINavigationController_Class/Reference/Reference.html">UINavigationController</a></th>
  </tr>
  <tr>
      <td><a href="https://developer.apple.com/library/ios/documentation/UIKit/Reference/UINavigationController_Class/Reference/Reference.html#//apple_ref/occ/instp/UINavigationController/interactivePopGestureRecognizer">-[UINavigationController interactivePopGestureRecognizer]</a></td>
      <td style="background-color: yellow;">Done.</td>
  </tr>
  
  <!-- NSTimer -->
  <tr>
    <th colspan="2"><a href="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSTimer_Class/Reference/NSTimer.html">NSTimer</a></th>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSTimer_Class/Reference/NSTimer.html#//apple_ref/occ/instm/NSTimer/tolerance">-[NSTimer tolerance]</a></td>
    <td style="background-color: yellow;">Done.</td>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSTimer_Class/Reference/NSTimer.html#//apple_ref/occ/instm/NSTimer/setTolerance:">-[NSTimer setTolerance:]</a></td>
    <td style="background-color: yellow;">Done.</td>
  </tr>

  <!-- NSData -->
  <tr>
    <th colspan="2"><a href="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/Reference/Reference.html">NSData</a></th>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/Reference/Reference.html#//apple_ref/occ/instm/NSData/initWithBase64EncodedString:options:">-[NSData initWithBase64EncodedString:options:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/Reference/Reference.html#//apple_ref/occ/instm/NSData/base64EncodedStringWithOptions:">-[NSData base64EncodedStringWithOptions:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/Reference/Reference.html#//apple_ref/occ/instm/NSData/initWithBase64EncodedData:options:">-[NSData initWithBase64EncodedData:options:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/Reference/Reference.html#//apple_ref/occ/instm/NSData/base64EncodedDataWithOptions:">-[NSData base64EncodedDataWithOptions:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>

  <!-- GKLocalPlayer -->
  <tr>
    <th colspan="2"><a href="https://developer.apple.com/library/ios/documentation/GameKit/Reference/GKLocalPlayer_Ref/Reference/Reference.html">GKLocalPlayer</a></th>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/library/ios/documentation/GameKit/Reference/GKLocalPlayer_Ref/Reference/Reference.html#//apple_ref/occ/instm/GKLocalPlayer/registerListener:">-[GKLocalPlayer registerListener:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/library/ios/documentation/GameKit/Reference/GKLocalPlayer_Ref/Reference/Reference.html#//apple_ref/occ/instm/GKLocalPlayer/unregisterListener:">-[GKLocalPlayer unregisterListener:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  <tr>
    <td><a href="https://developer.apple.com/library/ios/documentation/GameKit/Reference/GKLocalPlayer_Ref/Reference/Reference.html#//apple_ref/occ/instm/GKLocalPlayer/unregisterAllListeners">-[GKLocalPlayer unregisterAllListeners]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>

</table>

### ContainerView
If you supporting `iOS5` check out [RRContainerView](https://github.com/RolandasRazma/RRContainerView) and [RRBaseInternationalization](https://github.com/RolandasRazma/RRBaseInternationalization)
