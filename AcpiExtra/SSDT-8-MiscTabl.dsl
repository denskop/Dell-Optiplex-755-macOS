DefinitionBlock ("", "SSDT", 1, "APPLE ", "MiscTabl", 0x00001000)
{
    External (_SB_.PCI0, DeviceObj)    // (from opcode)

    Scope (\)
    {
        Method (DTGP, 5, NotSerialized)
        {
            If (LEqual (Arg0, ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
            {
                If (LEqual (Arg1, One))
                {
                    If (LEqual (Arg2, Zero))
                    {
                        Store (Buffer (One)
                            {
                                 0x03                                           
                            }, Arg4)
                        Return (One)
                    }

                    If (LEqual (Arg2, One))
                    {
                        Return (One)
                    }
                }
            }

            Store (Buffer (One)
                {
                     0x00                                           
                }, Arg4)
            Return (Zero)
        }
    }

    Scope (\)
    {
        Device (APIC)
        {
            Name (_HID, EisaId ("PNP0003"))  // _HID: Hardware ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadOnly,
                    0xFEC00000,         // Address Base
                    0x00100000,         // Address Length
                    )
            })
        }
    }

    Scope (\_SB.PCI0)
    {
        Device (GIGE)
        {
            Name (_ADR, 0x00190000)  // _ADR: Address
        }

        Device (HECI)
        {
            Name (_ADR, 0x00030000)  // _ADR: Address
        }

        Device (ESI)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0B)
            }
        }
    }
}