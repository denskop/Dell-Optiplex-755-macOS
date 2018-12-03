DefinitionBlock ("", "SSDT", 1, "APPLE", "Cpu2Tst", 0x00003000)
{
    External (PDC2)
    External (CFGD)
    External (\_PR_.CPU2, DeviceObj)
    External (\_PR_.CPU0._TSS, IntObj)
    External (\_PR_.CPU0._PTC, IntObj)

    Scope (\_PR.CPU2)
    {
        Name (_TPC, 0x00)
        Method (_PTC, 0, NotSerialized)
        {
            Return (\_PR.CPU0._PTC)
        }

        Method (_TSS, 0, NotSerialized)
        {
            Return (\_PR.CPU0._TSS)
        }

        Method (_TSD, 0, NotSerialized)
        {
            If (LAnd (And (CFGD, 0x01000000), LNot (And (PDC2, 0x04
                ))))
            {
                Return (Package (0x01)
                {
                    Package (0x05)
                    {
                        0x05, 
                        0x00, 
                        0x00, 
                        0xFD, 
                        0x02
                    }
                })
            }

            Return (Package (0x01)
            {
                Package (0x05)
                {
                    0x05, 
                    0x00, 
                    0x01, 
                    0xFC, 
                    0x01
                }
            })
        }
    }
}

