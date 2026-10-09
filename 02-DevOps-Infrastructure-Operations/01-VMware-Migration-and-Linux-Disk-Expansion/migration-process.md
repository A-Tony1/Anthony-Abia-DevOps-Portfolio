# VMware Virtual Machine Migration: Internal Drive to External HDD

## 1. Overview

This document describes the process of relocating three existing VMware virtual machines from the Windows laptop's internal storage to an external HDD.

The objective was to free space on the laptop's internal drive while preserving the virtual machines used for Linux administration, DevOps tools, and infrastructure practice.

## 2. Initial Situation

My DevOps lab consisted of multiple Ubuntu virtual machines running under VMware Workstation.

As the environments grew, their virtual disks and associated files consumed a significant amount of storage on the laptop's internal drive.

Rather than deleting the lab environments and rebuilding them, I chose to relocate the virtual machines to an external HDD.

This allowed me to retain the existing environments and continue learning without unnecessarily recreating the infrastructure.

## 3. Migration Objectives

* Reduce storage pressure on the laptop's internal drive.
* Relocate the existing virtual machine files to an external HDD.
* Preserve the virtual machines and their configurations.
* Confirm that the virtual machines could run from their new locations.
* Establish a more practical storage arrangement for continued DevOps learning.

## 4. Lab Inventory

The following virtual machines were relocated:

| Virtual Machine                      | Primary Purpose                                   |
| ------------------------------------ | ------------------------------------------------- |
| `nexus-VMware-Virtual-Platform`      | DevOps tools and Nexus Repository Manager lab     |
| `dev-server-VMware-Virtual-Platform` | Development server and application deployment lab |
| `anthony-VMware-Virtual-Platform`    | Main Ubuntu DevOps learning environment           |

The virtual machines were stored under the following directories on the external HDD:

```text
D:\VMware VMs\Ubuntu 64-bit
D:\VMware VMs\Ubuntu 64-bit (2)
D:\VMware VMs\ubuntu-devops-lab
```

## 5. Migration Procedure

### Step 1: Identify the Existing Virtual Machines

I identified the virtual machines that needed to be relocated and reviewed their storage locations.

This helped establish which environments had to be preserved and where their files were stored.

### Step 2: Shut Down the Virtual Machines

Before moving the virtual machines, I shut them down to avoid copying or relocating files while they were actively being written to.

This is an important precaution because a virtual machine can contain multiple interdependent files, including virtual disks and configuration files.

### Step 3: Prepare the External HDD

I used the external HDD as the destination for the virtual machine directories.

The target directories were organized under:

```text
D:\VMware VMs\
```

### Step 4: Move the Complete Virtual Machine Folders

After shutting down the virtual machines, I moved their complete folders from the laptop's internal storage to the external HDD.

The destination directories were:

```text
D:\VMware VMs\Ubuntu 64-bit
D:\VMware VMs\Ubuntu 64-bit (2)
D:\VMware VMs\ubuntu-devops-lab
```

I preserved the existing VMware configuration files, virtual disks, and other associated files.

**Important:** Virtual machines using snapshots or linked virtual disks may depend on multiple disk files. These files must be preserved together to avoid breaking the virtual machine's disk chain.

### Step 5: Open the Relocated Virtual Machines

I opened each existing virtual machine from its new location in VMware Workstation by selecting its `.vmx` configuration file.

This allowed me to use the existing VM configuration rather than create a replacement virtual machine.

### Step 6: Verify the Migration

After opening the relocated virtual machines, I checked that they could boot and that their existing lab environments remained accessible.

Verification after a migration should include checking the guest operating system, reviewing the VM's storage configuration, and confirming that important applications and services are accessible.


## 6. Storage Management Considerations

The external HDD provided additional storage capacity for the lab, but it also introduced operational considerations.

* The external HDD must remain connected while its virtual machines are running.
* Virtual machines should be shut down before safely disconnecting the drive.
* VMware Workstation should be closed before ejecting the external HDD.
* Virtual machine snapshots and linked virtual disks must be preserved.
* Virtual machine directories should not be renamed or reorganized without understanding their disk dependencies.
* Important virtual machines should be backed up before significant storage or disk operations.

An external HDD is useful for storing lab environments, but its performance may be lower than that of an internal SSD. VM startup, disk-intensive operations, and large image downloads may therefore take longer.

## 7. Outcome

The three VMware virtual machines were relocated to the external HDD, freeing storage capacity on the laptop's internal drive while retaining the existing DevOps lab environments.

The resulting storage arrangement allowed me to continue working with separate Ubuntu environments for development, infrastructure tooling, and application deployment.

The migration also highlighted the importance of planning storage changes carefully and verifying virtual machine integrity after relocation.

## 8. Lessons Learned

1. Shut down virtual machines before relocating their files.
2. Preserve the complete virtual machine directory, including configuration and virtual disk dependencies.
3. Reopen existing virtual machines from their relocated configuration files.
4. Verify that each VM boots and that important services remain accessible.
5. Keep the external drive connected while its virtual machines are running.
6. Never delete snapshot or virtual disk files simply because their purpose is not immediately obvious.

## 9. Relationship to the Disk Expansion Project

After relocating the virtual machines, I investigated a separate storage problem affecting the `dev-server` VM.

Its root filesystem was nearly full, so I expanded its virtual disk, root partition, and ext4 filesystem.

The detailed procedure is documented in [Disk Expansion](disk-expansion.md).
