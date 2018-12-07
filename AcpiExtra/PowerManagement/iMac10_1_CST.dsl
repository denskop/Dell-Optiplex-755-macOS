#ifdef IMAC_10_1_PM
    External (CFGD, IntObj)
    External (PDC0, IntObj)
    External (PDC1, IntObj)
    External (\_PR_.CPU0, DeviceObj)
    External (\_PR_.CPU1, DeviceObj)
    
    Scope (\_PR.CPU0)
    {
        Method (ACST, 0, NotSerialized)
        {
            If ((CFGD & 0x0200))
            {
                Return (Package (0x07)
                {
                    One, 
                    0x05, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000000, // Address
                                0x01,               // Access Size
                                )
                        }, 

                        One, 
                        One, 
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
                                0x01,               // Access Size
                                )
                        }, 

                        0x02, 
                        One, 
                        0x01F4
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000031, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        0x04, 
                        0x39, 
                        0x64
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000031, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        0x05, 
                        0x39, 
                        0x64
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000051, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        0x06, 
                        0xA2, 
                        0x64
                    }
                })
            }

            If ((CFGD & 0x0100))
            {
                Return (Package (0x06)
                {
                    One, 
                    0x04, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000000, // Address
                                0x01,               // Access Size
                                )
                        }, 

                        One, 
                        One, 
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
                                0x01,               // Access Size
                                )
                        }, 

                        0x02, 
                        One, 
                        0x01F4
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000031, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        0x04, 
                        0x39, 
                        0x64
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000031, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        0x05, 
                        0x39, 
                        0x64
                    }
                })
            }

            If ((CFGD & 0x80))
            {
                Return (Package (0x05)
                {
                    One, 
                    0x03, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000000, // Address
                                0x01,               // Access Size
                                )
                        }, 

                        One, 
                        One, 
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
                                0x01,               // Access Size
                                )
                        }, 

                        0x02, 
                        One, 
                        0x01F4
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000031, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        0x04, 
                        0x39, 
                        0x64
                    }
                })
            }

            If ((CFGD & 0x20))
            {
                Return (Package (0x04)
                {
                    One, 
                    0x02, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000000, // Address
                                0x01,               // Access Size
                                )
                        }, 

                        One, 
                        One, 
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
                                0x01,               // Access Size
                                )
                        }, 

                        0x02, 
                        One, 
                        0x01F4
                    }
                })
            }

            If ((CFGD & 0x10))
            {
                Return (Package (0x03)
                {
                    One, 
                    One, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000000, // Address
                                0x01,               // Access Size
                                )
                        }, 

                        One, 
                        One, 
                        0x03E8
                    }
                })
            }
        }

        Method (_CST, 0, NotSerialized)  // _CST: C-States
        {
            If (((CFGD & 0x01000000) && !(PDC0 & 0x10)))
            {
                Return (Package (0x02)
                {
                    One, 
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

                        One, 
                        0x9D, 
                        0x03E8
                    }
                })
            }

            If ((PDC0 & 0x0300))
            {
                If ((CFGD & 0x0200))
                {
                    Return (Package (0x04)
                    {
                        0x03, 
                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000000, // Address
                                    0x01,               // Access Size
                                    )
                            }, 

                            One, 
                            One, 
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
                                    0x01,               // Access Size
                                    )
                            }, 

                            0x02, 
                            One, 
                            0x01F4
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000050, // Address
                                    0x03,               // Access Size
                                    )
                            }, 

                            0x03, 
                            0xA2, 
                            0x64
                        }
                    })
                }

                If (((CFGD & 0x0100) || (CFGD & 0x80)))
                {
                    Return (Package (0x04)
                    {
                        0x03, 
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

                            One, 
                            One, 
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
                            One, 
                            0x01F4
                        }, 

                        Package (0x04)
                        {
                            ResourceTemplate ()
                            {
                                Register (FFixedHW, 
                                    0x01,               // Bit Width
                                    0x02,               // Bit Offset
                                    0x0000000000000031, // Address
                                    0x03,               // Access Size
                                    )
                            }, 

                            0x03, 
                            0x39, 
                            0x64
                        }
                    })
                }

                If ((CFGD & 0x20))
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

                            One, 
                            One, 
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
                            One, 
                            0x01F4
                        }
                    })
                }
            }

            If ((CFGD & 0x0200))
            {
                Return (Package (0x04)
                {
                    0x03, 
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

                        One, 
                        One, 
                        0x03E8
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000414, // Address
                                ,)
                        }, 

                        0x02, 
                        One, 
                        0x01F4
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000418, // Address
                                ,)
                        }, 

                        0x03, 
                        0xA2, 
                        0x64
                    }
                })
            }

            If ((CFGD & 0x0100))
            {
                Return (Package (0x04)
                {
                    0x03, 
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

                        One, 
                        One, 
                        0x03E8
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000414, // Address
                                ,)
                        }, 

                        0x02, 
                        One, 
                        0x01F4
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000417, // Address
                                ,)
                        }, 

                        0x03, 
                        0x39, 
                        0x64
                    }
                })
            }

            If ((CFGD & 0x80))
            {
                Return (Package (0x04)
                {
                    0x03, 
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

                        One, 
                        One, 
                        0x03E8
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000414, // Address
                                ,)
                        }, 

                        0x02, 
                        One, 
                        0x01F4
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000416, // Address
                                ,)
                        }, 

                        0x03, 
                        0x39, 
                        0x64
                    }
                })
            }

            If ((CFGD & 0x20))
            {
                Return (Package (0x03)
                {
                    0x02, 
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

                        One, 
                        One, 
                        0x03E8
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (SystemIO, 
                                0x08,               // Bit Width
                                0x00,               // Bit Offset
                                0x0000000000000414, // Address
                                ,)
                        }, 

                        0x02, 
                        One, 
                        0x01F4
                    }
                })
            }

            Return (Package (0x02)
            {
                One, 
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

                    One, 
                    One, 
                    0x03E8
                }
            })
        }
    }
    
    Scope (\_PR.CPU1)
    {
        Method (_CST, 0, NotSerialized)
        {
            If (LAnd (And (CFGD, 0x01000000), LNot (And (PDC1, 0x10
                ))))
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

            Return (\_PR.CPU0._CST)
        }
    }
#endif