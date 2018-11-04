DefinitionBlock ("", "SSDT", 1, "APPLE ", "PciCrs ", 0x00001000)
{
    External (_SB_.PCI0, DeviceObj)

    Scope (\_SB.PCI0)
    {
        Name (PBRS, ResourceTemplate ()
        {
            WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                0x0000,             // Granularity
                0x0000,             // Range Minimum
                0x00FF,             // Range Maximum
                0x0000,             // Translation Offset
                0x0100,             // Length
                ,, )
            IO (Decode16,
                0x0CF8,             // Range Minimum
                0x0CF8,             // Range Maximum
                0x01,               // Alignment
                0x08,               // Length
                )
            WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                0x0000,             // Granularity
                0x0000,             // Range Minimum
                0x0CF7,             // Range Maximum
                0x0000,             // Translation Offset
                0x0CF8,             // Length
                ,, , TypeStatic, DenseTranslation)
            WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                0x0000,             // Granularity
                0x0D00,             // Range Minimum
                0xFFFF,             // Range Maximum
                0x0000,             // Translation Offset
                0xF300,             // Length
                ,, , TypeStatic, DenseTranslation)
            DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                0x00000000,         // Granularity
                0x000A0000,         // Range Minimum
                0x000BFFFF,         // Range Maximum
                0x00000000,         // Translation Offset
                0x00020000,         // Length
                ,, , AddressRangeMemory, TypeStatic)
            DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                0x00000000,         // Granularity
                0x00000000,         // Range Minimum
                0x00000000,         // Range Maximum
                0x00000000,         // Translation Offset
                0x00000000,         // Length
                ,, _Y01, AddressRangeMemory, TypeStatic)
            DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                0x00000000,         // Granularity
                0xF8000000,         // Range Minimum
                0xFEAFFFFF,         // Range Maximum
                0x00000000,         // Translation Offset
                0x06B00000,         // Length
                ,, , AddressRangeMemory, TypeStatic)
            DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                0x00000000,         // Granularity
                0x00000000,         // Range Minimum
                0x00000000,         // Range Maximum
                0x00000000,         // Translation Offset
                0x00000000,         // Length
                ,, _Y00, AddressRangeMemory, TypeStatic)
        })
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            CreateDWordField (PBRS, \_SB.PCI0._Y00._MIN, TMIN)  // _MIN: Minimum Base Address
            CreateDWordField (PBRS, \_SB.PCI0._Y00._MAX, TMAX)  // _MAX: Maximum Base Address
            CreateDWordField (PBRS, \_SB.PCI0._Y00._LEN, TLEN)  // _LEN: Length
            If ((MDET () != 0xF0000000))
            {
                TMIN = MDET ()
                TMAX = 0xEFFFFFFF
                TLEN = (TMAX - TMIN) /* \_SB_.PCI0._CRS.TMIN */
                TLEN++
            }

            EROM ()
            Return (PBRS) /* \_SB_.PCI0.PBRS */
        }

        OperationRegion (TMEM, PCI_Config, 0xB0, 0x02)
        Field (TMEM, WordAcc, NoLock, Preserve)
        {
            TOUD,   16
        }

        Method (MDET, 0, NotSerialized)
        {
            Local0 = TOUD /* \_SB_.PCI0.TOUD */
            Local1 = (Local0 & 0x0FFF)
            If (Local1)
            {
                Local0 &= 0xF000
                Local0 += 0x1000
            }

            Local0 <<= 0x10
            Return (Local0)
        }

        OperationRegion (PAMX, PCI_Config, 0x90, 0x07)
        Field (PAMX, ByteAcc, NoLock, Preserve)
        {
                ,   4, 
            BSEG,   4, 
            PAMS,   48
        }

        Name (ERNG, Package (0x0D)
        {
            0x000C0000, 
            0x000C4000, 
            0x000C8000, 
            0x000CC000, 
            0x000D0000, 
            0x000D4000, 
            0x000D8000, 
            0x000DC000, 
            0x000E0000, 
            0x000E4000, 
            0x000E8000, 
            0x000EC000, 
            0x000F0000
        })
        Name (PAMB, Buffer (0x07){})
        Method (EROM, 0, NotSerialized)
        {
            CreateDWordField (PBRS, \_SB.PCI0._Y01._MIN, RMIN)  // _MIN: Minimum Base Address
            CreateDWordField (PBRS, \_SB.PCI0._Y01._MAX, RMAX)  // _MAX: Maximum Base Address
            CreateDWordField (PBRS, \_SB.PCI0._Y01._LEN, RLEN)  // _LEN: Length
            CreateByteField (PAMB, 0x06, BREG)
            PAMB = PAMS /* \_SB_.PCI0.PAMS */
            BREG = BSEG /* \_SB_.PCI0.BSEG */
            RMIN = Zero
            RMAX = Zero
            RLEN = Zero
            Local0 = Zero
            While ((Local0 < 0x0D))
            {
                Local1 = (Local0 >> One)
                Local2 = DerefOf (PAMB [Local1])
                If ((Local0 & One))
                {
                    Local2 >>= 0x04
                }

                Local2 &= 0x03
                If (RMIN)
                {
                    If ((Local2 == 0x03))
                    {
                        RMAX = (DerefOf (ERNG [Local0]) + 0x3FFF)
                        If ((RMAX == 0x000F3FFF))
                        {
                            RMAX = 0x000FFFFF
                        }

                        RLEN = (RMAX - RMIN) /* \_SB_.PCI0.EROM.RMIN */
                        RLEN++
                    }
                    Else
                    {
                        Local0 = 0x0C
                    }
                }
                ElseIf ((Local2 == 0x03))
                {
                    RMIN = DerefOf (ERNG [Local0])
                    RMAX = (DerefOf (ERNG [Local0]) + 0x3FFF)
                    If ((RMAX == 0x000F3FFF))
                    {
                        RMAX = 0x000FFFFF
                    }

                    RLEN = (RMAX - RMIN) /* \_SB_.PCI0.EROM.RMIN */
                    RLEN++
                }
                Else
                {
                }

                Local0++
            }
        }
    }
}

