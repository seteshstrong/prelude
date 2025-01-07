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
;; defining org-agenda files
(setq org-agenda-files (list "~/Dropbox/orgfiles/gcal.org"
                             "~/Dropbox/orgfiles/i.org"
                             "~/Dropbox/orgfiles/schedule.org"))
;; define our org-capture templates
(setq org-capture-templates
      '(("a" "Appointment" entry (file  "~/Dropbox/orgfiles/gcal.org" )
         "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
        ("l" "Link" entry (file+headline "~/Dropbox/orgfiles/links.org" "Links")
         "* %? %^L %^g \n%T" :prepend t)
        ("b" "Blog idea" entry (file+headline "~/Dropbox/orgfiles/i.org" "Blog Topics:")
         "* %?\n%T" :prepend t)
        ("t" "To Do Item" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do")
         "* TODO %?\n%u" :prepend t)
        ("n" "Note" entry (file+headline "~/Dropbox/orgfiles/i.org" "Note space")
         "* %?\n%u" :prepend t)
        ("j" "Journal" entry (file+datetree "~/Dropbox/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("s" "Screencast" entry (file "~/Dropbox/orgfiles/screencastnotes.org")
         "* %?\n%i\n")))

;; Crack our secrets vault open
(load "~/.emacs.d/personal/preload/vault.el.gpg")

;; org-gcal setup
(org-gcal-reload-client-id-secret)
(add-to-list 'plstore-encrypt-to 'E10A9B132DD86E93)
