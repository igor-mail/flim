;;; sasl.el --- basic functions for SASL

;; Copyright (C) 1995, 1996, 1998, 1999 Free Software Foundation, Inc.

;; Author: Kenichi OKADA <okada@opaopa.org>
;; Keywords: SMTP, 

;; This file is part of FLIM (Faithful Library about Internet Message).

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Code:

(require 'hmac-md5)
(require 'hmac-util)

(defun cram-md5-encode (user passphrase response)
  (concat user " "
	  (hmac-hex-string
	   (hmac-md5 response passphrase))))

(defun plain-encode (authorid authenid passphrase)
  (concat authorid "\0" authenid "\0" passphrase))

(provide 'sasl)

;;; smtp.el ends here
