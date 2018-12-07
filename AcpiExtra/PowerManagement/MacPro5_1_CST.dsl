#ifdef MAC_PRO_5_1_PM
    External (\_PR_.CPU0, DeviceObj)
    External (\_PR_.CPU1, DeviceObj)
    External (\_PR_.CPU2, DeviceObj)
    External (\_PR_.CPU3, DeviceObj)
    External (CFGD, IntObj)
    External (PDC0, IntObj)
    
    Scope (\_PR.CPU0)
    {
        Method (_CST, 0, NotSerialized)
        {
            If (LAnd (And (CFGD, 0x01000000), LNot (And (PDC0, 0x10))))
            {
                Return (Package (0x02)
                {
                    0x01, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x00,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x01, 
                        0x9D, 
                        0x03E8
                    }
                })
            }

            If (And (PDC0, 0x0300))
            {
                If (And (CFGD, 0x20))
                {
                    Return (Package (0x03)
                    {
                        0x02, 
                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000000, // Address
                                    ,)
                            }, 

                            0x01, 
                            0x01, 
                            0x03E8
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000010, // Address
                                    ,)
                            }, 

                            0x02, 
                            0x01, 
                            0x01F4
                        }
                    })
                }
            }

            If (And (CFGD, 0x20))
            {
                Return (Package (0x03)
                {
                    0x02, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000000, // Address
                                ,)
                        }, 

                        0x01, 
                        0x01, 
                        0x03E8
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x000000000000000C, // Address
                                ,)
                        }, 

                        0x02, 
                        0x01, 
                        0x01F4
                    }
                })
            }

            Return (Package (0x02)
            {
                0x01, 
                Package (0x04)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW, 
                            0x01,               // Bit Width
                            0x02,               // Bit Offset
                            0x0000000000000000, // Address
                            ,)
                    }, 

                    0x01, 
                    0x01, 
                    0x03E8
                }
            })
        }
    }
    
    Scope (\_PR.CPU1)
    {
        Method (_CST, 0, NotSerialized)
        {
            Return (\_PR.CPU0._CST)
        }
    }
    
    Scope (\_PR.CPU2)
    {
        Method (_CST, 0, NotSerialized)
        {
            Return (\_PR.CPU0._CST)
        }
    }
    
    Scope (\_PR.CPU3)
    {
        Method (_CST, 0, NotSerialized)
        {
            Return (\_PR.CPU0._CST)
        }
    }
#endif