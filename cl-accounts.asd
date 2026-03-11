;;;; cl-accounts.asd - Account State Management System
;;;;
;;;; Standalone Common Lisp library for Ethereum account abstraction
;;;; including ERC-4337 bundler, EIP-7702 delegation, paymasters,
;;;; and session keys.
;;;;
;;;; Pure Common Lisp - No external dependencies.
;;;; Requires SBCL for threading primitives (sb-thread).
;;;;
;;;; Copyright (c) 2025 CLPIC Contributors
;;;; License: BSD-3-Clause

(asdf:defsystem #:cl-accounts
  :name "cl-accounts"
  :version "1.0.0"
  :author "CLPIC Contributors"
  :license "BSD-3-Clause"
  :description "Account abstraction and state management for Ethereum-compatible blockchains"
  :depends-on ()
  :serial t
  :components ((:file "package")))
