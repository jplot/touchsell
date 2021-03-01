Rails.application.routes.draw do
  resources :organizations, path: '' do
    resources :nodes, except: %i[index new] do
      get :new
    end
  end

  resolve('Node') { |node| node.parent ? [node.organization, node] : [node.organization, :node] }
end
