(use-modules (gnu)) ;; needed for "device" below
(load (string-append (dirname (current-filename)) "/config-base.scm"))
(operating-system
 (inherit default-os)
 (file-systems
  (let* ((mylabel (string-append (getenv "INSTANCE_NAME") "-system"))
	 (%my-filesystems
	  (list
	   (file-system
	    (device (file-system-label mylabel))
	    (mount-point "/")
	    (type "btrfs")
	    (options "subvol=/system-root"))
	   (file-system
	    (device (file-system-label mylabel))
	    (mount-point "/gnu/store")
	    (type "btrfs")
	    (options "subvol=system-root/gnu/store"))
	   (file-system
	    (device (file-system-label mylabel))
	    (mount-point "/var/log")
	    (type "btrfs")
	    (options "subvol=system-root/var/log"))
	   (file-system
	    (device (file-system-label mylabel))
	    (mount-point "/var/lib/mysql")
	    (type "btrfs")
	    (options "subvol=system-root/var/lib/mysql"))
	   (file-system
	    (device (file-system-label mylabel))
	    (mount-point "/home")
	    (type "btrfs")
	    (options "subvol=system-root/home"))
	   (file-system
	    (device (file-system-label mylabel))
	    (mount-point "/swap")
	    (needed-for-boot? #t)
	    (type "btrfs")
	    (flags '(no-atime))
	    (options "subvol=/system-root/swap,compress=none")))))
    (append
     %my-filesystems
     %base-file-systems)))
 (swap-devices
  (list (swap-space
	 (target "/swap/swapfile")))))
