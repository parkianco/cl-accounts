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
  :long-description "Comprehensive account management system providing:
  - ERC-4337 Bundler (UserOperation handling, mempool, validation)
  - EIP-7702 Delegation (EOA code delegation, authorization)
  - Paymaster (gas sponsorship, token payment, verification)
  - Session Keys (permissions, spending limits, time bounds)

Pure Common Lisp implementation with no external dependencies.
Designed for SBCL, using sb-thread for concurrency primitives."

  :depends-on ()  ; Pure CL - no external dependencies

  :serial t
  :components
  ((:file "package")
   (:module "src"
    :serial t
    :components
    (;; =====================================================
     ;; Layer 0: Core Utilities
     ;; =====================================================
     (:module "util"
      :serial t
      :components
      ((:file "bytes")
       (:file "hex")
       (:file "hash")
       (:file "rlp")
       (:file "address")
       (:file "signature")))

     ;; =====================================================
     ;; Layer 1: Type Definitions
     ;; =====================================================
     (:module "types"
      :serial t
      :components
      ((:file "account-types")
       (:file "bundler-types")
       (:file "delegation-types")
       (:file "paymaster-types")
       (:file "session-types")))

     ;; =====================================================
     ;; Layer 2: Bundler Module (ERC-4337)
     ;; =====================================================
     (:module "bundler"
      :serial t
      :components
      ((:file "user-operation")
       (:file "mempool")
       (:file "validation")
       (:file "simulation")
       (:file "bundling")
       (:file "submission")
       (:file "reputation")
       (:file "gas-estimation")
       (:file "rpc")
       (:file "p2p")
       (:file "mev-protection")))

     ;; =====================================================
     ;; Layer 3: Delegation Module (EIP-7702)
     ;; =====================================================
     (:module "delegation"
      :serial t
      :components
      ((:file "authorization")
       (:file "signing")
       (:file "verification")
       (:file "execution")
       (:file "revocation")
       (:file "batching")
       (:file "gas-sponsorship")
       (:file "compatibility")
       (:file "security")
       (:file "migration")))

     ;; =====================================================
     ;; Layer 4: Paymaster Module
     ;; =====================================================
     (:module "paymaster"
      :serial t
      :components
      ((:file "interface")
       (:file "validation")
       (:file "sponsorship")
       (:file "token-paymaster")
       (:file "verifying-paymaster")
       (:file "deposit")
       (:file "withdrawal")
       (:file "rate-limiting")
       (:file "policy")
       (:file "analytics")))

     ;; =====================================================
     ;; Layer 5: Session Keys Module
     ;; =====================================================
     (:module "sessions"
      :serial t
      :components
      ((:file "session-key")
       (:file "permissions")
       (:file "spending-limits")
       (:file "time-bounds")
       (:file "contract-limits")
       (:file "function-limits")
       (:file "revocation")
       (:file "storage")
       (:file "recovery")))))))
