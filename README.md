# NixOS Configuration

## Machines

| Host      | Type     | OS            | Role                        |
|-----------|----------|---------------|-----------------------------|
| croaker   | Desktop  | NixOS         | Daily driver (Sway/Wayland) |
| anchovy   | Desktop  | NixOS         | Secondary (Hyprland)        |
| billfish  | Server   | NixOS + VMs   | Service host (Proxmox VMs)  |

## Structure

```
├── flake.nix              # Flake entry point + host definitions
├── hjem/                  # hjem (home-manager) dotfile configs
│   ├── *.nix              # Per-host hjem configs
│   └── dots/              # Dotfiles (foot, sway, hypr, helix, fish, etc.)
├── hosts/                 # Per-host NixOS configurations
│   ├── croaker/
│   ├── anchovy/
│   └── billfish/
└── modules/               # Reusable NixOS modules
    ├── common/            # Shared across all hosts
    ├── desktop/           # Desktop-only (sway, hyprland, sound, etc.)
    ├── server/            # Server-only (docker, tailscale, etc.)
    └── hardware/          # Hardware-specific (wacom, printing, etc.)
```

## Usage

```bash
# Build and switch a host
nh os switch . -H croaker
nh os switch . -H anchovy
