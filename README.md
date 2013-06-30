iOS7 Backport
=============

This is [iOS7](http://www.apple.com/ios/ios7/) API [bacport](http://en.wikipedia.org/wiki/Backporting) to [iOS6](http://www.apple.com/ios/ios6/).

### Goal
* backport useful features from iOS7 to iOS6 to simplify transition for developers without using any private API.
* backport should behave 100% same way on iOS6 as on iOS7 from developers and users perspective.  For example it is ok to add implementation of `-[NSTimer setTolerance:]` that does nothing.
* on iOS7 back ported API shouldn't have any effect on system.

### Why?
Not all users will update to iOS7 and developer life is hard enaugh :)

### Current backports table
<table>

  <tr>
    <th colspan="2"><a href="https://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/NSArray_Class/NSArray.html">NSArray</a></th>
  </tr>
  <tr>
    <td><a href="">-[NSArray firstObject]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  
  <tr>
    <th colspan="2"><a href="https://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIView_Class/UIView/UIView.html">UIView</a></th>
  </tr>
  <tr>
    <td><a href="">+[UIView performWithoutAnimation:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  <tr>
    <td><a href="">-[UIView drawViewHierarchyInRect:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  
  <tr>
    <th colspan="2"><a href="https://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/NSTimer_Class/Reference/NSTimer.html">NSTimer</a></th>
  </tr>
  <tr>
    <td><a href="">-[NSTimer tolerance]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  <tr>
    <td><a href="">-[NSTimer setTolerance:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>

  <tr>
    <th colspan="2"><a href="https://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/Reference/Reference.html">NSData</a></th>
  </tr>
  <tr>
    <td><a href="">-[NSData initWithBase64EncodedString:options:]</a></td>
    <td style="background-color: yellow;">In progress</td>
  </tr>
  <tr>
    <td><a href="">-[NSData base64EncodedStringWithOptions:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  <tr>
    <td><a href="">-[NSData initWithBase64EncodedData:options:]</a></td>
    <td style="background-color: yellow;">In progress</td>
  </tr>
  <tr>
    <td><a href="">-[NSData base64EncodedDataWithOptions:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>

  <tr>
    <th colspan="2"><a href="https://developer.apple.com/library/ios/#documentation/GameKit/Reference/GKLocalPlayer_Ref/Reference/Reference.html">GKLocalPlayer</a></th>
  </tr>
  <tr>
    <td><a href="">-[GKLocalPlayer registerListener:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  <tr>
    <td><a href="">-[GKLocalPlayer unregisterListener:]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>
  <tr>
    <td><a href="">-[GKLocalPlayer unregisterAllListeners]</a></td>
    <td style="background-color: green;">Done.</td>
  </tr>

</table>