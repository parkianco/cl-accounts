;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

;;;; cl-accounts.asd - Account State Management System
;;;;
;;;; Standalone Common Lisp library for Ethereum account abstraction
;;;; including ERC-4337 bundler, EIP-7702 delegation, paymasters,
;;;; and session keys.
;;;;
;;;; Pure Common Lisp - No external dependencies.
;;;; Requires SBCL for threading primitives (sb-thread).
;;;;
;;;; Copyright (c) 2025 Parkian Company LLC
;;;; License: BSD-3-Clause

(asdf:defsystem #:cl-accounts
  :name "cl-accounts"
  :version "0.1.0"
  :author "Parkian Company LLC"
  :license "BSD-3-Clause"
  :description "Account abstraction and state management for Ethereum-compatible blockchains"
  :depends-on ()
  :serial t
  :components ((:file "package")))

(asdf:defsystem #:cl-accounts/test
  :description "Tests for cl-accounts"
  :depends-on (#:cl-accounts)
  :serial t
  :components ((:module "test"
                :components ((:file "test-accounts"))))
  :perform (asdf:test-op (o c)
             (let ((result (uiop:symbol-call :cl-accounts.test :run-tests)))
               (unless result
                 (error "Tests failed")))))
