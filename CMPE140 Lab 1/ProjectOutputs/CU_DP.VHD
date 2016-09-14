------------------------------------------------------------
-- VHDL CU_DP
-- 2016 9 7 22 49 7
-- Created By "DXP VHDL Generator"
-- "Copyright (c) 2002-2014 Altium Limited"
-- Product Version: 16.1.12.290
------------------------------------------------------------

------------------------------------------------------------
-- VHDL CU_DP
------------------------------------------------------------

Library IEEE;
Use     IEEE.std_logic_1164.all;

Entity CU_DP Is
  attribute MacroCell : boolean;

End CU_DP;
------------------------------------------------------------

------------------------------------------------------------
Architecture Structure Of CU_DP Is
   Component CU                                              -- ObjectKind=Sheet Symbol|PrimaryId=U_CU
      port
      (
        CNT_EN : out STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=CU.V-CNT_EN
        CNT_LD : out STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=CU.V-CNT_LD
        DONE   : out STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=CU.V-DONE
        GO     : in  STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=CU.V-GO
        GT     : in  STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=CU.V-GT
        MUX    : out STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=CU.V-MUX
        REG_LD : out STD_LOGIC                               -- ObjectKind=Sheet Entry|PrimaryId=CU.V-REG_LD
      );
   End Component;

   Component DP                                              -- ObjectKind=Sheet Symbol|PrimaryId=U_DP
      port
      (
        CNT_EN : in  STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-CNT_EN
        CNT_LD : in  STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-CNT_LD
        DONE   : in  STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-DONE
        GT     : out STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-GT
        INPUT  : in  STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-INPUT
        MUX    : in  STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-MUX
        OUTPUT : out STD_LOGIC;                              -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-OUTPUT
        REG_LD : in  STD_LOGIC                               -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-REG_LD
      );
   End Component;


    Signal PinSignal_U_CU_CNT_EN : STD_LOGIC; -- ObjectKind=Net|PrimaryId=CNT_EN
    Signal PinSignal_U_CU_CNT_LD : STD_LOGIC; -- ObjectKind=Net|PrimaryId=CNT_LD
    Signal PinSignal_U_CU_DONE   : STD_LOGIC; -- ObjectKind=Net|PrimaryId=DONE
    Signal PinSignal_U_CU_MUX    : STD_LOGIC; -- ObjectKind=Net|PrimaryId=MUX
    Signal PinSignal_U_CU_REG_LD : STD_LOGIC; -- ObjectKind=Net|PrimaryId=REG_LD
    Signal PinSignal_U_DP_GT     : STD_LOGIC; -- ObjectKind=Net|PrimaryId=GT
    Signal PinSignal_U_DP_OUTPUT : STD_LOGIC; -- ObjectKind=Net|PrimaryId=OUTPUT
    Signal Signal_GO             : STD_LOGIC; -- ObjectKind=Net|PrimaryId=GO
    Signal Signal_INPUT          : STD_LOGIC; -- ObjectKind=Net|PrimaryId=INPUT

   attribute VERILOGMODULE : string;
   attribute VERILOGMODULE of U_CU : Label is "CU";


Begin
    U_DP : DP                                                -- ObjectKind=Sheet Symbol|PrimaryId=U_DP
      Port Map
      (
        CNT_EN => PinSignal_U_CU_CNT_EN,                     -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-CNT_EN
        CNT_LD => PinSignal_U_CU_CNT_LD,                     -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-CNT_LD
        DONE   => PinSignal_U_CU_DONE,                       -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-DONE
        GT     => PinSignal_U_DP_GT,                         -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-GT
        INPUT  => Signal_INPUT,                              -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-INPUT
        MUX    => PinSignal_U_CU_MUX,                        -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-MUX
        OUTPUT => PinSignal_U_DP_OUTPUT,                     -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-OUTPUT
        REG_LD => PinSignal_U_CU_REG_LD                      -- ObjectKind=Sheet Entry|PrimaryId=DP.SchDoc-REG_LD
      );

    U_CU : CU                                                -- ObjectKind=Sheet Symbol|PrimaryId=U_CU
      Port Map
      (
        CNT_EN => PinSignal_U_CU_CNT_EN,                     -- ObjectKind=Sheet Entry|PrimaryId=CU.V-CNT_EN
        CNT_LD => PinSignal_U_CU_CNT_LD,                     -- ObjectKind=Sheet Entry|PrimaryId=CU.V-CNT_LD
        DONE   => PinSignal_U_CU_DONE,                       -- ObjectKind=Sheet Entry|PrimaryId=CU.V-DONE
        GO     => Signal_GO,                                 -- ObjectKind=Sheet Entry|PrimaryId=CU.V-GO
        GT     => PinSignal_U_DP_GT,                         -- ObjectKind=Sheet Entry|PrimaryId=CU.V-GT
        MUX    => PinSignal_U_CU_MUX,                        -- ObjectKind=Sheet Entry|PrimaryId=CU.V-MUX
        REG_LD => PinSignal_U_CU_REG_LD                      -- ObjectKind=Sheet Entry|PrimaryId=CU.V-REG_LD
      );

End Structure;
------------------------------------------------------------

