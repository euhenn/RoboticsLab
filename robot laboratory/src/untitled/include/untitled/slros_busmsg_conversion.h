#ifndef _SLROS_BUSMSG_CONVERSION_H_
#define _SLROS_BUSMSG_CONVERSION_H_

#include <ros/ros.h>
#include <geometry_msgs/Vector3.h>
#include "untitled_types.h"
#include "slros_msgconvert_utils.h"


void convertFromBus(geometry_msgs::Vector3* msgPtr, SL_Bus_untitled_geometry_msgs_Vector3 const* busPtr);
void convertToBus(SL_Bus_untitled_geometry_msgs_Vector3* busPtr, geometry_msgs::Vector3 const* msgPtr);


#endif
