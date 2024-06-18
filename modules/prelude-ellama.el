(require 'use-package)
;; YOU DON'T NEED NONE OF THIS CODE FOR SIMPLE INSTALL
;; IT IS AN EXAMPLE OF CUSTOMIZATION.
(use-package ellama
  :init
  ;; setup key bindings
  (setopt ellama-keymap-prefix "C-c x")
  ;; language you want ellama to translate to
  (setopt ellama-language "English")
  ;; could be llm-openai for example
  (require 'llm-ollama)
  (setopt ellama-provider
	  (make-llm-ollama
	   ;; this model should be pulled to use it
	   ;; value should be the same as you print in terminal during pull
	   :chat-model "codellama:7b-instruct"
	   :embedding-model "codellama:7b-instruct"
	   :default-chat-non-standard-params '(("num_ctx" . 8192))))
  ;; Predefined llm providers for interactive switching.
  ;; You shouldn't add ollama providers here - it can be selected interactively
  ;; without it. It is just example.
  (setopt ellama-providers
		    '(("zephyr" . (make-llm-ollama
				   :chat-model "zephyr:7b-beta-q6_K"
				   :embedding-model "zephyr:7b-beta-q6_K"))
		      ("codegemma" . (make-llm-ollama
				    :chat-model "codegemma:7b-code"
				    :embedding-model "codegemma:7b-code"))
		      ("mixtral" . (make-llm-ollama
				    :chat-model "mixtral:8x7b-instruct-v0.1-q3_K_M"
				    :embedding-model "mixtral:8x7b-instruct-v0.1-q3_K_M"))))
  ;; Naming new sessions with llm
  (setopt ellama-naming-provider
	  (make-llm-ollama
	   :chat-model "llama3:8b-instruct-q8_0"
	   :embedding-model "nomic-embed-text"
	   :default-chat-non-standard-params '(("stop" . ("\n")))))
  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
  ;; Translation llm provider
  (setopt ellama-translation-provider (make-llm-ollama
				       :chat-model "phi3:14b-medium-128k-instruct-q6_K"
				       :embedding-model "nomic-embed-text")))
