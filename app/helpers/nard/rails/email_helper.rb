module Nard::Rails::EmailHelper

  # @!group Regexp

  # @see http://rubytips86.hatenablog.com/entry/2014/03/28/135838
  def email_regexp
    /\A[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+@[a-zA-Z0-9][a-zA-Z0-9\.-]+\z/
  end

  def psuedo_email_regexp 
    /@example\.com\Z/
  end

  # @!endgroup

end
