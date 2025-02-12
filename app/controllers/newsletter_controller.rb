class NewsletterController < ApplicationController
  allow_unauthenticated_access only: [ :create ]

  def create
    Kit.subscribe(Current.user) if Current.user

    # TODO: Manage subscription if user is not signed in.

    redirect_to root_path
  end
end
