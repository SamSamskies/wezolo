OmniAuth.config.on_failure = Proc.new do |env|
  "SessionController".constantize.action(:omniauth_failure).call(env)
  #this will invoke the omniauth_failure action in SessionController.
end
