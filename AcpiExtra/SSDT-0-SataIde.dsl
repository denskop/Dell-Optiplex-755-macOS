DefinitionBlock ("", "SSDT", 1, "APPLE ", "SataIde ", 0x00001000)
{
    External (DTGP, MethodObj)    // 4 Arguments
    External (\_SB_.PCI0, DeviceObj)
    External (\_SB_.PCI0.SATA, DeviceObj)

    Scope (\_SB.PCI0.SATA)
    {
        OperationRegion (IDER, PCI_Config, 0x40, 0x20)
                Field (IDER, AnyAcc, NoLock, Preserve)
                {
                    PFT0,   1, 
                    PIE0,   1, 
                    PPE0,   1, 
                    PDE0,   1, 
                    PFT1,   1, 
                    PIE1,   1, 
                    PPE1,   1, 
                    PDE1,   1, 
                    PRTZ,   2, 
                        ,   2, 
                    PIP0,   2, 
                    PSIT,   1, 
                    PIDE,   1, 
                    SFT0,   1, 
                    SIE0,   1, 
                    SPE0,   1, 
                    SDE0,   1, 
                    SFT1,   1, 
                    SIE1,   1, 
                    SPE1,   1, 
                    SDE1,   1, 
                    SRT0,   2, 
                        ,   2, 
                    SIP0,   2, 
                    SSIT,   1, 
                    SIDE,   1, 
                    PRTY,   2, 
                    PIP1,   2, 
                    SRT1,   2, 
                    SIP1,   2, 
                    Offset (0x08), 
                    UDM0,   1, 
                    UDM1,   1, 
                    UDM2,   1, 
                    UDM3,   1, 
                    Offset (0x0A), 
                    PCT0,   2, 
                        ,   2, 
                    PCT1,   2, 
                    Offset (0x0B), 
                    SCT0,   2, 
                        ,   2, 
                    SCT1,   2, 
                    Offset (0x14), 
                    PCB0,   1, 
                    PCB1,   1, 
                    SCB0,   1, 
                    SCB1,   1, 
                    PCCR,   2, 
                    SCCR,   2, 
                        ,   4, 
                    PUM0,   1, 
                    PUM1,   1, 
                    SUM0,   1, 
                    SUM1,   1, 
                    PSIG,   2, 
                    SSIG,   2
                }

                Method (GPIO, 4, NotSerialized)
                {
                    If (LEqual (Or (Arg0, Arg1), 0x00))
                    {
                        Return (0xFFFFFFFF)
                    }
                    Else
                    {
                        If (And (LEqual (Arg0, 0x00), LEqual (Arg1, 0x01)))
                        {
                            Return (0x0384)
                        }
                    }

                    Return (Multiply (0x1E, Subtract (0x09, Add (Arg2, Arg3))
                        ))
                }

                Method (GDMA, 5, NotSerialized)
                {
                    If (LEqual (Arg0, 0x01))
                    {
                        If (LEqual (Arg1, 0x01))
                        {
                            If (LEqual (Arg4, 0x02))
                            {
                                Return (0x0F)
                            }

                            Return (0x14)
                        }

                        If (LEqual (Arg2, 0x01))
                        {
                            Return (Multiply (0x0F, Subtract (0x04, Arg4)))
                        }

                        Return (Multiply (0x1E, Subtract (0x04, Arg4)))
                    }

                    Return (0xFFFFFFFE)
                }

                Method (SFLG, 5, NotSerialized)
                {
                    Store (0x00, Local0)
                    Or (Arg1, Local0, Local0)
                    Or (ShiftLeft (Arg0, 0x01), Local0, Local0)
                    Or (ShiftLeft (Arg2, 0x03), Local0, Local0)
                    Or (ShiftLeft (Arg3, 0x02), Local0, Local0)
                    Or (ShiftLeft (Arg4, 0x04), Local0, Local0)
                    Return (Local0)
                }

                Method (SPIO, 3, NotSerialized)
                {
                    Name (PBUF, Buffer (0x05)
                    {
                         0x00, 0x00, 0x00, 0x00, 0x00
                    })
                    CreateByteField (PBUF, 0x00, RCT)
                    CreateByteField (PBUF, 0x01, ISP)
                    CreateByteField (PBUF, 0x02, FAST)
                    CreateByteField (PBUF, 0x03, DMAE)
                    CreateByteField (PBUF, 0x04, PIOT)
                    If (LOr (LEqual (Arg0, 0x00), LEqual (Arg0, 0xFFFFFFFF)))
                    {
                        Return (PBUF)
                    }

                    If (LGreater (Arg0, 0xF0))
                    {
                        Store (0x01, DMAE)
                        Store (0x00, PIOT)
                    }
                    Else
                    {
                        Store (0x01, FAST)
                        If (And (Arg1, 0x02))
                        {
                            If (And (LEqual (Arg0, 0x78), And (Arg2, 0x02)))
                            {
                                Store (0x03, RCT)
                                Store (0x02, ISP)
                                Store (0x04, PIOT)
                            }
                            Else
                            {
                                If (And (LLessEqual (Arg0, 0xB4), And (Arg2, 0x01)
                                    ))
                                {
                                    Store (0x01, RCT)
                                    Store (0x02, ISP)
                                    Store (0x03, PIOT)
                                }
                                Else
                                {
                                    Store (0x00, RCT)
                                    Store (0x01, ISP)
                                    Store (0x02, PIOT)
                                }
                            }
                        }
                    }

                    Return (PBUF)
                }

                Method (SDMA, 3, NotSerialized)
                {
                    Name (PBUF, Buffer (0x05)
                    {
                         0x00, 0x00, 0x00, 0x00
                    })
                    CreateByteField (PBUF, 0x00, PCT)
                    CreateByteField (PBUF, 0x01, PCB)
                    CreateByteField (PBUF, 0x02, UDMT)
                    CreateByteField (PBUF, 0x03, UDME)
                    CreateByteField (PBUF, 0x04, DMAT)
                    If (LOr (LEqual (Arg0, 0x00), LEqual (Arg0, 0xFFFFFFFF)))
                    {
                        Return (PBUF)
                    }

                    If (LLessEqual (Arg0, 0x78))
                    {
                        If (And (Arg1, 0x04))
                        {
                            Store (0x01, UDME)
                            If (And (LEqual (Arg0, 0x0F), And (Arg2, 0x40)))
                            {
                                Store (0x01, UDMT)
                                Store (0x01, PCB)
                                Store (0x02, PCT)
                                Store (0x06, DMAT)
                            }
                            Else
                            {
                                If (And (LEqual (Arg0, 0x14), And (Arg2, 0x20)))
                                {
                                    Store (0x01, UDMT)
                                    Store (0x01, PCB)
                                    Store (0x01, PCT)
                                    Store (0x05, DMAT)
                                }
                                Else
                                {
                                    If (And (LLessEqual (Arg0, 0x1E), And (Arg2, 0x10)
                                        ))
                                    {
                                        Store (0x01, PCB)
                                        Store (0x02, PCT)
                                        Store (0x04, DMAT)
                                    }
                                    Else
                                    {
                                        If (And (LLessEqual (Arg0, 0x2D), And (Arg2, 0x08)
                                            ))
                                        {
                                            Store (0x01, PCB)
                                            Store (0x01, PCT)
                                            Store (0x03, DMAT)
                                        }
                                        Else
                                        {
                                            If (And (LLessEqual (Arg0, 0x3C), And (Arg2, 0x04)
                                                ))
                                            {
                                                Store (0x02, PCT)
                                                Store (0x02, DMAT)
                                            }
                                            Else
                                            {
                                                If (And (LLessEqual (Arg0, 0x5A), And (Arg2, 0x02)
                                                    ))
                                                {
                                                    Store (0x01, PCT)
                                                    Store (0x01, DMAT)
                                                }
                                                Else
                                                {
                                                    If (And (LLessEqual (Arg0, 0x78), And (Arg2, 0x01)
                                                        ))
                                                    {
                                                        Store (0x00, DMAT)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Return (PBUF)
                }
    }

    Scope (\_SB.PCI0) {
    Device (SSAT)
            {
                Name (_ADR, 0x001F0005)
                OperationRegion (IDER, PCI_Config, 0x40, 0x20)
                Field (IDER, AnyAcc, NoLock, Preserve)
                {
                    PFT0,   1, 
                    PIE0,   1, 
                    PPE0,   1, 
                    PDE0,   1, 
                    PFT1,   1, 
                    PIE1,   1, 
                    PPE1,   1, 
                    PDE1,   1, 
                    PRTZ,   2, 
                        ,   2, 
                    PIP0,   2, 
                    PSIT,   1, 
                    PIDE,   1, 
                    SFT0,   1, 
                    SIE0,   1, 
                    SPE0,   1, 
                    SDE0,   1, 
                    SFT1,   1, 
                    SIE1,   1, 
                    SPE1,   1, 
                    SDE1,   1, 
                    SRT0,   2, 
                        ,   2, 
                    SIP0,   2, 
                    SSIT,   1, 
                    SIDE,   1, 
                    PRTY,   2, 
                    PIP1,   2, 
                    SRT1,   2, 
                    SIP1,   2, 
                    Offset (0x08), 
                    UDM0,   1, 
                    UDM1,   1, 
                    UDM2,   1, 
                    UDM3,   1, 
                    Offset (0x0A), 
                    PCT0,   2, 
                        ,   2, 
                    PCT1,   2, 
                    Offset (0x0B), 
                    SCT0,   2, 
                        ,   2, 
                    SCT1,   2, 
                    Offset (0x14), 
                    PCB0,   1, 
                    PCB1,   1, 
                    SCB0,   1, 
                    SCB1,   1, 
                    PCCR,   2, 
                    SCCR,   2, 
                        ,   4, 
                    PUM0,   1, 
                    PUM1,   1, 
                    SUM0,   1, 
                    SUM1,   1, 
                    PSIG,   2, 
                    SSIG,   2
                }

                Method (GPIO, 4, NotSerialized)
                {
                    If (LEqual (Or (Arg0, Arg1), 0x00))
                    {
                        Return (0xFFFFFFFF)
                    }
                    Else
                    {
                        If (And (LEqual (Arg0, 0x00), LEqual (Arg1, 0x01)))
                        {
                            Return (0x0384)
                        }
                    }

                    Return (Multiply (0x1E, Subtract (0x09, Add (Arg2, Arg3))
                        ))
                }

                Method (GDMA, 5, NotSerialized)
                {
                    If (LEqual (Arg0, 0x01))
                    {
                        If (LEqual (Arg1, 0x01))
                        {
                            If (LEqual (Arg4, 0x02))
                            {
                                Return (0x0F)
                            }

                            Return (0x14)
                        }

                        If (LEqual (Arg2, 0x01))
                        {
                            Return (Multiply (0x0F, Subtract (0x04, Arg4)))
                        }

                        Return (Multiply (0x1E, Subtract (0x04, Arg4)))
                    }

                    Return (0xFFFFFFFE)
                }

                Method (SFLG, 5, NotSerialized)
                {
                    Store (0x00, Local0)
                    Or (Arg1, Local0, Local0)
                    Or (ShiftLeft (Arg0, 0x01), Local0, Local0)
                    Or (ShiftLeft (Arg2, 0x03), Local0, Local0)
                    Or (ShiftLeft (Arg3, 0x02), Local0, Local0)
                    Or (ShiftLeft (Arg4, 0x04), Local0, Local0)
                    Return (Local0)
                }

                Method (SPIO, 3, NotSerialized)
                {
                    Name (PBUF, Buffer (0x05)
                    {
                         0x00, 0x00, 0x00, 0x00, 0x00
                    })
                    CreateByteField (PBUF, 0x00, RCT)
                    CreateByteField (PBUF, 0x01, ISP)
                    CreateByteField (PBUF, 0x02, FAST)
                    CreateByteField (PBUF, 0x03, DMAE)
                    CreateByteField (PBUF, 0x04, PIOT)
                    If (LOr (LEqual (Arg0, 0x00), LEqual (Arg0, 0xFFFFFFFF)))
                    {
                        Return (PBUF)
                    }

                    If (LGreater (Arg0, 0xF0))
                    {
                        Store (0x01, DMAE)
                        Store (0x00, PIOT)
                    }
                    Else
                    {
                        Store (0x01, FAST)
                        If (And (Arg1, 0x02))
                        {
                            If (And (LEqual (Arg0, 0x78), And (Arg2, 0x02)))
                            {
                                Store (0x03, RCT)
                                Store (0x02, ISP)
                                Store (0x04, PIOT)
                            }
                            Else
                            {
                                If (And (LLessEqual (Arg0, 0xB4), And (Arg2, 0x01)
                                    ))
                                {
                                    Store (0x01, RCT)
                                    Store (0x02, ISP)
                                    Store (0x03, PIOT)
                                }
                                Else
                                {
                                    Store (0x00, RCT)
                                    Store (0x01, ISP)
                                    Store (0x02, PIOT)
                                }
                            }
                        }
                    }

                    Return (PBUF)
                }

                Method (SDMA, 3, NotSerialized)
                {
                    Name (PBUF, Buffer (0x05)
                    {
                         0x00, 0x00, 0x00, 0x00
                    })
                    CreateByteField (PBUF, 0x00, PCT)
                    CreateByteField (PBUF, 0x01, PCB)
                    CreateByteField (PBUF, 0x02, UDMT)
                    CreateByteField (PBUF, 0x03, UDME)
                    CreateByteField (PBUF, 0x04, DMAT)
                    If (LOr (LEqual (Arg0, 0x00), LEqual (Arg0, 0xFFFFFFFF)))
                    {
                        Return (PBUF)
                    }

                    If (LLessEqual (Arg0, 0x78))
                    {
                        If (And (Arg1, 0x04))
                        {
                            Store (0x01, UDME)
                            If (And (LEqual (Arg0, 0x0F), And (Arg2, 0x40)))
                            {
                                Store (0x01, UDMT)
                                Store (0x01, PCB)
                                Store (0x02, PCT)
                                Store (0x06, DMAT)
                            }
                            Else
                            {
                                If (And (LEqual (Arg0, 0x14), And (Arg2, 0x20)))
                                {
                                    Store (0x01, UDMT)
                                    Store (0x01, PCB)
                                    Store (0x01, PCT)
                                    Store (0x05, DMAT)
                                }
                                Else
                                {
                                    If (And (LLessEqual (Arg0, 0x1E), And (Arg2, 0x10)
                                        ))
                                    {
                                        Store (0x01, PCB)
                                        Store (0x02, PCT)
                                        Store (0x04, DMAT)
                                    }
                                    Else
                                    {
                                        If (And (LLessEqual (Arg0, 0x2D), And (Arg2, 0x08)
                                            ))
                                        {
                                            Store (0x01, PCB)
                                            Store (0x01, PCT)
                                            Store (0x03, DMAT)
                                        }
                                        Else
                                        {
                                            If (And (LLessEqual (Arg0, 0x3C), And (Arg2, 0x04)
                                                ))
                                            {
                                                Store (0x02, PCT)
                                                Store (0x02, DMAT)
                                            }
                                            Else
                                            {
                                                If (And (LLessEqual (Arg0, 0x5A), And (Arg2, 0x02)
                                                    ))
                                                {
                                                    Store (0x01, PCT)
                                                    Store (0x01, DMAT)
                                                }
                                                Else
                                                {
                                                    If (And (LLessEqual (Arg0, 0x78), And (Arg2, 0x01)
                                                        ))
                                                    {
                                                        Store (0x00, DMAT)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Return (PBUF)
                }
            }
        }
}

