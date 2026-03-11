# Host Machine Configurations

## Folder Structure

- ${hostname} - specific configurations for an individual machine
- `./global` - configurations that should be applied to all machines
- `./common` - some common shared configurations that can be selectively applied to a machine
  - anything can be copy/pasted to a host directory and imported to customize

## Hosts

- `./cawl` - Kat Gaming Desktop with Nvidia GPU
- `./fabius` - Buck Gaming Desktop with AMD GPU
- `./nord` - NixOS Linode
- `./perturabo` - NixOS NAS
- `./servitor` - Local LLM server (no longer in service)
- `./wayward` - Buck Laptop
- `./workbench` - Workbench desktop machine (not currently in service)
