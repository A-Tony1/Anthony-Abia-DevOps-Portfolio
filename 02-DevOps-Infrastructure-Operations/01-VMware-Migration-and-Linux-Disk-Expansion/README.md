# VMware Infrastructure Migration and Linux Disk Expansion

## Project Overview

This project documents the migration of VMware virtual machines from a Windows PC's internal storage to an external hard drive, followed by the investigation and resolution of a Linux disk-capacity problem in one of the virtual machines.

The project was carried out in a personal DevOps lab to improve storage utilization, preserve existing lab environments, and restore sufficient disk capacity for continued infrastructure practice.

It demonstrates practical experience with VMware virtual machine management, Linux disk administration, filesystem expansion, troubleshooting, and infrastructure documentation.

## Problem Statement

My local DevOps lab consisted of multiple Ubuntu virtual machines running under VMware Workstation on a Windows laptop.

As the lab environments and associated tools grew, the virtual machines consumed an increasing amount of space on the laptop's internal drive. This created a need to relocate the virtual machines to an external HDD.

After migrating the environments, I also encountered a disk-capacity issue in the `dev-server` virtual machine. Its root filesystem was approximately 97% full, with only about 335 MB available.

This situation required two infrastructure operations:

1. Relocate the VMware virtual machines to the external HDD.
2. Expand the virtual disk, root partition, and filesystem of the affected Ubuntu VM.

## Project Objectives

* Relocate existing VMware virtual machines from the PC's internal drive to an external HDD.
* Preserve the existing virtual machine environments and their configurations.
* Investigate Linux disk utilization and partition layout.
* Increase the affected virtual disk capacity from 20 GiB to 40 GiB.
* Expand the root partition and ext4 filesystem to use the additional capacity.
* Verify the changes using standard Linux storage inspection commands.
* Document the process, challenges, solutions, and lessons learned.

## Lab Environment

| Component                 | Details                              |
| ------------------------- | ------------------------------------ |
| Host operating system     | Windows                              |
| Virtualization platform   | VMware Workstation                   |
| Storage destination       | External HDD                         |
| Guest operating system    | Ubuntu Linux                         |
| Affected virtual machine  | `dev-server-VMware-Virtual-Platform` |
| Linux root partition      | `/dev/sda3`                          |
| Filesystem                | ext4                                 |
| Partition management tool | `growpart`                           |
| Filesystem expansion tool | `resize2fs`                          |
| Verification tools        | `lsblk`, `df`, `parted`              |

## Virtual Machine Migration

Three VMware virtual machines were relocated to the external HDD:

1. `nexus-VMware-Virtual-Platform`
2. `dev-server-VMware-Virtual-Platform`
3. `anthony-VMware-Virtual-Platform`

The virtual machines were stored under the VMware VM directories on the external drive.

The migration made additional space available on the laptop's internal storage while retaining the environments used for DevOps practice.

See [Migration Process](migration-process.md) - [PowerShell VMware Migration Commands](02-DevOps-Infrastructure-Operations/01-VMware-Migration-and-Linux-Disk-Expansion/migration-powershell.md) for the migration workflow and safety considerations.

## Linux Disk Expansion

The `dev-server` VM initially had a 20 GiB virtual disk. Its root partition was approximately 9.7 GiB, and the root filesystem was nearly full.

The virtual disk was increased to 40 GiB through VMware Workstation. The Linux root partition was then expanded to use the additional available space.

The following commands were used:

```bash
sudo growpart /dev/sda 3
sudo resize2fs /dev/sda3
```

The first command expanded partition 3. The second expanded the ext4 filesystem to use the enlarged partition.

The separate `/dev/sda2` partition was left unchanged.

See [Disk Expansion](disk-expansion.md) for the detailed procedure.

## Before-and-After Results

| Metric                          |                Before |                  After |
| ------------------------------- | --------------------: | ---------------------: |
| VMware virtual disk             |                20 GiB |                 40 GiB |
| Root partition `/dev/sda3`      | Approximately 9.7 GiB | Approximately 29.7 GiB |
| Root filesystem size            |  Approximately 9.5 GB |    Approximately 30 GB |
| Available root filesystem space |  Approximately 335 MB |  Approximately 19.2 GB |
| Root filesystem usage           |     Approximately 97% |      Approximately 30% |

The final filesystem checks confirmed that the root filesystem had approximately 19.2 GB available and was using approximately 30% of its capacity.

## Verification

The following commands were used to inspect the disk layout and verify the final filesystem capacity:

```bash
lsblk
```

Displays the disks, partitions, and mount points.

```bash
sudo parted /dev/sda print free
```

Displays the partition layout and available unallocated space.

```bash
df -hT /
```

Displays the root filesystem type, total capacity, used space, and available space.

```bash
lsblk -f
```

Displays filesystem types, UUIDs, and mount points.

## Troubleshooting and Lessons Learned

During the operation, I encountered a problem when attempting to boot an Ubuntu ISO in VMware. The live environment became stuck at the preparation screen.

I recovered by powering off the VM, disconnecting the ISO from automatic connection at startup, and booting the installed Ubuntu operating system normally.

I also learned that expanding a VMware virtual disk does not automatically expand the Linux partition or filesystem.

The additional capacity became usable by the root filesystem only after the partition and filesystem were expanded.

See [Troubleshooting](troubleshooting.md) for more details.

## Skills Demonstrated

* VMware virtual machine storage management
* Virtual machine migration and verification
* Linux disk and partition administration
* Linux filesystem capacity management
* ext4 filesystem expansion
* Disk utilization troubleshooting
* Command-line infrastructure operations
* Technical documentation and change verification

## Project Outcome

I successfully relocated my personal VMware lab environments to an external HDD and resolved the root filesystem capacity problem in the `dev-server` VM.

The root filesystem increased from approximately 9.5 GB to 30 GB, with available space rising from approximately 335 MB to 19.2 GB.

This project strengthened my practical understanding of Linux storage management and reinforced the importance of verifying infrastructure changes rather than assuming that a successful configuration change automatically produces the intended result.

## Disclaimer

This project was performed in a personal learning environment. It demonstrates hands-on lab experience and should not be interpreted as evidence of managing enterprise production infrastructure.

## Author

Anthony Abia

GitHub: [A-Tony1](https://github.com/A-Tony1)
