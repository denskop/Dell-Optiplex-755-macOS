DefinitionBlock ("", "SSDT", 2, "APPLE ", "IGNoHda", 0x00001000)
{
    External (\_SB.PCI0, DeviceObj)
    
    Scope (\_SB.PCI0)
    {
        Device (HDEF)
        {
            Name (_ADR, 0x001B0000)
            OperationRegion (HDAR, PCI_Config, 0x00, 0x60)
            Field (HDAR, WordAcc, NoLock, Preserve)
            {
                VID0,   16, 
                DID0,   16, 
                Offset (0x4C), 
                DCKA,   1, 
                Offset (0x4D), 
                DCKM,   1, 
                    ,   6, 
                DCKS,   1, 
                Offset (0x54), 
                    ,   15, 
                PMES,   1
            }
        }
    }
}

