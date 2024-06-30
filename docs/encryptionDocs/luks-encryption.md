# LUKS Encryption

LUKS (Linux Unified Key Setup) can do **Full Disk Encryption** and **Container File Encryption**

## Prepare the Volume for encryption

  1. Full Disk Encryption (HDD, Flash Drives)
      Use *fdisk* or *gparted* to create a disk partition.
      Wipe the partition with random data using:
      `dd if=/dev/urandom of=/dev/sdx/sdx1 bs=4M status=progress`
      Common Block Size (BS) used is 1M or 4M.
      Alternatively, `shred --verbose --random-source=/dev/urandom /dev/sdx`
      Shred uses 3 passes by default.

  2. Container File
      Create a container file:
      `dd if=/dev/urandom of=container.img bs=1M count=512 status=progress`
      The above will create a 512MB of file. Change the bs or count to depending on the file size you need.


## Encrypting and prepare the volume

  1. Make sure the device is not mounted

  2. Encrypt the device:
      `cryptsetup luksFormat --iter-time=10000 --hash=sha512 --key-size=512 --use-random /dev/sdx/sdx1`

  3. Unlock the encrypted volume
      `sudo cryptsetup open /dev/sdx/sdx1 dm_name`
      The unlocked partition will be mapped to `/dev/mapper/dm_name`

  4. Create a file system
      `sudo mkfs.ext4 /dev/mapper/dm_name -L volumeLabel`
      Volume label will be the name of the device/volume
      BTRFS can also be used: `mkfs.btrfs`

  5. Close the volume
      `sudo cryptsetup close dm_name`

> 
> Device                                  
> └─> LUKS Encryption                     
>     └─> File System                     
>         └─> Root                        
>             ├─> Directories             
>             └─> Files                   
>


## Openning the volume

  1. Unlock the volume
      `sudo cryptsetup open /dev/sdx/sdx1 dm_name`
      The unlocked partition will be mapped to `/dev/mapper/dm_name`

  2. Mount the device
      `udisksctl mount -b /dev/mapper/dm_name`
      The device will be mounted at `/run/media/user/dm_name` 


## Volume ownership and permission
  - By default, the owner of the encrypted volume is `root:root`
  - To change the owner:
    `sudo chown user:user /run/media/user/dm_name`


## Close the volume
  1. Unmount the volume:
      `udisksctl unmount -b /dev/mapper/dm_name`

  2. Close the volume
      `sudo cryptsetup close dm_name`


>                                                               
>                          ┌╶╶╶╶╶╶╶╶┐                           
>  ┌╶╶╶╶╶╶╶┐   ┌╶╶╶╶╶╶╶┐   ╎        ╎   ┌╶╶╶╶╶╶╶╶┐   ┌╶╶╶╶╶╶╶┐  
>  ╎Unlock ╎╶╶>╎Mount  ╎╶╶>╎  USE   ╎╶╶>╎Unmount ╎╶╶>╎Close  ╎  
>  ╎Volume ╎   ╎Device ╎   ╎        ╎   ╎Device  ╎   ╎Volume ╎  
>  └╶╶╶╶╶╶╶┘   └╶╶╶╶╶╶╶┘   ╎        ╎   └╶╶╶╶╶╶╶╶┘   └╶╶╶╶╶╶╶┘  
>                          └╶╶╶╶╶╶╶╶┘                           



## Manage LUKS passwords and key files:
  1. Change LUKS password:
     `sudo cryptsetup luksChangeKey /dev/sdX1`

  2. Add a new password to LUKS:
     `sudo cryptsetup luksAddKey /dev/sdX1`

  3. Create and add a key file to LUKS:
     `dd if=/dev/urandom of=keyfile bs=1024 count=4`
     `sudo cryptsetup luksAddKey /dev/sdX1 keyfile`
    
  4. Remove a password or key file from LUKS:
     `sudo cryptsetup luksRemoveKey /dev/sdX1`

    
## View all available block devices:
  `lsblk`
