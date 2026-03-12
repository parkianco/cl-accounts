# cl-accounts

Account Abstraction and State Management for Common Lisp

## Overview

cl-accounts provides comprehensive Ethereum account abstraction:

- **ERC-4337 Bundler**: UserOperation handling, mempool, validation, bundling
- **EIP-7702 Delegation**: EOA code delegation, authorization tuples
- **Paymaster**: Gas sponsorship, token payment, rate limiting
- **Session Keys**: Granular permissions, spending limits, time bounds

Pure Common Lisp implementation with **no external dependencies**. Requires SBCL.

## Installation

```lisp
;; Clone to your ASDF source registry
(asdf:load-system :cl-accounts)
```

## Quick Start

```lisp
(use-package :cl-accounts)

;; Create and validate a UserOperation
(let ((user-op (make-user-operation
                :sender account-address
                :nonce 0
                :call-data (encode-call "transfer" args))))
  (validate-user-operation user-op))

;; Create a session key with spending limits
(create-session-key owner
  :permissions '(:transfer :call)
  :spending-limit (make-spending-limit :max-per-tx 1000000))
```

## Modules

### Bundler (`cl-accounts.bundler`)

ERC-4337 Account Abstraction bundler:

```lisp
;; Create UserOperation
(let ((user-op (make-user-operation
                :sender sender
                :nonce nonce
                :init-code init-code
                :call-data call-data
                :signature signature)))

  ;; Validate
  (validate-user-operation user-op)

  ;; Add to mempool
  (mempool-add-user-op user-op)

  ;; Build and submit bundle
  (let ((bundle (build-bundle)))
    (submit-bundle bundle)))
```

### Delegation (`cl-accounts.delegation`)

EIP-7702 EOA code delegation:

```lisp
;; Create authorization tuple
(let ((auth (create-authorization
             :chain-id 1
             :address delegate-address
             :nonce nonce)))

  ;; Sign authorization
  (sign-authorization auth private-key)

  ;; Verify
  (verify-authorization auth)

  ;; Execute delegated call
  (execute-delegated auth call-data))
```

### Paymaster (`cl-accounts.paymaster`)

Gas sponsorship and token payment:

```lisp
;; Create paymaster
(let ((pm (make-paymaster
           :address paymaster-address
           :type +paymaster-type-sponsoring+)))

  ;; Request sponsorship
  (request-sponsorship user-op pm)

  ;; Validate paymaster data
  (validate-paymaster-user-op user-op))
```

### Sessions (`cl-accounts.sessions`)

Session key management:

```lisp
;; Create session with permissions
(let ((session (create-session-key owner
                :permissions '(:transfer :approve)
                :spending-limit (make-spending-limit
                                 :max-per-tx 1000000
                                 :max-per-day 10000000)
                :time-bounds (make-time-bounds
                              :valid-from now
                              :valid-until (+ now 86400))
                :contract-limits (list allowed-contracts))))

  ;; Validate action against session
  (validate-session-action session action)

  ;; Revoke when done
  (revoke-session session))
```

## Standards Compliance

- ERC-4337: Account Abstraction Using Alt Mempool
- EIP-7702: Set EOA account code
- ERC-7715: Permission Delegation (Session Keys)
- EIP-1559: Fee market change
- EIP-4844: Shard Blob Transactions (L2 support)
- EIP-712: Typed structured data hashing

## License

BSD-3-Clause. See [LICENSE](LICENSE).

## Origin

