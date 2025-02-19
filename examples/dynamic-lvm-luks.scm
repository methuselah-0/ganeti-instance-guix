(use-modules (gnu)) ;; needed for "device" below
(load (string-append (dirname (current-filename)) "/config-base.scm"))
(operating-system
 (inherit default-os)
 (mapped-devices (let ((myvg (string-append (getenv "INSTANCE_NAME") "_vg01"))
		       (mycryptuuid (getenv "LUKS_UUID")))
		   (list
		    (mapped-device
		     (source (uuid mycryptuuid))
		     (targets (list "cryptroot"))
		     (type luks-device-mapping))
		    (mapped-device
		     (source myvg)
		     (targets (list (string-append myvg "-lv_root")
				    (string-append myvg "-lv_home")
				    (string-append myvg "-lv_gnu_store")
				    (string-append myvg "-lv_var_log")
				    (string-append myvg "-lv_swap")))
		     (type lvm-device-mapping)))))
 (file-systems
  (let* ((mylabel (string-append (getenv "INSTANCE_NAME") "-system"))
	 (%my-filesystems
	  (list
	   (file-system
	    (device (string-append "/dev/" (getenv "INSTANCE_NAME") "_vg01" "/lv_root"))
	    (mount-point "/")
	    (dependencies mapped-devices)
	    (needed-for-boot? #t)
	    (type (getenv "FS_TYPE")))
	   (file-system
	    (device (string-append "/dev/" (getenv "INSTANCE_NAME") "_vg01" "/lv_home"))
	    (mount-point "/home")
	    (dependencies mapped-devices)
	    (needed-for-boot? #t)
	    (type (getenv "FS_TYPE")))
	   (file-system
	    (device (string-append "/dev/" (getenv "INSTANCE_NAME") "_vg01" "/lv_var_log"))
	    (mount-point "/var/log")
	    (dependencies mapped-devices)
	    (needed-for-boot? #t)
	    (type (getenv "FS_TYPE")))
	   (file-system
	    (device (string-append "/dev/" (getenv "INSTANCE_NAME") "_vg01" "/lv_var_lib_mysql"))
	    (mount-point "/var/lib_mysql")
	    (dependencies mapped-devices)
	    (type (getenv "FS_TYPE")))
	   (file-system
	    (device (string-append "/dev/" (getenv "INSTANCE_NAME") "_vg01" "/lv_gnu_store"))
	    (mount-point "/gnu/store")
	    (dependencies mapped-devices)
	    (needed-for-boot? #t)
	    (type (getenv "FS_TYPE"))))))
    (append
     %my-filesystems
     %base-file-systems)))
 (swap-devices
  (list (swap-space
	 (dependencies mapped-devices)
	 (target
	    (file-system-label (string-append (getenv "INSTANCE_NAME") "-swap")))))))
