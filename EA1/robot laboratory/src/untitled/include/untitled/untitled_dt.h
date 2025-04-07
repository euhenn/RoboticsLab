//
//  untitled_dt.h
//
//  Academic License - for use in teaching, academic research, and meeting
//  course requirements at degree granting institutions only.  Not for
//  government, commercial, or other organizational use.
//
//  Code generation for model "untitled".
//
//  Model version              : 1.0
//  Simulink Coder version : 24.2 (R2024b) 21-Jun-2024
//  C++ source code generated on : Mon Mar 31 11:42:55 2025
//
//  Target selection: ert.tlc
//  Embedded hardware selection: Generic->Unspecified (assume 32-bit Generic)
//  Code generation objectives: Unspecified
//  Validation result: Not run


#include "ext_types.h"

// data type size table
static uint_T rtDataTypeSizes[] = {
  sizeof(real_T),
  sizeof(real32_T),
  sizeof(int8_T),
  sizeof(uint8_T),
  sizeof(int16_T),
  sizeof(uint16_T),
  sizeof(int32_T),
  sizeof(uint32_T),
  sizeof(boolean_T),
  sizeof(fcn_call_T),
  sizeof(int_T),
  sizeof(pointer_T),
  sizeof(action_T),
  2*sizeof(uint32_T),
  sizeof(int32_T),
  sizeof(SL_Bus_untitled_geometry_msgs_Vector3),
  sizeof(ros_slroscpp_internal_block_P_T),
  sizeof(ros_slroscpp_internal_block_S_T),
  sizeof(uint_T),
  sizeof(char_T),
  sizeof(uchar_T),
  sizeof(time_T)
};

// data type name table
static const char_T * rtDataTypeNames[] = {
  "real_T",
  "real32_T",
  "int8_T",
  "uint8_T",
  "int16_T",
  "uint16_T",
  "int32_T",
  "uint32_T",
  "boolean_T",
  "fcn_call_T",
  "int_T",
  "pointer_T",
  "action_T",
  "timer_uint32_pair_T",
  "physical_connection",
  "SL_Bus_untitled_geometry_msgs_Vector3",
  "ros_slroscpp_internal_block_P_T",
  "ros_slroscpp_internal_block_S_T",
  "uint_T",
  "char_T",
  "uchar_T",
  "time_T"
};

// data type transitions for block I/O structure
static DataTypeTransition rtBTransitions[] = {
  { (char_T *)(&untitled_B.In1), 15, 0, 2 },

  { (char_T *)(&untitled_B.X), 0, 0, 4 }
  ,

  { (char_T *)(&untitled_DW.obj), 16, 0, 1 },

  { (char_T *)(&untitled_DW.obj_l), 17, 0, 2 },

  { (char_T *)(&untitled_DW.Scope_PWORK.LoggedData[0]), 11, 0, 2 },

  { (char_T *)(&untitled_DW.EnabledSubsystem_SubsysRanBC), 2, 0, 2 }
};

// data type transition table for block I/O structure
static DataTypeTransitionTable rtBTransTable = {
  6U,
  rtBTransitions
};

// [EOF] untitled_dt.h
