# Dell-Optiplex-755-macOS
Repo to install macOS on Dell Optiplex 755

## Hardware Specification:

| Hardware | Models | macOS Compability | Description |
|:-|:-|:-:|:-|
| CPU | Xeon E5xxx / L5xxx/ X5xxx | ❌ | 4 Cores<br>Unsupported by Q35 chipset |
| | Xeon L3xxx / X3xxx | ✅ | 4 Cores |
| | Core 2 Quad Q8xxx / Q9xxx | ✅ | 4 Cores |
| | Core 2 Quad Q6xxx | ⚠️ | 4 Cores<br>Unsupported by macOS 10.12+ |
| | Core 2 Duo E7xxx / E8xxx | ✅ | 2 Cores |
| | Core 2 Duo E4xxx / E6xxx| ⚠️ | 2 Cores<br>Unsupported by macOS 10.12+ |
| | Pentium E2xxx | ⚠️ | <br>2 Cores<br>Unsupported by macOS 10.12+<br>Require FakeCPUID |
| | Celeron 4xx | ⚠️ | 1 Cores<br>Unsupported by macOS 10.7+<br>Require FakeCPUID |
| GPU | Internal GMA 3100 | ❌ | It is not GMA X3100 model |
| | AMD Radeon X1300 | ❌ | |
| | AMD Radeon HD 2xxx / 3xxx | ❌ | |
| | AMD Radeon HD 4xxx / 5xxx / 6xxx  | ⚠️ | Unsupported by macOS 10.14 |
| | AMD Radeon HD 7xxx and newer | ⚠️ | Unsupported by macOS 10.14 due to LGA 775 board problems! |
| | Nvidia GeForce 8xxx / 9xxx GT / GTS | ⚠️ | Unsupported by macOS 10.14 |
| | Nvidia GeForce GT / GTX 1xx / 2xx / 3xx | ⚠️ | Unsupported by macOS 10.14 |
| | Nvidia GeForce GT / GTX 4xx / 5xx / 6xx (Fermi) | ⚠️ | Unstable in macOS 10.14 |
| | Nvidia GeForce GT / GTX 6xx / 7xx (Kepler) | ✅ | GK1xx Chips |
| | Nvidia GeForce GT 6xx / 7xx (Kepler 2.0) | ✅ | GK2xx Chips |
| | Nvidia GeForce GTX 750 / 9xx (Maxwell) | ⚠️ | Unsupported by macOS 10.14<br>Require Nvidia Web Driver |
| | Nvidia GeForce GTX 10xx (Pascal) | ⚠️ | Unsupported by macOS 10.14<br>Require Nvidia Web Driver |
| | Nvidia GeForce RTX 20xx (Turing) | ❌ | Unsupported by macOS 10.14+<br>Require Nvidia Web Driver |
| Memory | DIMM DDR2 533 / 667 / 800 ECC / Non-ECC | ✅ | Summary up to 8GB |
| | DIMM DDR2 1066 ECC / Non-ECC | ❌ | Unsupported by Q35 chipset |
| Drives | SATA HDD / SSD | ✅ | Operating Mode: IDE / AHCI / RAID<br>SATA Speed: 3Gbs<br>Drives Num: Up to 4 |
| USB | Ver 1.1 (UHCI) / 2.0 (EHCI) | ✅ | 8 Ports + 2 Internal |
| Sound | Built-In Chip ADI 1984 | ✅ | Headphones / Mic / Line In |
|  |  | ⚠️ | Line Out - Bad sound quality (Disabled) |
|  |  | ❌ | Built-In speaker (Disabled) |
| LAN | Built-In Intel 82566DM | ✅ |
| PCI Devices | WiFi Atheros AR9220 / AR9223 / AR9227 | ✅ | 2.4 Ghz, 300 Mbit (Real 150 Mbit)<br>Require MiniPCI to PCI Adapter<br> |
| | Other devices | ✅ | With 3rd-party drivers (Kexts) |
| PCI-E Devices | Supported WiFi | ✅ | 2.4 / 5 Ghz |
| | Other devices | ✅ | With(out) 3rd-party drivers (Kexts) |
