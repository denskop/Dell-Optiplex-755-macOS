DefinitionBlock ("", "SSDT", 1, "APPLE ", "SataAhci", 0x00001000)
{
    External (DTGP, MethodObj)    // 4 Arguments
    External (\_SB_.PCI0.SATA, DeviceObj)

    Scope (\_SB.PCI0.SATA)
    {
        Device (PRT0)
        {
            Name (_ADR, 0xFFFF)  // _ADR: Address
            Name (GTF0, Zero)
            Method (_SDD, 1, NotSerialized)  // _SDD: Set Device Data
            {
                Name (GBU0, Buffer (0x07)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0x00         // .......
                })
                CreateByteField (GBU0, Zero, GB00)
                CreateByteField (GBU0, One, GB01)
                CreateByteField (GBU0, 0x02, GB02)
                CreateByteField (GBU0, 0x03, GB03)
                CreateByteField (GBU0, 0x04, GB04)
                CreateByteField (GBU0, 0x05, GB05)
                CreateByteField (GBU0, 0x06, GB06)
                If (LEqual (SizeOf (Arg0), 0x0200))
                {
                    CreateWordField (Arg0, 0x9C, W780)
                    If (And (W780, 0x08))
                    {
                        Store (0x10, GB00) /* \_SB_.PCI0.SATA.PRT0._SDD.GB00 */
                        Store (0x03, GB01) /* \_SB_.PCI0.SATA.PRT0._SDD.GB01 */
                        Store (0xEF, GB06) /* \_SB_.PCI0.SATA.PRT0._SDD.GB06 */
                    }
                    Else
                    {
                        Store (0x90, GB00) /* \_SB_.PCI0.SATA.PRT0._SDD.GB00 */
                        Store (0x03, GB01) /* \_SB_.PCI0.SATA.PRT0._SDD.GB01 */
                        Store (0xEF, GB06) /* \_SB_.PCI0.SATA.PRT0._SDD.GB06 */
                    }
                }

                Store (GBU0, GTF0) /* External reference */
            }

            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
            {
                Return (GTF0) /* External reference */
            }
            
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                Store (Package (0x02)
                    {
                        "io-device-location", 
                        Buffer (0x06)
                        {
                            "Upper"
                        }
                    }, Local0)
                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                Return (Local0)
            }
        }

        Device (PRT1)
        {
            Name (_ADR, 0x0001FFFF)  // _ADR: Address
            Name (GTF1, Zero)
            Method (_SDD, 1, NotSerialized)  // _SDD: Set Device Data
            {
                Name (GBU1, Buffer (0x07)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0x00         // .......
                })
                CreateByteField (GBU1, Zero, GB10)
                CreateByteField (GBU1, One, GB11)
                CreateByteField (GBU1, 0x02, GB12)
                CreateByteField (GBU1, 0x03, GB13)
                CreateByteField (GBU1, 0x04, GB14)
                CreateByteField (GBU1, 0x05, GB15)
                CreateByteField (GBU1, 0x06, GB16)
                If (LEqual (SizeOf (Arg0), 0x0200))
                {
                    CreateWordField (Arg0, 0x9C, W781)
                    If (And (W781, 0x08))
                    {
                        Store (0x10, GB10) /* \_SB_.PCI0.SATA.PRT1._SDD.GB10 */
                        Store (0x03, GB11) /* \_SB_.PCI0.SATA.PRT1._SDD.GB11 */
                        Store (0xEF, GB16) /* \_SB_.PCI0.SATA.PRT1._SDD.GB16 */
                    }
                    Else
                    {
                        Store (0x90, GB10) /* \_SB_.PCI0.SATA.PRT1._SDD.GB10 */
                        Store (0x03, GB11) /* \_SB_.PCI0.SATA.PRT1._SDD.GB11 */
                        Store (0xEF, GB16) /* \_SB_.PCI0.SATA.PRT1._SDD.GB16 */
                    }
                }

                Store (GBU1, GTF1) /* External reference */
            }

            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
            {
                Return (GTF1) /* External reference */
            }
            
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                Store (Package (0x02)
                    {
                        "io-device-location", 
                        Buffer (0x06)
                        {
                            "Lower"
                        }
                    }, Local0)
                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                Return (Local0)
            }
        }

        Device (PRT2)
        {
            Name (_ADR, 0x0002FFFF)  // _ADR: Address
            Name (GTF2, Zero)
            Method (_SDD, 1, NotSerialized)  // _SDD: Set Device Data
            {
                Name (GBU2, Buffer (0x07)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0x00         // .......
                })
                CreateByteField (GBU2, Zero, GB20)
                CreateByteField (GBU2, One, GB21)
                CreateByteField (GBU2, 0x02, GB22)
                CreateByteField (GBU2, 0x03, GB23)
                CreateByteField (GBU2, 0x04, GB24)
                CreateByteField (GBU2, 0x05, GB25)
                CreateByteField (GBU2, 0x06, GB26)
                If (LEqual (SizeOf (Arg0), 0x0200))
                {
                    CreateWordField (Arg0, 0x9C, W782)
                    If (And (W782, 0x08))
                    {
                        Store (0x10, GB20) /* \_SB_.PCI0.SATA.PRT2._SDD.GB20 */
                        Store (0x03, GB21) /* \_SB_.PCI0.SATA.PRT2._SDD.GB21 */
                        Store (0xEF, GB26) /* \_SB_.PCI0.SATA.PRT2._SDD.GB26 */
                    }
                    Else
                    {
                        Store (0x90, GB20) /* \_SB_.PCI0.SATA.PRT2._SDD.GB20 */
                        Store (0x03, GB21) /* \_SB_.PCI0.SATA.PRT2._SDD.GB21 */
                        Store (0xEF, GB26) /* \_SB_.PCI0.SATA.PRT2._SDD.GB26 */
                    }
                }

                Store (GBU2, GTF2) /* External reference */
            }

            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
            {
                Return (GTF2) /* External reference */
            }
        }
    }
}

