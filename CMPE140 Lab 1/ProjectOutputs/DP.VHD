------------------------------------------------------------
-- VHDL DP
-- 2016 9 7 22 49 7
-- Created By "DXP VHDL Generator"
-- "Copyright (c) 2002-2014 Altium Limited"
-- Product Version: 16.1.12.290
------------------------------------------------------------

------------------------------------------------------------
-- VHDL DP
------------------------------------------------------------

Library IEEE;
Use     IEEE.std_logic_1164.all;

Entity DP Is
  port
  (
    CLK    : In    STD_LOGIC;                                -- ObjectKind=Port|PrimaryId=CLK
    CNT_EN : In    STD_LOGIC;                                -- ObjectKind=Port|PrimaryId=CNT_EN
    CNT_LD : In    STD_LOGIC;                                -- ObjectKind=Port|PrimaryId=CNT_LD
    DONE   : In    STD_LOGIC;                                -- ObjectKind=Port|PrimaryId=DONE
    GT     : Out   STD_LOGIC;                                -- ObjectKind=Port|PrimaryId=GT
    INPUT  : In    STD_LOGIC;                                -- ObjectKind=Port|PrimaryId=INPUT
    MUX    : In    STD_LOGIC;                                -- ObjectKind=Port|PrimaryId=MUX
    OUTPUT : Out   STD_LOGIC;                                -- ObjectKind=Port|PrimaryId=OUTPUT
    REG_LD : In    STD_LOGIC                                 -- ObjectKind=Port|PrimaryId=REG_LD
  );
  attribute MacroCell : boolean;

End DP;
------------------------------------------------------------

------------------------------------------------------------
Architecture Structure Of DP Is
   Component BUF                                             -- ObjectKind=Sheet Symbol|PrimaryId=U_BUF
      port
      (
        I  : in  STD_LOGIC_VECTOR(31 Downto 0);              -- ObjectKind=Sheet Entry|PrimaryId=BUF.V-I[31..0]
        O  : out STD_LOGIC_VECTOR(31 Downto 0);              -- ObjectKind=Sheet Entry|PrimaryId=BUF.V-O[31..0]
        OE : in  STD_LOGIC                                   -- ObjectKind=Sheet Entry|PrimaryId=BUF.V-OE
      );
   End Component;

   Component CMP                                             -- ObjectKind=Sheet Symbol|PrimaryId=U_CMP
      port
      (
        A  : in  STD_LOGIC_VECTOR(31 Downto 0);              -- ObjectKind=Sheet Entry|PrimaryId=CMP.V-A[31..0]
        B  : in  STD_LOGIC_VECTOR(31 Downto 0);              -- ObjectKind=Sheet Entry|PrimaryId=CMP.V-B[31..0]
        GT : out STD_LOGIC                                   -- ObjectKind=Sheet Entry|PrimaryId=CMP.V-GT
      );
   End Component;

   Component DOWNCOUNTER                                     -- ObjectKind=Sheet Symbol|PrimaryId=U_DOWNCOUNTER
      port
      (
        CLK : in  STD_LOGIC;                                 -- ObjectKind=Sheet Entry|PrimaryId=DOWNCOUNTER.V-CLK
        D   : in  STD_LOGIC_VECTOR(31 Downto 0);             -- ObjectKind=Sheet Entry|PrimaryId=DOWNCOUNTER.V-D[31..0]
        EN  : in  STD_LOGIC;                                 -- ObjectKind=Sheet Entry|PrimaryId=DOWNCOUNTER.V-EN
        LD  : in  STD_LOGIC;                                 -- ObjectKind=Sheet Entry|PrimaryId=DOWNCOUNTER.V-LD
        Q   : out STD_LOGIC_VECTOR(31 Downto 0)              -- ObjectKind=Sheet Entry|PrimaryId=DOWNCOUNTER.V-Q[31..0]
      );
   End Component;

   Component MUL                                             -- ObjectKind=Sheet Symbol|PrimaryId=U_MUL
      port
      (
        X : in  STD_LOGIC_VECTOR(31 Downto 0);               -- ObjectKind=Sheet Entry|PrimaryId=MUL.V-X[31..0]
        Y : in  STD_LOGIC_VECTOR(31 Downto 0);               -- ObjectKind=Sheet Entry|PrimaryId=MUL.V-Y[31..0]
        Z : out STD_LOGIC_VECTOR(31 Downto 0)                -- ObjectKind=Sheet Entry|PrimaryId=MUL.V-Z[31..0]
      );
   End Component;

   Component MUX                                             -- ObjectKind=Sheet Symbol|PrimaryId=U_MUX
      port
      (
        IN0 : in  STD_LOGIC_VECTOR(31 Downto 0);             -- ObjectKind=Sheet Entry|PrimaryId=MUX.V-IN0[31..0]
        IN1 : in  STD_LOGIC_VECTOR(31 Downto 0);             -- ObjectKind=Sheet Entry|PrimaryId=MUX.V-IN1[31..0]
        OUT : out STD_LOGIC_VECTOR(31 Downto 0);             -- ObjectKind=Sheet Entry|PrimaryId=MUX.V-OUT[31..0]
        SEL : in  STD_LOGIC                                  -- ObjectKind=Sheet Entry|PrimaryId=MUX.V-SEL
      );
   End Component;

   Component REGISTER                                        -- ObjectKind=Sheet Symbol|PrimaryId=U_REGISTER
      port
      (
        CLK : in  STD_LOGIC;                                 -- ObjectKind=Sheet Entry|PrimaryId=REGISTER.V-CLK
        D   : in  STD_LOGIC_VECTOR(31 Downto 0);             -- ObjectKind=Sheet Entry|PrimaryId=REGISTER.V-D[31..0]
        LD  : in  STD_LOGIC;                                 -- ObjectKind=Sheet Entry|PrimaryId=REGISTER.V-LD
        Q   : out STD_LOGIC_VECTOR(31 Downto 0)              -- ObjectKind=Sheet Entry|PrimaryId=REGISTER.V-Q[31..0]
      );
   End Component;


    Signal PinSignal_U_CMP_GT : STD_LOGIC; -- ObjectKind=Net|PrimaryId=GT

