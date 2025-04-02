//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// File: untitled.cpp
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
#include "untitled.h"
#include "rtwtypes.h"
#include "untitled_types.h"
#include "untitled_private.h"
#include "untitled_dt.h"

// Block signals (default storage)
B_untitled_T untitled_B;

// Block states (default storage)
DW_untitled_T untitled_DW;

// Real-time model
RT_MODEL_untitled_T untitled_M_ = RT_MODEL_untitled_T();
RT_MODEL_untitled_T *const untitled_M = &untitled_M_;

// Model step function
void untitled_step(void)
{
  SL_Bus_untitled_geometry_msgs_Vector3 rtb_SourceBlock_o2_k_0;
  boolean_T b_varargout_1;

  // Reset subsysRan breadcrumbs
  srClearBC(untitled_DW.EnabledSubsystem_SubsysRanBC_l);

  // Reset subsysRan breadcrumbs
  srClearBC(untitled_DW.EnabledSubsystem_SubsysRanBC);

  // Outputs for Atomic SubSystem: '<Root>/Subscribe'
  // MATLABSystem: '<S3>/SourceBlock'
  b_varargout_1 = Sub_untitled_8.getLatestMessage(&rtb_SourceBlock_o2_k_0);

  // Outputs for Enabled SubSystem: '<S3>/Enabled Subsystem' incorporates:
  //   EnablePort: '<S5>/Enable'

  // Start for MATLABSystem: '<S3>/SourceBlock'
  if (b_varargout_1) {
    // SignalConversion generated from: '<S5>/In1'
    untitled_B.In1_k = rtb_SourceBlock_o2_k_0;
    srUpdateBC(untitled_DW.EnabledSubsystem_SubsysRanBC_l);
  }

  // End of Start for MATLABSystem: '<S3>/SourceBlock'
  // End of Outputs for SubSystem: '<S3>/Enabled Subsystem'
  // End of Outputs for SubSystem: '<Root>/Subscribe'

  // SignalConversion generated from: '<Root>/Bus Selector'
  untitled_B.X = untitled_B.In1_k.X;

  // Outputs for Atomic SubSystem: '<Root>/Subscribe1'
  // MATLABSystem: '<S4>/SourceBlock'
  b_varargout_1 = Sub_untitled_13.getLatestMessage(&rtb_SourceBlock_o2_k_0);

  // Outputs for Enabled SubSystem: '<S4>/Enabled Subsystem' incorporates:
  //   EnablePort: '<S6>/Enable'

  // Start for MATLABSystem: '<S4>/SourceBlock'
  if (b_varargout_1) {
    // SignalConversion generated from: '<S6>/In1'
    untitled_B.In1 = rtb_SourceBlock_o2_k_0;
    srUpdateBC(untitled_DW.EnabledSubsystem_SubsysRanBC);
  }

  // End of Start for MATLABSystem: '<S4>/SourceBlock'
  // End of Outputs for SubSystem: '<S4>/Enabled Subsystem'
  // End of Outputs for SubSystem: '<Root>/Subscribe1'

  // SignalConversion generated from: '<Root>/Bus Selector1'
  untitled_B.X_h = untitled_B.In1.X;

  // SignalConversion generated from: '<Root>/Bus Selector'
  untitled_B.Y = untitled_B.In1_k.Y;

  // SignalConversion generated from: '<Root>/Bus Selector1'
  untitled_B.Y_i = untitled_B.In1.Y;

  // External mode
  rtExtModeUploadCheckTrigger(1);

  {                                    // Sample time: [0.01s, 0.0s]
    rtExtModeUpload(0, (real_T)untitled_M->Timing.taskTime0);
  }

  // signal main to stop simulation
  {                                    // Sample time: [0.01s, 0.0s]
    if ((rtmGetTFinal(untitled_M)!=-1) &&
        !((rtmGetTFinal(untitled_M)-untitled_M->Timing.taskTime0) >
          untitled_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(untitled_M, "Simulation finished");
    }

    if (rtmGetStopRequested(untitled_M)) {
      rtmSetErrorStatus(untitled_M, "Simulation finished");
    }
  }

  // Update absolute time for base rate
  // The "clockTick0" counts the number of times the code of this task has
  //  been executed. The absolute time is the multiplication of "clockTick0"
  //  and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
  //  overflow during the application lifespan selected.

  untitled_M->Timing.taskTime0 =
    ((time_T)(++untitled_M->Timing.clockTick0)) * untitled_M->Timing.stepSize0;
}

// Model initialize function
void untitled_initialize(void)
{
  // Registration code
  rtmSetTFinal(untitled_M, -1);
  untitled_M->Timing.stepSize0 = 0.01;

  // External mode info
  untitled_M->Sizes.checksums[0] = (1258343823U);
  untitled_M->Sizes.checksums[1] = (4149906675U);
  untitled_M->Sizes.checksums[2] = (4083769477U);
  untitled_M->Sizes.checksums[3] = (1317549550U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[10];
    untitled_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    systemRan[3] = &rtAlwaysEnabled;
    systemRan[4] = (sysRanDType *)&untitled_DW.EnabledSubsystem_SubsysRanBC_l;
    systemRan[5] = &rtAlwaysEnabled;
    systemRan[6] = &rtAlwaysEnabled;
    systemRan[7] = (sysRanDType *)&untitled_DW.EnabledSubsystem_SubsysRanBC;
    systemRan[8] = &rtAlwaysEnabled;
    systemRan[9] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(untitled_M->extModeInfo,
      &untitled_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(untitled_M->extModeInfo, untitled_M->Sizes.checksums);
    rteiSetTPtr(untitled_M->extModeInfo, rtmGetTPtr(untitled_M));
  }

  // data type transition information
  {
    static DataTypeTransInfo dtInfo;
    untitled_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 22;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    // Block I/O transition table
    dtInfo.BTransTable = &rtBTransTable;
  }

  {
    int32_T i;
    char_T b_zeroDelimTopic_0[26];
    char_T b_zeroDelimTopic[25];
    static const char_T b_zeroDelimTopic_1[25] = "/turtlebot_05/cmd_wheels";
    static const char_T b_zeroDelimTopic_2[26] = "/turtlebot_05/wheelSpeeds";

    // SystemInitialize for Atomic SubSystem: '<Root>/Publish'
    // Start for MATLABSystem: '<S2>/SinkBlock'
    untitled_DW.obj.matlabCodegenIsDeleted = false;
    untitled_DW.obj.isInitialized = 1;
    for (i = 0; i < 25; i++) {
      b_zeroDelimTopic[i] = b_zeroDelimTopic_1[i];
    }

    Pub_untitled_5.createPublisher(&b_zeroDelimTopic[0], 1);
    untitled_DW.obj.isSetupComplete = true;

    // End of SystemInitialize for SubSystem: '<Root>/Publish'

    // SystemInitialize for Atomic SubSystem: '<Root>/Subscribe'
    // Start for MATLABSystem: '<S3>/SourceBlock'
    untitled_DW.obj_e.matlabCodegenIsDeleted = false;
    untitled_DW.obj_e.isInitialized = 1;
    for (i = 0; i < 25; i++) {
      b_zeroDelimTopic[i] = b_zeroDelimTopic_1[i];
    }

    Sub_untitled_8.createSubscriber(&b_zeroDelimTopic[0], 1);
    untitled_DW.obj_e.isSetupComplete = true;

    // End of Start for MATLABSystem: '<S3>/SourceBlock'
    // End of SystemInitialize for SubSystem: '<Root>/Subscribe'

    // SystemInitialize for Atomic SubSystem: '<Root>/Subscribe1'
    // Start for MATLABSystem: '<S4>/SourceBlock'
    untitled_DW.obj_l.matlabCodegenIsDeleted = false;
    untitled_DW.obj_l.isInitialized = 1;
    for (i = 0; i < 26; i++) {
      b_zeroDelimTopic_0[i] = b_zeroDelimTopic_2[i];
    }

    Sub_untitled_13.createSubscriber(&b_zeroDelimTopic_0[0], 1);
    untitled_DW.obj_l.isSetupComplete = true;

    // End of Start for MATLABSystem: '<S4>/SourceBlock'
    // End of SystemInitialize for SubSystem: '<Root>/Subscribe1'

    // ConstCode for Atomic SubSystem: '<Root>/Publish'
    // ConstCode for MATLABSystem: '<S2>/SinkBlock'
    Pub_untitled_5.publish(&untitled_ConstB.BusAssignment);

    // End of ConstCode for SubSystem: '<Root>/Publish'
  }
}

// Model terminate function
void untitled_terminate(void)
{
  // Terminate for Atomic SubSystem: '<Root>/Publish'
  // Terminate for MATLABSystem: '<S2>/SinkBlock'
  if (!untitled_DW.obj.matlabCodegenIsDeleted) {
    untitled_DW.obj.matlabCodegenIsDeleted = true;
  }

  // End of Terminate for MATLABSystem: '<S2>/SinkBlock'
  // End of Terminate for SubSystem: '<Root>/Publish'

  // Terminate for Atomic SubSystem: '<Root>/Subscribe'
  // Terminate for MATLABSystem: '<S3>/SourceBlock'
  if (!untitled_DW.obj_e.matlabCodegenIsDeleted) {
    untitled_DW.obj_e.matlabCodegenIsDeleted = true;
  }

  // End of Terminate for MATLABSystem: '<S3>/SourceBlock'
  // End of Terminate for SubSystem: '<Root>/Subscribe'

  // Terminate for Atomic SubSystem: '<Root>/Subscribe1'
  // Terminate for MATLABSystem: '<S4>/SourceBlock'
  if (!untitled_DW.obj_l.matlabCodegenIsDeleted) {
    untitled_DW.obj_l.matlabCodegenIsDeleted = true;
  }

  // End of Terminate for MATLABSystem: '<S4>/SourceBlock'
  // End of Terminate for SubSystem: '<Root>/Subscribe1'
}

//
// File trailer for generated code.
//
// [EOF]
//
