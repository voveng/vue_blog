# Since we have an API-only Rails app but need to use Trestle admin,
# we need to add necessary middleware for the admin interface.
# This is typically handled by Trestle itself, but in API-only apps
# we may need to explicitly enable sessions and other middleware.

# Rails.application.config.middleware.use ActionDispatch::Cookies
# Rails.application.config.middleware.use ActionDispatch::Session::CookieStore