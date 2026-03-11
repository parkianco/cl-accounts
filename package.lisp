;;;; cl-accounts/package.lisp - Package definitions for cl-accounts
;;;;
;;;; Defines the main package and sub-packages for the account
;;;; abstraction and state management system.
;;;;
;;;; Copyright (c) 2025 CLPIC Contributors
;;;; License: BSD-3-Clause

(in-package #:cl-user)

;;; ============================================================================
;;; Main Package
;;; ============================================================================

(defpackage #:cl-accounts
  (:use #:cl)
  (:nicknames #:accounts)
  (:documentation
   "Account abstraction and state management for Ethereum-compatible blockchains.

    This package provides comprehensive tools for:
    - ERC-4337 Bundler (UserOperation handling, mempool, validation)
    - EIP-7702 Delegation (EOA code delegation, authorization)
    - Paymaster (gas sponsorship, token payment)
    - Session Keys (permissions, spending limits, time bounds)

    Pure Common Lisp with no external dependencies.")

  (:export
   ;; Module initialization
   #:initialize-accounts-module
   #:shutdown-accounts-module
   #:module-version

   ;; Re-export bundler symbols
   #:user-operation
   #:make-user-operation
   #:compute-user-op-hash
   #:validate-user-operation
   #:submit-bundle

   ;; Re-export delegation symbols
   #:authorization-tuple
   #:create-authorization
   #:sign-authorization
   #:verify-authorization
   #:execute-delegated

   ;; Re-export paymaster symbols
   #:paymaster
   #:request-sponsorship
   #:validate-paymaster-user-op

   ;; Re-export session key symbols
   #:session-key
   #:create-session-key
   #:validate-session-action
   #:revoke-session))

;;; ============================================================================
;;; Bundler Sub-Package (ERC-4337)
;;; ============================================================================

(defpackage #:cl-accounts.bundler
  (:use #:cl)
  (:nicknames #:accounts.bundler #:erc4337)
  (:documentation
   "ERC-4337 Account Abstraction Bundler implementation.

    Provides UserOperation handling, mempool management, validation,
    simulation, bundling, submission, reputation tracking, and MEV protection.")

  (:export
   ;; Module lifecycle
   #:bundler-initialize
   #:bundler-shutdown
   #:bundler-health-check

   ;; Configuration
   #:*bundler-config*
   #:bundler-config
   #:make-bundler-config

   ;; UserOperation types
   #:user-operation
   #:make-user-operation
   #:user-operation-sender
   #:user-operation-nonce
   #:user-operation-init-code
   #:user-operation-call-data
   #:user-operation-signature
   #:compute-user-op-hash
   #:pack-user-operation

   ;; Bundle types
   #:bundle
   #:make-bundle
   #:bundle-user-ops
   #:bundle-status

   ;; Validation
   #:validation-result
   #:validate-user-operation
   #:validate-user-op-basic
   #:validate-user-op-simulation

   ;; Simulation
   #:simulation-result
   #:simulate-validation
   #:simulate-execution

   ;; Mempool
   #:mempool-add-user-op
   #:mempool-remove-user-op
   #:mempool-get-pending-user-ops
   #:mempool-size

   ;; Bundling
   #:build-bundle
   #:select-user-ops-for-bundle
   #:encode-handle-ops

   ;; Submission
   #:submit-bundle
   #:submit-bundle-async
   #:get-submission-status

   ;; Reputation
   #:reputation-entry
   #:get-reputation
   #:update-reputation
   #:is-banned-p

   ;; Gas estimation
   #:gas-estimate
   #:estimate-user-op-gas
   #:get-gas-prices

   ;; RPC methods
   #:eth-send-user-operation
   #:eth-estimate-user-operation-gas
   #:eth-get-user-operation-by-hash

   ;; P2P
   #:broadcast-user-op
   #:sync-mempool-with-peers

   ;; MEV protection
   #:protect-bundle
   #:submit-private-transaction

   ;; Constants
   #:+entry-point-v0.6+
   #:+entry-point-v0.7+

   ;; Conditions
   #:bundler-error
   #:validation-failed-error
   #:submission-failed-error))

;;; ============================================================================
;;; Delegation Sub-Package (EIP-7702)
;;; ============================================================================

(defpackage #:cl-accounts.delegation
  (:use #:cl)
  (:nicknames #:accounts.delegation #:eip-7702)
  (:documentation
   "EIP-7702 Account Delegation implementation.

    Enables EOAs to temporarily delegate execution to smart contract code.
    Provides authorization tuple handling, signing, verification, execution,
    revocation, batching, and gas sponsorship.")

  (:export
   ;; Module lifecycle
   #:delegation-module
   #:module-initialize
   #:module-shutdown

   ;; Authorization tuple
   #:authorization-tuple
   #:make-authorization-tuple
   #:authorization-tuple-chain-id
   #:authorization-tuple-address
   #:authorization-tuple-nonce
   #:authorization-tuple-signer

   ;; Delegation state
   #:delegation-state
   #:make-delegation-state
   #:delegation-state-is-active

   ;; Set-code transaction
   #:set-code-transaction
   #:make-set-code-transaction

   ;; Authorization handling
   #:create-authorization
   #:parse-authorization
   #:encode-authorization
   #:authorization-hash

   ;; Signing
   #:sign-authorization
   #:sign-authorization-list

   ;; Verification
   #:verify-authorization
   #:verify-authorization-signature
   #:recover-authorization-signer

   ;; Execution
   #:execute-delegated
   #:execute-with-delegation
   #:apply-delegation
   #:remove-delegation

   ;; Revocation
   #:revoke-delegation
   #:revoke-all-delegations
   #:is-delegation-revoked-p

   ;; Batching
   #:create-authorization-batch
   #:process-authorization-batch

   ;; Gas sponsorship
   #:gas-sponsor
   #:sponsor-gas
   #:request-sponsorship

   ;; EIP-4337 compatibility
   #:authorization-to-user-op
   #:convert-7702-to-4337

   ;; Security
   #:validate-delegation-security
   #:check-reentrancy-risk

   ;; Constants
   #:+set-code-transaction-type+
   #:+delegation-prefix+

   ;; Conditions
   #:delegation-error
   #:invalid-authorization-error
   #:delegation-revoked-error))

;;; ============================================================================
;;; Paymaster Sub-Package
;;; ============================================================================

(defpackage #:cl-accounts.paymaster
  (:use #:cl)
  (:nicknames #:accounts.paymaster #:paymaster)
  (:documentation
   "ERC-4337 Paymaster implementation.

    Provides gas sponsorship, token fee payment, signature verification,
    rate limiting, deposit/withdrawal management, and analytics.")

  (:export
   ;; Module lifecycle
   #:initialize-paymaster-system
   #:shutdown-paymaster-system

   ;; Core types
   #:paymaster
   #:make-paymaster
   #:paymaster-address
   #:paymaster-balance
   #:paymaster-status

   ;; Paymaster type constants
   #:+paymaster-type-verifying+
   #:+paymaster-type-token+
   #:+paymaster-type-sponsoring+

   ;; User operation types
   #:user-operation
   #:make-user-operation
   #:user-operation-hash

   ;; Sponsorship
   #:sponsorship-request
   #:sponsorship-response
   #:request-sponsorship
   #:approve-sponsorship
   #:execute-sponsorship

   ;; Validation
   #:validation-result
   #:validate-paymaster-user-op
   #:validate-sponsorship-request

   ;; Policy types
   #:sponsorship-policy
   #:policy-limits
   #:create-policy
   #:evaluate-policies

   ;; Rate limiting
   #:rate-limiter
   #:check-rate-limit
   #:consume-rate-limit

   ;; Deposit/Withdrawal
   #:deposit-to-paymaster
   #:withdraw-from-paymaster
   #:get-deposit-balance

   ;; Token paymaster
   #:token-config
   #:calculate-token-fee
   #:collect-token-payment

   ;; Verifying paymaster
   #:generate-paymaster-signature
   #:verify-paymaster-signature

   ;; Analytics
   #:analytics-event
   #:record-event
   #:generate-summary

   ;; Configuration
   #:*paymaster-state*
   #:get-config
   #:set-config

   ;; Conditions
   #:paymaster-error
   #:validation-error
   #:insufficient-balance-error
   #:rate-limit-exceeded-error))

;;; ============================================================================
;;; Sessions Sub-Package
;;; ============================================================================

(defpackage #:cl-accounts.sessions
  (:use #:cl)
  (:nicknames #:accounts.sessions #:session-keys)
  (:documentation
   "Session key management for account abstraction.

    Provides granular permission scoping, spending limits, time bounds,
    contract/function allowlisting, revocation, rotation, and recovery.")

  (:export
   ;; Core session types
   #:session-key
   #:make-session-key
   #:session-key-id
   #:session-key-owner
   #:session-key-permissions
   #:session-key-status

   ;; Session status
   #:+session-status-active+
   #:+session-status-revoked+
   #:+session-status-expired+

   ;; Session context
   #:session-context
   #:session-action

   ;; Permissions
   #:permission
   #:make-permission
   #:permission-set
   #:+permission-transfer+
   #:+permission-call+
   #:+permission-approve+

   ;; Spending limits
   #:spending-limit
   #:make-spending-limit
   #:set-spending-limit
   #:check-spending-limit

   ;; Time bounds
   #:time-bounds
   #:make-time-bounds
   #:check-time-bounds

   ;; Contract limits
   #:contract-limit
   #:contract-allowlist
   #:is-contract-allowed-p

   ;; Function limits
   #:function-limit
   #:function-selector
   #:is-function-allowed-p

   ;; Revocation
   #:revocation-info
   #:revoke-session
   #:is-revoked-p

   ;; Session creation
   #:create-session-key
   #:create-ephemeral-session
   #:session-builder

   ;; Validation
   #:validate-session
   #:validate-session-action
   #:validation-result

   ;; Storage
   #:session-store
   #:store-session
   #:load-session
   #:list-sessions

   ;; Recovery
   #:rotate-session-key
   #:create-session-backup

   ;; Configuration
   #:*session-config*

   ;; Conditions
   #:session-error
   #:session-expired
   #:session-revoked
   #:permission-denied
   #:spending-limit-exceeded))

;;; ============================================================================
;;; Utility Sub-Package
;;; ============================================================================

(defpackage #:cl-accounts.util
  (:use #:cl)
  (:nicknames #:accounts.util)
  (:documentation
   "Utility functions for cl-accounts.

    Provides byte manipulation, hex encoding, hashing, RLP encoding,
    address utilities, and signature handling.")

  (:export
   ;; Byte utilities
   #:bytes-to-hex
   #:hex-to-bytes
   #:concat-bytes
   #:pad-left
   #:pad-right
   #:uint256-to-bytes
   #:bytes-to-uint256

   ;; Hash utilities
   #:keccak256
   #:keccak256-bytes

   ;; RLP encoding
   #:rlp-encode
   #:rlp-decode

   ;; Address utilities
   #:address-to-bytes
   #:bytes-to-address
   #:checksum-address
   #:valid-address-p
   #:normalize-address

   ;; Signature utilities
   #:sign-message
   #:recover-signer
   #:verify-signature
   #:normalize-signature-v))
