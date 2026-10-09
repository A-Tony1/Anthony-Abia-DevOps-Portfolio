# VMware Migration and Linux Disk Expansion: Troubleshooting

## 1. Overview

This document records the main challenges encountered while relocating VMware virtual machines to an external HDD and expanding the root filesystem of an Ubuntu virtual machine.

It explains the symptoms, investigation, corrective actions, and lessons learned.

All procedures were carried out in a personal DevOps lab.

## 2. Issue One: Ubuntu Live ISO Stuck During Startup

### Symptom

During the disk expansion process, I attempted to boot an Ubuntu ISO to access a live environment. The desktop remained stuck at the "Preparing Ubuntu" screen.

### Investigation

The live environment did not reach a usable desktop, so I could not continue with the planned procedure.

I decided not to make partition changes from the unresponsive environment.

### Resolution

1. Powered off the virtual machine.
2. Opened the VMware virtual machine settings.
3. Disabled automatic connection of the CD/DVD ISO at startup.
4. Booted the installed Ubuntu operating system normally.
5. Continued the disk investigation from the running system.

### Lesson Learned

A live environment is one possible way to manage partitions, but it is not always necessary. In this case, the root filesystem could be expanded online after the partition was enlarged.

When an installation or recovery environment fails to start, avoid making assumptions about the cause. Recover to a known working state before continuing.

## 3. Issue Two: GPT/PMBR Mismatch After Virtual Disk Expansion

### Symptom

After increasing the VMware virtual disk capacity, a GPT/PMBR mismatch appeared during disk inspection.

### Investigation

I inspected the disk layout and available free space using:

```bash
sudo parted /dev/sda print free
```

The disk was approximately 40 GiB, and the partition layout showed unallocated space after `/dev/sda3`.

I used this information to understand the available space before changing the root partition.

### Resolution

I proceeded with the planned root partition expansion after inspecting the partition layout.

The partition was enlarged using:

```bash
sudo growpart /dev/sda 3
```

The command reported that partition 3 had changed successfully.

I then resized the filesystem using:

```bash
sudo resize2fs /dev/sda3
```

The operation completed successfully, and subsequent filesystem checks confirmed the larger capacity.

### Lesson Learned

A disk-layout warning should be investigated rather than ignored. Inspecting the partition table and available space helps establish what changes are appropriate.

The GPT/PMBR observation was part of the troubleshooting process; it should not be interpreted as proof that every underlying partition-table concern was independently repaired.

## 4. Issue Three: Root Filesystem Nearly Full

### Symptom

The `dev-server` VM's root filesystem was approximately 97% full, with about 335 MB available.

Low disk space can interfere with package installations, container operations, application logs, and other activities that require writable storage.

### Investigation

I inspected the root filesystem:

```bash
df -hT /
```

I then checked the block devices:

```bash
lsblk
```

After increasing the virtual disk in VMware, I inspected the partition layout:

```bash
sudo parted /dev/sda print free
```

The inspection showed that additional unallocated space was available after the root partition.

### Resolution

I expanded the virtual disk from 20 GiB to 40 GiB through VMware Workstation.

I then expanded the root partition:

```bash
sudo growpart /dev/sda 3
```

Finally, I expanded the ext4 filesystem:

```bash
sudo resize2fs /dev/sda3
```

### Verification

I ran:

```bash
df -hT /
```

and:

```bash
lsblk -f
```

The final checks showed that the root filesystem was approximately 30 GB, with about 19.2 GB available and approximately 30% utilization.

### Lesson Learned

Increasing the size of a virtual disk is only one part of Linux storage expansion. The partition and filesystem must also be expanded before the root filesystem can use the additional capacity.

## 5. Operational Precautions

The following precautions were important throughout the project:

* Shut down virtual machines before relocating their folders.
* Preserve virtual disk files and snapshot dependencies.
* Keep the external HDD connected while its virtual machines are running.
* Inspect the correct disk and partition before making changes.
* Avoid modifying unrelated partitions.
* Verify filesystem capacity after the operation.
* Maintain backups before significant storage or partition changes.

## 6. Final Outcome

The migration preserved the existing personal DevOps lab environments on the external HDD.

The disk expansion increased the `dev-server` VM's virtual disk from 20 GiB to 40 GiB. The root filesystem grew from approximately 9.5 GB to 30 GB, and available space increased from approximately 335 MB to 19.2 GB.

These results were verified using Linux storage inspection commands.

## 7. Key Takeaways

This exercise strengthened my ability to:

1. Investigate Linux disk utilization.
2. Interpret disk and partition layouts.
3. Expand a Linux partition and ext4 filesystem.
4. Recover from an unsuccessful attempt to start a live environment.
5. Verify the results of infrastructure changes.
6. Document troubleshooting decisions and operational precautions.
