(exec-path-from-shell-copy-env "DYLD_LIBRARY_PATH")
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
