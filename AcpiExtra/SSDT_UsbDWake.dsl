DefinitionBlock ("", "SSDT", 1, "APPLE ", "UsbDWake", 0x00001000)
{
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.EHC1._PRW, IntObj)
    External (_SB_.PCI0.EHC2._PRW, IntObj)
    External (_SB_.PCI0.UHC2._PRW, IntObj)
    External (_SB_.PCI0.UHC3._PRW, IntObj)
    External (_SB_.PCI0.UHC4._PRW, IntObj)
    External (_SB_.PCI0.UHC5._PRW, IntObj)
    External (_SB_.PCI0.UHC6._PRW, IntObj)

    Scope (\_SB.PCI0)
    {
        Device (UHW2)
        {
            Name (_HID, "APP000D")  // _HID: Hardware ID
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (\_SB.PCI0.UHC2._PRW) /* External reference */
            }
        }

        Device (UHW3)
        {
            Name (_HID, "APP000D")  // _HID: Hardware ID
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (\_SB.PCI0.UHC3._PRW) /* External reference */
            }
        }

        Device (UHW4)
        {
            Name (_HID, "APP000D")  // _HID: Hardware ID
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (\_SB.PCI0.UHC4._PRW) /* External reference */
            }
        }

        Device (UHW5)
        {
            Name (_HID, "APP000D")  // _HID: Hardware ID
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (\_SB.PCI0.UHC5._PRW) /* External reference */
            }
        }

        Device (EHW1)
        {
            Name (_HID, "APP000D")  // _HID: Hardware ID
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (\_SB.PCI0.EHC1._PRW) /* External reference */
            }
        }

        Device (EHW2)
        {
            Name (_HID, "APP000D")  // _HID: Hardware ID
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (\_SB.PCI0.EHC2._PRW) /* External reference */
            }
        }
    }
}

