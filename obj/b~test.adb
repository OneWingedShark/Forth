pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~test.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~test.adb");
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E079 : Short_Integer; pragma Import (Ada, E079, "system__os_lib_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "system__fat_llf_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "system__exception_table_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "ada__containers_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "ada__io_exceptions_E");
   E104 : Short_Integer; pragma Import (Ada, E104, "ada__strings_E");
   E110 : Short_Integer; pragma Import (Ada, E110, "ada__strings__maps_E");
   E135 : Short_Integer; pragma Import (Ada, E135, "ada__strings__maps__constants_E");
   E050 : Short_Integer; pragma Import (Ada, E050, "ada__tags_E");
   E060 : Short_Integer; pragma Import (Ada, E060, "ada__streams_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "interfaces__c_E");
   E074 : Short_Integer; pragma Import (Ada, E074, "interfaces__c__strings_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exceptions_E");
   E069 : Short_Integer; pragma Import (Ada, E069, "system__finalization_root_E");
   E067 : Short_Integer; pragma Import (Ada, E067, "ada__finalization_E");
   E092 : Short_Integer; pragma Import (Ada, E092, "system__storage_pools_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "system__finalization_masters_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "system__storage_pools__subpools_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "system__assertions_E");
   E094 : Short_Integer; pragma Import (Ada, E094, "system__pool_global_E");
   E082 : Short_Integer; pragma Import (Ada, E082, "system__file_control_block_E");
   E146 : Short_Integer; pragma Import (Ada, E146, "ada__streams__stream_io_E");
   E065 : Short_Integer; pragma Import (Ada, E065, "system__file_io_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "system__pool_size_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__secondary_stack_E");
   E106 : Short_Integer; pragma Import (Ada, E106, "ada__strings__unbounded_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "system__strings__stream_ops_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__text_io_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "forth_E");
   E184 : Short_Integer; pragma Import (Ada, E184, "forth__pools_E");
   E158 : Short_Integer; pragma Import (Ada, E158, "forth__string_vector_E");
   E130 : Short_Integer; pragma Import (Ada, E130, "forth__types_E");
   E102 : Short_Integer; pragma Import (Ada, E102, "forth__data_stack_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "forth__dictionary__word_list_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "forth__dictionary__word_list_E");
   E156 : Short_Integer; pragma Import (Ada, E156, "forth__return_stack_E");
   E150 : Short_Integer; pragma Import (Ada, E150, "forth__vm_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "forth__interpreter_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E150 := E150 - 1;
      E130 := E130 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "forth__vm__finalize_spec");
      begin
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "forth__types__finalize_spec");
      begin
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "forth__pools__finalize_body");
      begin
         E184 := E184 - 1;
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "forth__pools__finalize_spec");
      begin
         F4;
      end;
      E059 := E059 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "ada__text_io__finalize_spec");
      begin
         F5;
      end;
      E106 := E106 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "ada__strings__unbounded__finalize_spec");
      begin
         F6;
      end;
      E084 := E084 - 1;
      E098 := E098 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__file_io__finalize_body");
      begin
         E065 := E065 - 1;
         F7;
      end;
      E187 := E187 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__pool_size__finalize_spec");
      begin
         F8;
      end;
      E146 := E146 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "ada__streams__stream_io__finalize_spec");
      begin
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "system__file_control_block__finalize_spec");
      begin
         E082 := E082 - 1;
         F10;
      end;
      E094 := E094 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "system__pool_global__finalize_spec");
      begin
         F11;
      end;
      declare
         procedure F12;
         pragma Import (Ada, F12, "system__storage_pools__subpools__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "system__finalization_masters__finalize_spec");
      begin
         F13;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");
   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Install_Handler;
      pragma Import (C, Install_Handler, "__gnat_install_handler");

      Handler_Installed : Integer;
      pragma Import (C, Handler_Installed, "__gnat_handler_installed");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      if Handler_Installed = 0 then
         Install_Handler;
      end if;

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Fat_Llf'Elab_Spec;
      E167 := E167 + 1;
      System.Exception_Table'Elab_Body;
      E008 := E008 + 1;
      Ada.Containers'Elab_Spec;
      E103 := E103 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E070 := E070 + 1;
      Ada.Strings'Elab_Spec;
      E104 := E104 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E135 := E135 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E060 := E060 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E027 := E027 + 1;
      System.Finalization_Root'Elab_Spec;
      E069 := E069 + 1;
      Ada.Finalization'Elab_Spec;
      E067 := E067 + 1;
      System.Storage_Pools'Elab_Spec;
      E092 := E092 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      System.Assertions'Elab_Spec;
      E142 := E142 + 1;
      System.Pool_Global'Elab_Spec;
      E094 := E094 + 1;
      System.File_Control_Block'Elab_Spec;
      E082 := E082 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E146 := E146 + 1;
      System.Pool_Size'Elab_Spec;
      E187 := E187 + 1;
      System.File_Io'Elab_Body;
      E065 := E065 + 1;
      E098 := E098 + 1;
      System.Finalization_Masters'Elab_Body;
      E084 := E084 + 1;
      E074 := E074 + 1;
      E072 := E072 + 1;
      Ada.Tags'Elab_Body;
      E050 := E050 + 1;
      E110 := E110 + 1;
      System.Soft_Links'Elab_Body;
      E015 := E015 + 1;
      System.Os_Lib'Elab_Body;
      E079 := E079 + 1;
      System.Secondary_Stack'Elab_Body;
      E019 := E019 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E106 := E106 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E144 := E144 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E059 := E059 + 1;
      Forth'Elab_Spec;
      E005 := E005 + 1;
      Forth.Pools'Elab_Spec;
      Forth.Pools'Elab_Body;
      E184 := E184 + 1;
      Forth.String_Vector'Elab_Spec;
      E158 := E158 + 1;
      Forth.Types'Elab_Spec;
      Forth.Data_Stack'Elab_Spec;
      E102 := E102 + 1;
      Forth.Dictionary.Word_List'Elab_Spec;
      Forth.Dictionary.Word_List'Elab_Body;
      E139 := E139 + 1;
      Forth.Return_Stack'Elab_Spec;
      E156 := E156 + 1;
      Forth.Vm'Elab_Spec;
      E130 := E130 + 1;
      E150 := E150 + 1;
      E048 := E048 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_test");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-pools.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-pools-blob_pool.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-stack.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-string_vector.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-handle_strings.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-tokenize.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-data_stack.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-dictionary-word_list.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-return_stack.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-types-create_blob.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-types.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-dictionary.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-vm-functions.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-vm-default_words.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-vm.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\forth-interpreter.o
   --   C:\Programming\Projects\Experimentation\FORTH\obj\test.o
   --   -LC:\Programming\Projects\Experimentation\FORTH\obj\
   --   -LC:\Programming\Projects\Experimentation\FORTH\obj\
   --   -LC:/Programming/GNAT/2013/lib/gcc/i686-pc-mingw32/4.7.4/adalib/
   --   -static
   --   -lgnat
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
