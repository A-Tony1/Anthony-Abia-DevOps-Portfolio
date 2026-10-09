# Linux Disk Expansion: VMware and Ubuntu

## 1. Overview

This document explains how I resolved a disk-capacity problem in my `dev-server` Ubuntu virtual machine.

The root filesystem was nearly full, leaving insufficient free space for continued DevOps lab activities. I investigated the disk layout, increased the VMware virtual disk capacity, expanded the root partition, and resized the ext4 filesystem.

The procedure demonstrates Linux storage administration, virtual disk management, filesystem expansion, and post-change verification.

## 2. Initial Problem

The root filesystem was approximately 97% full, with only about 335 MB available.

Low disk space can prevent package installations, cause applications to fail when writing files, interrupt container image operations, and interfere with system services.

The affected filesystem was mounted at `/` and backed by `/dev/sda3`.

## 3. Initial and Target Configuration

| Component            | Initial state                      | Target state           |
| -------------------- | ---------------------------------- | ---------------------- |
| VMware virtual disk  | 20 GiB                             | 40 GiB                 |
| Linux root partition | `/dev/sda3`, approximately 9.7 GiB | Approximately 29.7 GiB |
| Root filesystem      | ext4, approximately 9.5 GB         | Approximately 30 GB    |
| Available root space | Approximately 335 MB               | Approximately 19.2 GB  |

The VM also contained a separate `/dev/sda2` partition. I left that partition unchanged.

## 4. Procedure

### Step 1: Inspect the Root Filesystem

I checked the root filesystem's capacity and usage:

```bash
df -hT /
```

This command reports the filesystem type, total size, used space, available space, and mount point.

The initial result showed that the root filesystem was almost full.

### Step 2: Expand the VMware Virtual Disk

I powered off the virtual machine and opened its virtual hardware settings in VMware Workstation.

I increased the virtual disk capacity from 20 GiB to 40 GiB.

After applying the change, I booted the installed Ubuntu operating system and confirmed that Linux detected the larger disk.

**Important:** Increasing the virtual disk's capacity makes additional storage available to the guest operating system, but it does not automatically expand an existing partition or filesystem.

### Step 3: Inspect the Partition Layout

I used the following commands to inspect the disk and its partitions:

```bash
lsblk
```

```bash
sudo parted /dev/sda print free
```

The inspection showed that `/dev/sda` was approximately 40 GiB and that unallocated space existed after `/dev/sda3`.

This identified the additional space available for the root partition.

### Step 4: Expand the Root Partition

I used `growpart` to extend partition 3:

```bash
sudo growpart /dev/sda 3
```

The command completed successfully and reported:

```text
CHANGED: partition=3
```

The partition was extended into the available space.

The command uses `/dev/sda` as the disk and `3` as the partition number. The partition number is not written as `/dev/sda3` in the `growpart` command.

### Step 5: Expand the ext4 Filesystem

After expanding the partition, I resized the ext4 filesystem:

```bash
sudo resize2fs /dev/sda3
```

The filesystem was mounted at `/`, and `resize2fs` performed an online resize.

The command completed successfully and expanded the filesystem to use the larger partition.

### Step 6: Verify the Result

I checked the root filesystem:

```bash
df -hT /
```

I also inspected the block devices and filesystem details:

```bash
lsblk -f
```

The final results showed that the root filesystem was approximately 30 GB, with about 19.2 GB available and approximately 30% of the filesystem in use.

## 5. Before-and-After Results

| Metric                 |                Before |                  After |
| ---------------------- | --------------------: | ---------------------: |
| Virtual disk capacity  |                20 GiB |                 40 GiB |
| Root partition         | Approximately 9.7 GiB | Approximately 29.7 GiB |
| Root filesystem size   |  Approximately 9.5 GB |    Approximately 30 GB |
| Available space        |  Approximately 335 MB |  Approximately 19.2 GB |
| Filesystem utilization |     Approximately 97% |      Approximately 30% |

The operation restored substantial free space to the root filesystem and provided additional capacity for future development and DevOps exercises.

## 6. Why Two Expansion Commands Were Necessary

The operation involved three distinct storage layers:

1. **Virtual disk:** VMware provides the virtual disk capacity to the guest operating system.
2. **Partition:** The Linux partition defines which part of the disk is allocated to the root filesystem.
3. **Filesystem:** The ext4 filesystem manages files and directories within the partition.

Increasing the virtual disk alone does not automatically expand the other layers.

`growpart` expanded the partition, while `resize2fs` expanded the ext4 filesystem to use that partition's capacity.

## 7. Troubleshooting Notes

During the procedure, I attempted to boot an Ubuntu ISO to use a live environment. The live environment became stuck at the preparation screen.

I recovered by powering off the VM, disabling automatic connection of the ISO at startup, and booting the installed Ubuntu system normally.

The disk and partition inspection also showed a GPT/PMBR mismatch following the virtual disk expansion. I inspected the partition layout and confirmed the available free space before expanding the root partition.

The separate `/dev/sda2` partition was not modified during the operation.

Additional details are available in [Troubleshooting](troubleshooting.md).

## 8. Lessons Learned

* Monitor filesystem utilization before disk pressure becomes critical.
* Verify the virtual disk size from inside the guest operating system after a VMware change.
* Inspect the partition layout before resizing a partition.
* Identify the correct disk and partition before running storage administration commands.
* Understand the difference between virtual disk capacity, partition size, and filesystem size.
* Verify the final filesystem capacity instead of assuming the resize succeeded.
* Avoid modifying unrelated partitions when resolving a targeted capacity issue.

## 9. Outcome

I successfully expanded the `dev-server` VM's virtual disk from 20 GiB to 40 GiB, increased the root partition, and resized the ext4 filesystem.

The root filesystem grew from approximately 9.5 GB to 30 GB, and available space increased from approximately 335 MB to 19.2 GB.

This resolved the immediate disk-capacity constraint in my personal DevOps lab.

## 10. Scope

This procedure was performed in a personal Ubuntu virtual machine running under VMware Workstation. It demonstrates hands-on infrastructure troubleshooting and Linux administration practice rather than enterprise production experience.