Begin
    U_REGISTER : REGISTER                                    -- ObjectKind=Sheet Symbol|PrimaryId=U_REGISTER
      Port Map
      (
        CLK => CLK,                                          -- ObjectKind=Sheet Entry|PrimaryId=REGISTER.V-CLK
        LD  => REG_LD                                        -- ObjectKind=Sheet Entry|PrimaryId=REGISTER.V-LD
      );

    U_MUX : MUX                                              -- ObjectKind=Sheet Symbol|PrimaryId=U_MUX
      Port Map
      (
        SEL => MUX                                           -- ObjectKind=Sheet Entry|PrimaryId=MUX.V-SEL
      );

    U_MUL : MUL                                              -- ObjectKind=Sheet Symbol|PrimaryId=U_MUL
;

    U_DOWNCOUNTER : DOWNCOUNTER                              -- ObjectKind=Sheet Symbol|PrimaryId=U_DOWNCOUNTER
      Port Map
      (
        CLK => CLK,                                          -- ObjectKind=Sheet Entry|PrimaryId=DOWNCOUNTER.V-CLK
        EN  => CNT_EN,                                       -- ObjectKind=Sheet Entry|PrimaryId=DOWNCOUNTER.V-EN
        LD  => CNT_LD                                        -- ObjectKind=Sheet Entry|PrimaryId=DOWNCOUNTER.V-LD
      );

    U_CMP : CMP                                              -- ObjectKind=Sheet Symbol|PrimaryId=U_CMP
      Port Map
      (
        GT => PinSignal_U_CMP_GT                             -- ObjectKind=Sheet Entry|PrimaryId=CMP.V-GT
      );

    U_BUF : BUF                                              -- ObjectKind=Sheet Symbol|PrimaryId=U_BUF
      Port Map
      (
        OE => DONE                                           -- ObjectKind=Sheet Entry|PrimaryId=BUF.V-OE
      );

    -- Signal Assignments
    ---------------------
    GT <= PinSignal_U_CMP_GT; -- ObjectKind=Net|PrimaryId=GT

End Structure;
------------------------------------------------------------

