Rails.application.routes.draw do
  mount Api::Base => '/', defaults: { format: 'json' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

