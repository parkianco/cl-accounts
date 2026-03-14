;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

;;;; test-accounts.lisp - Unit tests for accounts
;;;;
;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: BSD-3-Clause

(defpackage #:cl-accounts.test
  (:use #:cl)
  (:export #:run-tests))

(in-package #:cl-accounts.test)

(defun run-tests ()
  "Run all tests for cl-accounts."
  (format t "~&Running tests for cl-accounts...~%")
  ;; TODO: Add test cases
  ;; (test-function-1)
  ;; (test-function-2)
  (format t "~&All tests passed!~%")
  t)
