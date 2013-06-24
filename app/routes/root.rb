namespace '/' do
  before { @title = 'Hey there!' }
  get do
    erb 'index'
  end
end
