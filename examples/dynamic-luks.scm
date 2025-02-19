(use-modules (gnu)) ;; needed for "device" below
(load (string-append (dirname (current-filename)) "/config-base.scm"))
(operating-system
 (inherit default-os)
 (mapped-devices (let ((mycryptuuid (getenv "LUKS_UUID")))
		   (list
		    (mapped-device
		     (source (uuid mycryptuuid))
		     (targets (list (string-append (getenv "INSTANCE_NAME") "-system_mapped")))
		     (type luks-device-mapping)))))
 (file-systems
  (let* ((mylabel (string-append (getenv "INSTANCE_NAME") "-system")))
    (cons*
     (file-system
      (device (file-system-label mylabel))
      (mount-point "/")
      (dependencies mapped-devices)
      (needed-for-boot? #t)
      (type (getenv "FS_TYPE")))
     %base-file-systems))))
