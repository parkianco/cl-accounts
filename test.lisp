;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

(load "cl-accounts.asd")
(asdf:load-system :cl-accounts/test)
(asdf:test-system :cl-accounts/test)
(format t "~&✓ Tests passed!~%")
(quit)
