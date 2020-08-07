Rails.application.routes.draw do
   
  get 'paginas/inicio', as: 'inicio'

  devise_for :users, path: '', path_names: { sign_in: 'ingresar', sign_out: 'Salir', sign_up: 'registrar'}
  
  resources :internos do
  	resources :ingresos
  	resources :egresos
  	resources :parientes
  	resources :tratamientos
  end

  root to: "paginas#inicio"

end
