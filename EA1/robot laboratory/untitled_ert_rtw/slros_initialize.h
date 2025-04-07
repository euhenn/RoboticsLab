#ifndef _SLROS_INITIALIZE_H_
#define _SLROS_INITIALIZE_H_

#include "slros_busmsg_conversion.h"
#include "slros_generic.h"
#include "untitled_types.h"

extern ros::NodeHandle * SLROSNodePtr;
extern const std::string SLROSNodeName;

// For Block untitled/Subscribe
extern SimulinkSubscriber<geometry_msgs::Vector3, SL_Bus_untitled_geometry_msgs_Vector3> Sub_untitled_8;

// For Block untitled/Subscribe1
extern SimulinkSubscriber<geometry_msgs::Vector3, SL_Bus_untitled_geometry_msgs_Vector3> Sub_untitled_13;

// For Block untitled/Publish
extern SimulinkPublisher<geometry_msgs::Vector3, SL_Bus_untitled_geometry_msgs_Vector3> Pub_untitled_5;

void slros_node_init(int argc, char** argv);

#endif
