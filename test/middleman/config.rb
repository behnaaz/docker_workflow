require 'bootstrap-sass'
require 'lib/middleman_cucumber/test_env'

Slim::Engine.disable_option_validator!
Slim::Engine.set_default_options :pretty => true
Slim::Engine.set_default_options :shortcut => {
  '#' => {:tag => 'div', :attr => 'id'},
  '.' => {:tag => 'div', :attr => 'class'},
  '&' => {:tag => 'input', :attr => 'type'}
}


###
# Mount Grape API into Middleman (Rack)
###

begin
  if ENV['RACK_ENV'] == 'test' 
    require 'api/config/environment'
    map "/api" do
      run Example::API
    end
  end
end



# set file names
set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'

set :relative_links, false
activate :i18n, langs: [:nl, :en]


activate :test_env

configure :test do
   set :debug_assets, true
end

configure :development do
  set :debug_assets, true
  #activate :livereload
  config[:file_watcher_ignore] += [ /shippable\//, /features\//  ]
end



# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :cache_buster

  # Use relative URLs
  activate :relative_assets

  # Use Gzip
  activate :gzip

end


