(require 'nodejs-repl)
(require 'elnode)
(require 'dashboard)
(require 'org-timeblock)
(require 'request)
(require 'alert)
(require 'persist)
(require 'aio)
(require 'org-gcal)
(require 'plstore)

;; Adjust theme
(disable-theme 'zenburn)
(setq prelude-theme 'modus-operandi)

;; pinentry setup
(setq epg-pinentry-mode 'loopback)

;; save open windows between sessions on close
(setq desktop-dirname         "~/.emacs.d/personal/preload/"
      desktop-base-file-name      "desktop-save"
      desktop-base-lock-name      "lock"
      desktop-path                (list desktop-dirname)
      desktop-save                t
      desktop-files-not-to-save   "^$" ;reload tramp paths
      desktop-load-locked-desktop nil
      desktop-auto-save-timeout   30)
(desktop-read)
(desktop-save-mode 1)

;; auth source configs
(setq auth-source-debug 1)
(setq auth-sources
      '((:source "~/.authinfo.gpg")))

;; Org config tweaks
(global-set-key "\C-cc" 'org-capture)
(add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync) ))
(add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync) ))

;; Crack our secrets vault open
(load "~/.emacs.d/personal/preload/vault.el.gpg")

;; org-gcal setup
(org-gcal-reload-client-id-secret)
(add-to-list 'plstore-encrypt-to 'E10A9B132DD86E93)

;; Org capture templates
  (setq org-capture-templates
        '(("t" "Tasks" entry
           (file+headline "inbox.org" "Tasks")
           "* TODO %^{Task}")
          ("a" "Appointment" entry
           (file "personal/gcal.org")
           "* %?\n :PROPERTIES:\n :calendar-id: me@gmail.com\n :END:\n:org-gcal:\n%^T--%^T\n:END:\n"
           :jump-to-captured t)
          ("d" "Due Date" entry
           (file "personal/gcal.org")
           "* %?\n :PROPERTIES:\n :calendar-id: me@gmail.com\n :END:\n:org-gcal:\n%^T\n:END:\n")
          ("w" "Work Notebooks")
          ("ws" "S-Corp" entry
           (file+olp+datetree "work/work-s-corp.org")
           "* %?"
           :clock-in t
           :clock-keep t
           :time-prompt t
           :immediate-finish t
           :jump-to-captured t)
         ))
