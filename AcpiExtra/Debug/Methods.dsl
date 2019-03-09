Scope (\RMDT)
{
    // Debug CPU
    External (\PDC0, IntObj)
    External (\PDC1, IntObj)
    External (\PDC2, IntObj)
    External (\PDC3, IntObj)
    External (\_PR.CPU0._PCT, MethodObj)
    External (\_PR.CPU0._PSS, MethodObj)
    External (\_PR.CPU0._CST, MethodObj)
    External (\_PR.CPU0._PSD, MethodObj)
    External (\_PR.CPU1._PSD, MethodObj)
    
    Method(DBG0, 1, Serialized)
    {
       \RMDT.P1("CPU Debug:")
     
       \RMDT.P2("PDC0", \PDC0)
       \RMDT.P2("PDC1", \PDC1)
       \RMDT.P2("PDC2", \PDC2)
       \RMDT.P2("PDC3", \PDC3)
    
       \RMDT.P2("\_PR.CPU0._PCT()", \_PR.CPU0._PCT())
       \RMDT.P2("\_PR.CPU0._PSS()", \_PR.CPU0._PSS())
       \RMDT.P2("\_PR.CPU0._CST()", \_PR.CPU0._CST())
       \RMDT.P2("\_PR.CPU0._PSD()", \_PR.CPU0._PSD())
       \RMDT.P2("\_PR.CPU1._PSD()", \_PR.CPU1._PSD())
    }

    // Debug operation regions
    OperationRegion (SMEM, SystemIO, 0x0800, 0x80)
    Field (SMEM, ByteAcc, NoLock, Preserve)
    {
        PM1S,   16, // [00:01]
        PM1E,   16, // [02:03]
        PM1C,   32, // [04:07]
        PM1T,   32, // [08:0B]
            ,   32, // [0C:0F]
        PROC,   32, // [10:13]
         LV2,    8, // [14]
            ,   32, // [15:18]
            ,   56, // [19:1F]
        GP0S,   64, // [20:27]
        GP0E,   64, // [28:2F]
        SMIE,   32, // [30:33]
        SMIS,   32, // [34:37]
        ASME,    8, // [38:39]
        ASMS,    8, // [3A:3B]
        UPRW,    8, // [3C]
            ,   40, // [3D:41]
        GPEC,    8, // [42]
            ,    8, // [43]
        DEVS,   16, // [44:45]
            ,   80, // [46:4F]
            ,    8, // [50]
            ,  120, // [51:5F]
            ,  256, // [60:7F]
    }

    Method(DBG1, 1, Serialized)
    {
       \RMDT.P1("Mem 0x800 - 0x87F Debug:")
     
       \RMDT.P2("PM1_STS        ",  PM1S)
       \RMDT.P2("PM1_EN         ",  PM1E)
       \RMDT.P2("PM1_CNT        ",  PM1C)
       \RMDT.P2("PM1_TMR        ",  PM1T)
       \RMDT.P2("PROC_CNT       ",  PROC)
       \RMDT.P2("LV2            ",  LV2)
       \RMDT.P2("GPE0_STS       ",  GP0S)
       \RMDT.P2("GPE0_EN        ",  GP0E)
       \RMDT.P2("SMI_EN         ",  SMIE)
       \RMDT.P2("SMI_STS        ",  SMIS)
       \RMDT.P2("ALT_GP_SMI_EN  ",  ASME)
       \RMDT.P2("ALT_GP_SMI_STS ",  ASMS)
       \RMDT.P2("UPRWC          ",  UPRW)
       \RMDT.P2("GPE_CNTL       ",  GPEC)
       \RMDT.P2("DEVACT_STS     ",  DEVS)
    }
}