# VMware Virtual Machine Migration Using PowerShell

## 1. Project Overview

I migrated three VMware Ubuntu virtual machines from my laptop's internal storage to an external HDD to free up internal disk space and improve storage management for my DevOps lab.

The migration was performed using Windows PowerShell and the `Copy-Item` command.

**Important:** The commands below document the migration method and provide a repeatable procedure. The original source paths and exact historical commands have not been recovered, so example source paths must be replaced with the actual paths before reuse.

## 2. Destination Directories

The VMware virtual machines were stored on the external HDD at these locations:

```text
D:\VMware VMs\Ubuntu 64-bit
D:\VMware VMs\Ubuntu 64-bit (2)
D:\VMware VMs\ubuntu-devops-lab
```

These folders contain the VMware configuration files, virtual disks, and associated files required by the virtual machines.

## 3. Verify Available Drives

In PowerShell, I could inspect the available drives using:

```powershell
Get-PSDrive -PSProvider FileSystem
```

This command lists available filesystem drives, including the internal drive and external HDD when connected and accessible.

## 4. Create the Destination Folder

The destination directory can be created with:

```powershell
New-Item -ItemType Directory -Path "D:\VMware VMs" -Force
```

The `-Force` parameter allows the command to proceed if the directory already exists.

## 5. Copy the Virtual Machines

Before copying, each VM must be completely shut down in VMware Workstation. Do not copy a running or suspended VM.

The general PowerShell syntax is:

```powershell
Copy-Item -Path "<SOURCE_VM_FOLDER>" -Destination "D:\VMware VMs" -Recurse
```

Replace `<SOURCE_VM_FOLDER>` with the actual source folder of the VM.

Repeat the process for each VM, using its corresponding source folder.

### What the command means

* `Copy-Item`: Copies files and directories.
* `-Path`: Specifies the source folder.
* `-Destination`: Specifies the destination directory.
* `-Recurse`: Includes files and subdirectories.

Copying the complete VM folder helps preserve the configuration files, virtual disks, and associated snapshot files.

**Note:** When reusing this command, check the destination structure first. Copying a folder into a destination that already contains a folder with the same name can produce an unexpected directory layout.

## 6. Verify the Copied Folders

After copying, inspect the destination:

```powershell
Get-ChildItem "D:\VMware VMs"
```

Check that each expected VM folder exists:

```powershell
Test-Path "D:\VMware VMs\Ubuntu 64-bit"
Test-Path "D:\VMware VMs\Ubuntu 64-bit (2)"
Test-Path "D:\VMware VMs\ubuntu-devops-lab"
```

A result of `True` confirms that the specified path exists. It does not, by itself, prove that every file was copied successfully.

For a more thorough comparison, compare the source and destination contents and confirm that the expected VMware files are present.

## 7. Open the Migrated Virtual Machines

1. Open VMware Workstation.
2. Select the option to open an existing virtual machine.
3. Browse to the relevant folder on the external HDD.
4. Open the VM's `.vmx` configuration file.
5. Power on the virtual machine.
6. Confirm that Ubuntu boots and the expected services and applications work.

If VMware asks whether the VM was moved or copied, choose the option consistent with the actual migration and network-identity requirements. For a relocated VM intended to retain its identity, selecting **I moved it** is generally appropriate.

Do not delete any original VM folders until the external copies have been tested successfully and any required backups have been confirmed.

## 8. Storage and Safety Considerations

* Keep the external HDD connected while using the VMs.
* Shut down all VMs and close VMware Workstation before disconnecting the drive.
* Preserve complete VM folders, including snapshot files and virtual-disk dependencies.
* Never delete or move individual VMDK files independently when a VM uses snapshots.
* Verify that each VM boots successfully from its new location.
* Maintain a backup of important lab data.

## 9. Outcome

The VMware virtual machines were relocated to the external HDD, freeing space on the laptop's internal drive and allowing the DevOps lab to continue running from the new storage location.

This exercise strengthened my practical knowledge of PowerShell file operations, VMware virtual-machine management, storage planning, and infrastructure troubleshooting.
