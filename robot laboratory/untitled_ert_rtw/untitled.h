//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// File: untitled.h
//
// Code generated for Simulink model 'untitled'.
//
// Model version                  : 1.0
// Simulink Coder version         : 24.2 (R2024b) 21-Jun-2024
// C/C++ source code generated on : Mon Mar 31 11:42:55 2025
//
// Target selection: ert.tlc
// Embedded hardware selection: Generic->Unspecified (assume 32-bit Generic)
// Code generation objectives: Unspecified
// Validation result: Not run
//
#ifndef untitled_h_
#define untitled_h_
#include "rtwtypes.h"
#include "rtw_extmode.h"
#include "sysran_types.h"
#include "dt_info.h"
#include "ext_work.h"
#include "slros_initialize.h"
#include "untitled_types.h"
#include <float.h>
#include <stddef.h>

// Macros for accessing real-time model data structure
#ifndef rtmGetFinalTime
#define rtmGetFinalTime(rtm)           ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetRTWExtModeInfo
#define rtmGetRTWExtModeInfo(rtm)      ((rtm)->extModeInfo)
#endif

#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
#define rtmGetT(rtm)                   ((rtm)->Timing.taskTime0)
#endif

#ifndef rtmGetTFinal
#define rtmGetTFinal(rtm)              ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                (&(rtm)->Timing.taskTime0)
#endif

// Block signals (default storage)
struct B_untitled_T {
  SL_Bus_untitled_geometry_msgs_Vector3 In1;// '<S6>/In1'
  SL_Bus_untitled_geometry_msgs_Vector3 In1_k;// '<S5>/In1'
  real_T X;
  real_T X_h;
  real_T Y;
  real_T Y_i;
};

// Block states (default storage) for system '<Root>'
struct DW_untitled_T {
  ros_slroscpp_internal_block_P_T obj; // '<S2>/SinkBlock'
  ros_slroscpp_internal_block_S_T obj_l;// '<S4>/SourceBlock'
  ros_slroscpp_internal_block_S_T obj_e;// '<S3>/SourceBlock'
  struct {
    void *LoggedData[2];
  } Scope_PWORK;                       // '<Root>/Scope'

  int8_T EnabledSubsystem_SubsysRanBC; // '<S4>/Enabled Subsystem'
  int8_T EnabledSubsystem_SubsysRanBC_l;// '<S3>/Enabled Subsystem'
};

// Invariant block signals (default storage)
struct ConstB_untitled_T {
  SL_Bus_untitled_geometry_msgs_Vector3 BusAssignment;// '<Root>/Bus Assignment' 
};

// Real-time Model Data Structure
struct tag_RTM_untitled_T {
  const char_T *errorStatus;
  RTWExtModeInfo *extModeInfo;

  //
  //  Sizes:
  //  The following substructure contains sizes information
  //  for many of the model attributes such as inputs, outputs,
  //  dwork, sample times, etc.

  struct {
    uint32_T checksums[4];
  } Sizes;

  //
  //  SpecialInfo:
  //  The following substructure contains special information
  //  related to other components that are dependent on RTW.

  struct {
    const void *mappingInfo;
  } SpecialInfo;

  //
  //  Timing:
  //  The following substructure contains information regarding
  //  the timing information for the model.

  struct {
    time_T taskTime0;
    uint32_T clockTick0;
    time_T stepSize0;
    time_T tFinal;
    boolean_T stopRequestedFlag;
  } Timing;
};

// Block signals (default storage)
#ifdef __cplusplus

extern "C"
{

#endif

  extern struct B_untitled_T untitled_B;

#ifdef __cplusplus

}

#endif

// Block states (default storage)
extern struct DW_untitled_T untitled_DW;
extern const ConstB_untitled_T untitled_ConstB;// constant block i/o

#ifdef __cplusplus

extern "C"
{

#endif

  // Model entry point functions
  extern void untitled_initialize(void);
  extern void untitled_step(void);
  extern void untitled_terminate(void);

#ifdef __cplusplus

}

#endif

// Real-time Model object
#ifdef __cplusplus

extern "C"
{

#endif

  extern RT_MODEL_untitled_T *const untitled_M;

#ifdef __cplusplus

}

#endif

extern volatile boolean_T stopRequested;
extern volatile boolean_T runModel;

//-
//  The generated code includes comments that allow you to trace directly
//  back to the appropriate location in the model.  The basic format
//  is <system>/block_name, where system is the system number (uniquely
//  assigned by Simulink) and block_name is the name of the block.
//
//  Use the MATLAB hilite_system command to trace the generated code back
//  to the model.  For example,
//
//  hilite_system('<S3>')    - opens system 3
//  hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
//
//  Here is the system hierarchy for this model
//
//  '<Root>' : 'untitled'
//  '<S1>'   : 'untitled/Blank Message'
//  '<S2>'   : 'untitled/Publish'
//  '<S3>'   : 'untitled/Subscribe'
//  '<S4>'   : 'untitled/Subscribe1'
//  '<S5>'   : 'untitled/Subscribe/Enabled Subsystem'
//  '<S6>'   : 'untitled/Subscribe1/Enabled Subsystem'

#endif                                 // untitled_h_

//
// File trailer for generated code.
//
// [EOF]
//
