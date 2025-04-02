#include "slros_initialize.h"

ros::NodeHandle * SLROSNodePtr;
const std::string SLROSNodeName = "untitled";

// For Block untitled/Subscribe
SimulinkSubscriber<geometry_msgs::Vector3, SL_Bus_untitled_geometry_msgs_Vector3> Sub_untitled_8;

// For Block untitled/Subscribe1
SimulinkSubscriber<geometry_msgs::Vector3, SL_Bus_untitled_geometry_msgs_Vector3> Sub_untitled_13;

// For Block untitled/Publish
SimulinkPublisher<geometry_msgs::Vector3, SL_Bus_untitled_geometry_msgs_Vector3> Pub_untitled_5;

void slros_node_init(int argc, char** argv)
{
  ros::init(argc, argv, SLROSNodeName);
  SLROSNodePtr = new ros::NodeHandle();
}

