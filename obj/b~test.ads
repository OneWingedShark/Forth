pragma Ada_95;
with System;
package ada_main is
   pragma Warnings (Off);

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2014 (20140331)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_test" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#a41b1952#;
   pragma Export (C, u00001, "testB");
   u00002 : constant Version_32 := 16#fbff4c67#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#5c291747#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#efb50532#;
   pragma Export (C, u00004, "forthB");
   u00005 : constant Version_32 := 16#9d93590a#;
   pragma Export (C, u00005, "forthS");
   u00006 : constant Version_32 := 16#5fc8ae56#;
   pragma Export (C, u00006, "systemS");
   u00007 : constant Version_32 := 16#393398c1#;
   pragma Export (C, u00007, "system__exception_tableB");
   u00008 : constant Version_32 := 16#f1d1c843#;
   pragma Export (C, u00008, "system__exception_tableS");
   u00009 : constant Version_32 := 16#daf76b33#;
   pragma Export (C, u00009, "system__soft_linksB");
   u00010 : constant Version_32 := 16#1517cb64#;
   pragma Export (C, u00010, "system__soft_linksS");
   u00011 : constant Version_32 := 16#c8ed38da#;
   pragma Export (C, u00011, "system__parametersB");
   u00012 : constant Version_32 := 16#591236e4#;
   pragma Export (C, u00012, "system__parametersS");
   u00013 : constant Version_32 := 16#c96bf39e#;
   pragma Export (C, u00013, "system__secondary_stackB");
   u00014 : constant Version_32 := 16#f4a9613f#;
   pragma Export (C, u00014, "system__secondary_stackS");
   u00015 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00015, "adaS");
   u00016 : constant Version_32 := 16#39a03df9#;
   pragma Export (C, u00016, "system__storage_elementsB");
   u00017 : constant Version_32 := 16#720be452#;
   pragma Export (C, u00017, "system__storage_elementsS");
   u00018 : constant Version_32 := 16#eaff8cdc#;
   pragma Export (C, u00018, "ada__exceptionsB");
   u00019 : constant Version_32 := 16#6a2091f5#;
   pragma Export (C, u00019, "ada__exceptionsS");
   u00020 : constant Version_32 := 16#032105bb#;
   pragma Export (C, u00020, "ada__exceptions__last_chance_handlerB");
   u00021 : constant Version_32 := 16#2b293877#;
   pragma Export (C, u00021, "ada__exceptions__last_chance_handlerS");
   u00022 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00022, "system__exceptionsB");
   u00023 : constant Version_32 := 16#37abc3a0#;
   pragma Export (C, u00023, "system__exceptionsS");
   u00024 : constant Version_32 := 16#2652ec14#;
   pragma Export (C, u00024, "system__exceptions__machineS");
   u00025 : constant Version_32 := 16#b895431d#;
   pragma Export (C, u00025, "system__exceptions_debugB");
   u00026 : constant Version_32 := 16#ec2ab7e8#;
   pragma Export (C, u00026, "system__exceptions_debugS");
   u00027 : constant Version_32 := 16#570325c8#;
   pragma Export (C, u00027, "system__img_intB");
   u00028 : constant Version_32 := 16#5d134e94#;
   pragma Export (C, u00028, "system__img_intS");
   u00029 : constant Version_32 := 16#ff5c7695#;
   pragma Export (C, u00029, "system__tracebackB");
   u00030 : constant Version_32 := 16#77cc310b#;
   pragma Export (C, u00030, "system__tracebackS");
   u00031 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00031, "system__wch_conB");
   u00032 : constant Version_32 := 16#44b58c84#;
   pragma Export (C, u00032, "system__wch_conS");
   u00033 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00033, "system__wch_stwB");
   u00034 : constant Version_32 := 16#69a4a085#;
   pragma Export (C, u00034, "system__wch_stwS");
   u00035 : constant Version_32 := 16#9b29844d#;
   pragma Export (C, u00035, "system__wch_cnvB");
   u00036 : constant Version_32 := 16#4b023677#;
   pragma Export (C, u00036, "system__wch_cnvS");
   u00037 : constant Version_32 := 16#69adb1b9#;
   pragma Export (C, u00037, "interfacesS");
   u00038 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00038, "system__wch_jisB");
   u00039 : constant Version_32 := 16#cb722f56#;
   pragma Export (C, u00039, "system__wch_jisS");
   u00040 : constant Version_32 := 16#8cb17bcd#;
   pragma Export (C, u00040, "system__traceback_entriesB");
   u00041 : constant Version_32 := 16#ead9cec4#;
   pragma Export (C, u00041, "system__traceback_entriesS");
   u00042 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00042, "system__stack_checkingB");
   u00043 : constant Version_32 := 16#d177c5be#;
   pragma Export (C, u00043, "system__stack_checkingS");
   u00044 : constant Version_32 := 16#2a008521#;
   pragma Export (C, u00044, "forth__interpreterB");
   u00045 : constant Version_32 := 16#21f77d36#;
   pragma Export (C, u00045, "forth__interpreterS");
   u00046 : constant Version_32 := 16#034d7998#;
   pragma Export (C, u00046, "ada__tagsB");
   u00047 : constant Version_32 := 16#ce72c228#;
   pragma Export (C, u00047, "ada__tagsS");
   u00048 : constant Version_32 := 16#c3335bfd#;
   pragma Export (C, u00048, "system__htableB");
   u00049 : constant Version_32 := 16#db0a1dbc#;
   pragma Export (C, u00049, "system__htableS");
   u00050 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00050, "system__string_hashB");
   u00051 : constant Version_32 := 16#795476c2#;
   pragma Export (C, u00051, "system__string_hashS");
   u00052 : constant Version_32 := 16#0ece3cf9#;
   pragma Export (C, u00052, "system__unsigned_typesS");
   u00053 : constant Version_32 := 16#4266b2a8#;
   pragma Export (C, u00053, "system__val_unsB");
   u00054 : constant Version_32 := 16#1e66d1c2#;
   pragma Export (C, u00054, "system__val_unsS");
   u00055 : constant Version_32 := 16#27b600b2#;
   pragma Export (C, u00055, "system__val_utilB");
   u00056 : constant Version_32 := 16#f36818a8#;
   pragma Export (C, u00056, "system__val_utilS");
   u00057 : constant Version_32 := 16#d1060688#;
   pragma Export (C, u00057, "system__case_utilB");
   u00058 : constant Version_32 := 16#7bc1c781#;
   pragma Export (C, u00058, "system__case_utilS");
   u00059 : constant Version_32 := 16#1ac8b3b4#;
   pragma Export (C, u00059, "ada__text_ioB");
   u00060 : constant Version_32 := 16#ba9eea88#;
   pragma Export (C, u00060, "ada__text_ioS");
   u00061 : constant Version_32 := 16#1b5643e2#;
   pragma Export (C, u00061, "ada__streamsB");
   u00062 : constant Version_32 := 16#2564c958#;
   pragma Export (C, u00062, "ada__streamsS");
   u00063 : constant Version_32 := 16#db5c917c#;
   pragma Export (C, u00063, "ada__io_exceptionsS");
   u00064 : constant Version_32 := 16#9f23726e#;
   pragma Export (C, u00064, "interfaces__c_streamsB");
   u00065 : constant Version_32 := 16#bb1012c3#;
   pragma Export (C, u00065, "interfaces__c_streamsS");
   u00066 : constant Version_32 := 16#75131373#;
   pragma Export (C, u00066, "system__crtlS");
   u00067 : constant Version_32 := 16#967994fc#;
   pragma Export (C, u00067, "system__file_ioB");
   u00068 : constant Version_32 := 16#e3384250#;
   pragma Export (C, u00068, "system__file_ioS");
   u00069 : constant Version_32 := 16#b7ab275c#;
   pragma Export (C, u00069, "ada__finalizationB");
   u00070 : constant Version_32 := 16#19f764ca#;
   pragma Export (C, u00070, "ada__finalizationS");
   u00071 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00071, "system__finalization_rootB");
   u00072 : constant Version_32 := 16#103addc6#;
   pragma Export (C, u00072, "system__finalization_rootS");
   u00073 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00073, "interfaces__cB");
   u00074 : constant Version_32 := 16#3b563890#;
   pragma Export (C, u00074, "interfaces__cS");
   u00075 : constant Version_32 := 16#d0432c8d#;
   pragma Export (C, u00075, "system__img_enum_newB");
   u00076 : constant Version_32 := 16#3e84a896#;
   pragma Export (C, u00076, "system__img_enum_newS");
   u00077 : constant Version_32 := 16#a25be73b#;
   pragma Export (C, u00077, "system__os_libB");
   u00078 : constant Version_32 := 16#94c13856#;
   pragma Export (C, u00078, "system__os_libS");
   u00079 : constant Version_32 := 16#1a817b8e#;
   pragma Export (C, u00079, "system__stringsB");
   u00080 : constant Version_32 := 16#2177bf30#;
   pragma Export (C, u00080, "system__stringsS");
   u00081 : constant Version_32 := 16#906f0f88#;
   pragma Export (C, u00081, "system__file_control_blockS");
   u00082 : constant Version_32 := 16#a4371844#;
   pragma Export (C, u00082, "system__finalization_mastersB");
   u00083 : constant Version_32 := 16#2bde8716#;
   pragma Export (C, u00083, "system__finalization_mastersS");
   u00084 : constant Version_32 := 16#57a37a42#;
   pragma Export (C, u00084, "system__address_imageB");
   u00085 : constant Version_32 := 16#fe24336c#;
   pragma Export (C, u00085, "system__address_imageS");
   u00086 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00086, "system__img_boolB");
   u00087 : constant Version_32 := 16#aa11dfbd#;
   pragma Export (C, u00087, "system__img_boolS");
   u00088 : constant Version_32 := 16#d7aac20c#;
   pragma Export (C, u00088, "system__ioB");
   u00089 : constant Version_32 := 16#c18a5919#;
   pragma Export (C, u00089, "system__ioS");
   u00090 : constant Version_32 := 16#6d4d969a#;
   pragma Export (C, u00090, "system__storage_poolsB");
   u00091 : constant Version_32 := 16#aa9329d2#;
   pragma Export (C, u00091, "system__storage_poolsS");
   u00092 : constant Version_32 := 16#e34550ca#;
   pragma Export (C, u00092, "system__pool_globalB");
   u00093 : constant Version_32 := 16#c88d2d16#;
   pragma Export (C, u00093, "system__pool_globalS");
   u00094 : constant Version_32 := 16#3a4ba6c3#;
   pragma Export (C, u00094, "system__memoryB");
   u00095 : constant Version_32 := 16#06b5c862#;
   pragma Export (C, u00095, "system__memoryS");
   u00096 : constant Version_32 := 16#7b002481#;
   pragma Export (C, u00096, "system__storage_pools__subpoolsB");
   u00097 : constant Version_32 := 16#e3b008dc#;
   pragma Export (C, u00097, "system__storage_pools__subpoolsS");
   u00098 : constant Version_32 := 16#63f11652#;
   pragma Export (C, u00098, "system__storage_pools__subpools__finalizationB");
   u00099 : constant Version_32 := 16#fe2f4b3a#;
   pragma Export (C, u00099, "system__storage_pools__subpools__finalizationS");
   u00100 : constant Version_32 := 16#35d75542#;
   pragma Export (C, u00100, "forth__data_stackB");
   u00101 : constant Version_32 := 16#15d07397#;
   pragma Export (C, u00101, "forth__data_stackS");
   u00102 : constant Version_32 := 16#5e196e91#;
   pragma Export (C, u00102, "ada__containersS");
   u00103 : constant Version_32 := 16#af50e98f#;
   pragma Export (C, u00103, "ada__stringsS");
   u00104 : constant Version_32 := 16#261c554b#;
   pragma Export (C, u00104, "ada__strings__unboundedB");
   u00105 : constant Version_32 := 16#e303cf90#;
   pragma Export (C, u00105, "ada__strings__unboundedS");
   u00106 : constant Version_32 := 16#c093955c#;
   pragma Export (C, u00106, "ada__strings__searchB");
   u00107 : constant Version_32 := 16#c1ab8667#;
   pragma Export (C, u00107, "ada__strings__searchS");
   u00108 : constant Version_32 := 16#e2ea8656#;
   pragma Export (C, u00108, "ada__strings__mapsB");
   u00109 : constant Version_32 := 16#1e526bec#;
   pragma Export (C, u00109, "ada__strings__mapsS");
   u00110 : constant Version_32 := 16#374ed1bf#;
   pragma Export (C, u00110, "system__bit_opsB");
   u00111 : constant Version_32 := 16#0765e3a3#;
   pragma Export (C, u00111, "system__bit_opsS");
   u00112 : constant Version_32 := 16#12c24a43#;
   pragma Export (C, u00112, "ada__charactersS");
   u00113 : constant Version_32 := 16#4b7bb96a#;
   pragma Export (C, u00113, "ada__characters__latin_1S");
   u00114 : constant Version_32 := 16#5b9edcc4#;
   pragma Export (C, u00114, "system__compare_array_unsigned_8B");
   u00115 : constant Version_32 := 16#f6cbdfdb#;
   pragma Export (C, u00115, "system__compare_array_unsigned_8S");
   u00116 : constant Version_32 := 16#5f72f755#;
   pragma Export (C, u00116, "system__address_operationsB");
   u00117 : constant Version_32 := 16#4cc41065#;
   pragma Export (C, u00117, "system__address_operationsS");
   u00118 : constant Version_32 := 16#5073d598#;
   pragma Export (C, u00118, "system__machine_codeS");
   u00119 : constant Version_32 := 16#e5ac57f8#;
   pragma Export (C, u00119, "system__atomic_countersB");
   u00120 : constant Version_32 := 16#92b43a9c#;
   pragma Export (C, u00120, "system__atomic_countersS");
   u00121 : constant Version_32 := 16#ffe20862#;
   pragma Export (C, u00121, "system__stream_attributesB");
   u00122 : constant Version_32 := 16#e5402c91#;
   pragma Export (C, u00122, "system__stream_attributesS");
   u00123 : constant Version_32 := 16#507fa422#;
   pragma Export (C, u00123, "forth__stackB");
   u00124 : constant Version_32 := 16#dae6f7f2#;
   pragma Export (C, u00124, "forth__stackS");
   u00125 : constant Version_32 := 16#fd2ad2f1#;
   pragma Export (C, u00125, "gnatS");
   u00126 : constant Version_32 := 16#b48102f5#;
   pragma Export (C, u00126, "gnat__ioB");
   u00127 : constant Version_32 := 16#6227e843#;
   pragma Export (C, u00127, "gnat__ioS");
   u00128 : constant Version_32 := 16#ae73bf75#;
   pragma Export (C, u00128, "forth__typesB");
   u00129 : constant Version_32 := 16#60d5c4fb#;
   pragma Export (C, u00129, "forth__typesS");
   u00130 : constant Version_32 := 16#5d1b3d81#;
   pragma Export (C, u00130, "ada__strings__less_case_insensitiveB");
   u00131 : constant Version_32 := 16#9c017ef5#;
   pragma Export (C, u00131, "ada__strings__less_case_insensitiveS");
   u00132 : constant Version_32 := 16#8f637df8#;
   pragma Export (C, u00132, "ada__characters__handlingB");
   u00133 : constant Version_32 := 16#3b3f6154#;
   pragma Export (C, u00133, "ada__characters__handlingS");
   u00134 : constant Version_32 := 16#92f05f13#;
   pragma Export (C, u00134, "ada__strings__maps__constantsS");
   u00135 : constant Version_32 := 16#1c250432#;
   pragma Export (C, u00135, "forth__dictionaryB");
   u00136 : constant Version_32 := 16#ab26fbab#;
   pragma Export (C, u00136, "forth__dictionaryS");
   u00137 : constant Version_32 := 16#5c81e9ee#;
   pragma Export (C, u00137, "forth__dictionary__word_listB");
   u00138 : constant Version_32 := 16#30a0d935#;
   pragma Export (C, u00138, "forth__dictionary__word_listS");
   u00139 : constant Version_32 := 16#d9473c8c#;
   pragma Export (C, u00139, "ada__containers__red_black_treesS");
   u00140 : constant Version_32 := 16#06e2137b#;
   pragma Export (C, u00140, "system__assertionsB");
   u00141 : constant Version_32 := 16#924582c2#;
   pragma Export (C, u00141, "system__assertionsS");
   u00142 : constant Version_32 := 16#a6cec3cf#;
   pragma Export (C, u00142, "system__strings__stream_opsB");
   u00143 : constant Version_32 := 16#5ed775a4#;
   pragma Export (C, u00143, "system__strings__stream_opsS");
   u00144 : constant Version_32 := 16#9f609ffa#;
   pragma Export (C, u00144, "ada__streams__stream_ioB");
   u00145 : constant Version_32 := 16#3aff46f1#;
   pragma Export (C, u00145, "ada__streams__stream_ioS");
   u00146 : constant Version_32 := 16#5de653db#;
   pragma Export (C, u00146, "system__communicationB");
   u00147 : constant Version_32 := 16#6f11cd91#;
   pragma Export (C, u00147, "system__communicationS");
   u00148 : constant Version_32 := 16#ade42278#;
   pragma Export (C, u00148, "forth__vmB");
   u00149 : constant Version_32 := 16#f5a06d20#;
   pragma Export (C, u00149, "forth__vmS");
   u00150 : constant Version_32 := 16#3cd38519#;
   pragma Export (C, u00150, "forth__vm__default_wordsB");
   u00151 : constant Version_32 := 16#a71e6402#;
   pragma Export (C, u00151, "forth__vm__default_wordsS");
   u00152 : constant Version_32 := 16#52a66585#;
   pragma Export (C, u00152, "forth__vm__functionsB");
   u00153 : constant Version_32 := 16#ec715a2c#;
   pragma Export (C, u00153, "forth__vm__functionsS");
   u00154 : constant Version_32 := 16#541cfdd7#;
   pragma Export (C, u00154, "forth__return_stackB");
   u00155 : constant Version_32 := 16#741bdb02#;
   pragma Export (C, u00155, "forth__return_stackS");
   u00156 : constant Version_32 := 16#b5879b22#;
   pragma Export (C, u00156, "forth__string_vectorB");
   u00157 : constant Version_32 := 16#b87bb581#;
   pragma Export (C, u00157, "forth__string_vectorS");
   u00158 : constant Version_32 := 16#feaa685e#;
   pragma Export (C, u00158, "forth__types__create_blobB");
   u00159 : constant Version_32 := 16#54488820#;
   pragma Export (C, u00159, "forth__types__create_blobS");
   u00160 : constant Version_32 := 16#846f2e9e#;
   pragma Export (C, u00160, "gnat__debug_utilitiesB");
   u00161 : constant Version_32 := 16#a1f3db1c#;
   pragma Export (C, u00161, "gnat__debug_utilitiesS");
   u00162 : constant Version_32 := 16#9777733a#;
   pragma Export (C, u00162, "system__img_lliB");
   u00163 : constant Version_32 := 16#4e87fb87#;
   pragma Export (C, u00163, "system__img_lliS");
   u00164 : constant Version_32 := 16#56e74f1a#;
   pragma Export (C, u00164, "system__img_realB");
   u00165 : constant Version_32 := 16#9860ffb4#;
   pragma Export (C, u00165, "system__img_realS");
   u00166 : constant Version_32 := 16#80f37066#;
   pragma Export (C, u00166, "system__fat_llfS");
   u00167 : constant Version_32 := 16#1b28662b#;
   pragma Export (C, u00167, "system__float_controlB");
   u00168 : constant Version_32 := 16#bf34ed6a#;
   pragma Export (C, u00168, "system__float_controlS");
   u00169 : constant Version_32 := 16#3da6be5a#;
   pragma Export (C, u00169, "system__img_lluB");
   u00170 : constant Version_32 := 16#47073c3a#;
   pragma Export (C, u00170, "system__img_lluS");
   u00171 : constant Version_32 := 16#22ab03a2#;
   pragma Export (C, u00171, "system__img_unsB");
   u00172 : constant Version_32 := 16#913a000e#;
   pragma Export (C, u00172, "system__img_unsS");
   u00173 : constant Version_32 := 16#0fb8c821#;
   pragma Export (C, u00173, "system__powten_tableS");
   u00174 : constant Version_32 := 16#e892b88e#;
   pragma Export (C, u00174, "system__val_lliB");
   u00175 : constant Version_32 := 16#c5ec48f6#;
   pragma Export (C, u00175, "system__val_lliS");
   u00176 : constant Version_32 := 16#1e25d3f1#;
   pragma Export (C, u00176, "system__val_lluB");
   u00177 : constant Version_32 := 16#743c6b8b#;
   pragma Export (C, u00177, "system__val_lluS");
   u00178 : constant Version_32 := 16#8ff77155#;
   pragma Export (C, u00178, "system__val_realB");
   u00179 : constant Version_32 := 16#a1e1d947#;
   pragma Export (C, u00179, "system__val_realS");
   u00180 : constant Version_32 := 16#0be1b996#;
   pragma Export (C, u00180, "system__exn_llfB");
   u00181 : constant Version_32 := 16#de4cb0b9#;
   pragma Export (C, u00181, "system__exn_llfS");
   u00182 : constant Version_32 := 16#cdaa67e9#;
   pragma Export (C, u00182, "forth__poolsB");
   u00183 : constant Version_32 := 16#645982e3#;
   pragma Export (C, u00183, "forth__poolsS");
   u00184 : constant Version_32 := 16#994daa60#;
   pragma Export (C, u00184, "system__pool_sizeB");
   u00185 : constant Version_32 := 16#5ee6e60f#;
   pragma Export (C, u00185, "system__pool_sizeS");
   u00186 : constant Version_32 := 16#ace27f6a#;
   pragma Export (C, u00186, "forth__handle_stringsB");
   u00187 : constant Version_32 := 16#b84f32f0#;
   pragma Export (C, u00187, "forth__handle_stringsS");
   u00188 : constant Version_32 := 16#c379a05f#;
   pragma Export (C, u00188, "forth__tokenizeB");
   u00189 : constant Version_32 := 16#7a3366c8#;
   pragma Export (C, u00189, "forth__tokenizeS");
   u00190 : constant Version_32 := 16#e5480ede#;
   pragma Export (C, u00190, "ada__strings__fixedB");
   u00191 : constant Version_32 := 16#a86b22b3#;
   pragma Export (C, u00191, "ada__strings__fixedS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.handling%s
   --  ada.characters.latin_1%s
   --  gnat%s
   --  gnat.io%s
   --  gnat.io%b
   --  interfaces%s
   --  system%s
   --  gnat.debug_utilities%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.atomic_counters%s
   --  system.case_util%s
   --  system.case_util%b
   --  system.exn_llf%s
   --  system.exn_llf%b
   --  system.float_control%s
   --  system.float_control%b
   --  system.htable%s
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_enum_new%s
   --  system.img_enum_new%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.img_lli%s
   --  system.img_lli%b
   --  system.img_real%s
   --  system.io%s
   --  system.io%b
   --  system.machine_code%s
   --  system.atomic_counters%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.powten_table%s
   --  system.standard_library%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.os_lib%s
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  ada.exceptions%s
   --  system.soft_links%s
   --  system.unsigned_types%s
   --  system.fat_llf%s
   --  system.img_llu%s
   --  system.img_llu%b
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.img_real%b
   --  system.val_lli%s
   --  system.val_llu%s
   --  system.val_real%s
   --  system.val_uns%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_uns%b
   --  system.val_real%b
   --  system.val_llu%b
   --  system.val_lli%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_cnv%s
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  system.address_image%s
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.compare_array_unsigned_8%s
   --  system.compare_array_unsigned_8%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.containers.red_black_trees%s
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  ada.strings.less_case_insensitive%s
   --  ada.strings.less_case_insensitive%b
   --  ada.strings.maps%s
   --  ada.strings.fixed%s
   --  ada.strings.maps.constants%s
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.tags%s
   --  ada.streams%s
   --  ada.streams%b
   --  interfaces.c%s
   --  system.communication%s
   --  system.communication%b
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.exceptions.machine%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  ada.finalization%b
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
   --  system.storage_pools.subpools%s
   --  system.storage_pools.subpools.finalization%s
   --  system.storage_pools.subpools.finalization%b
   --  system.stream_attributes%s
   --  system.stream_attributes%b
   --  system.assertions%s
   --  system.assertions%b
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  system.file_control_block%s
   --  ada.streams.stream_io%s
   --  system.file_io%s
   --  ada.streams.stream_io%b
   --  system.pool_size%s
   --  system.pool_size%b
   --  system.secondary_stack%s
   --  system.file_io%b
   --  system.storage_pools.subpools%b
   --  system.finalization_masters%b
   --  interfaces.c%b
   --  ada.tags%b
   --  ada.strings.fixed%b
   --  ada.strings.maps%b
   --  system.soft_links%b
   --  system.os_lib%b
   --  gnat.debug_utilities%b
   --  ada.characters.handling%b
   --  system.secondary_stack%b
   --  system.address_image%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  system.strings.stream_ops%s
   --  system.strings.stream_ops%b
   --  system.traceback%s
   --  ada.exceptions%b
   --  system.traceback%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  forth%s
   --  forth%b
   --  forth.dictionary%s
   --  forth.pools%s
   --  forth.pools%b
   --  forth.stack%s
   --  forth.stack%b
   --  forth.string_vector%s
   --  forth.string_vector%b
   --  forth.handle_strings%s
   --  forth.handle_strings%b
   --  forth.tokenize%s
   --  forth.tokenize%b
   --  forth.types%s
   --  forth.data_stack%s
   --  forth.data_stack%b
   --  forth.dictionary.word_list%s
   --  forth.dictionary.word_list%b
   --  forth.return_stack%s
   --  forth.return_stack%b
   --  forth.types.create_blob%s
   --  forth.types.create_blob%b
   --  forth.vm%s
   --  forth.types%b
   --  forth.dictionary%b
   --  forth.vm.functions%s
   --  forth.vm.functions%b
   --  forth.vm.default_words%s
   --  forth.vm.default_words%b
   --  forth.vm%b
   --  forth.interpreter%s
   --  forth.interpreter%b
   --  test%b
   --  END ELABORATION ORDER


end ada_main;
