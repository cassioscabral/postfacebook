Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '156023987880730','1fbca9e2cb99ac52d8d3e65fabd84ed4', {:scope => 'email, offline_access', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}} 
end
